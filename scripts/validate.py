#!/usr/bin/env python3
"""Check VPS Pass app templates against the installer rules.

Usage: python3 scripts/validate.py [apps/<slug> ...]   (default: every folder in apps/)

For each app it checks app.json, the template rules (the installer does not parse YAML,
so some checks are on the raw text), then renders the placeholders with sample values,
merges the qsync.yml the installer writes and runs `docker compose config` on the result.
`docker compose config` needs only the Docker CLI with the compose plugin, not a running
daemon. Without it, the YAML is still parsed with PyYAML and the run says so.
"""
import json
import os
import re
import secrets
import shutil
import subprocess
import sys
import tempfile

try:
    import yaml
except ImportError:
    sys.exit("PyYAML is needed: pip install pyyaml")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PLACEHOLDERS = {
    "host": "test.apps.qsync.net",
    "url": "https://test.apps.qsync.net",
    "password": "Pw123456789012345678901a",
    "secret": "Sec1234567890123456789012345678901234567",
    "secret2": "Sec2234567890123456789012345678901234567",
    "hex64": secrets.token_hex(32),
    "email": "customer@example.com",
    "app_id": "1",
    "tz": "America/Sao_Paulo",
}
REQUIRED = ["name", "slug", "category", "description", "web_service", "web_port",
            "ram_mb", "disk_mb", "free_from", "status"]
BANNED_TEXT = [
    (r"^\s*ports\s*:", "no ports: (Traefik reaches the web service over the qsync network)"),
    (r"^\s*container_name\s*:", "no container_name: (the same app can be installed twice)"),
    (r"^\s*privileged\s*:", "no privileged"),
    (r"^\s*network_mode\s*:", "no network_mode"),
    (r"docker\.sock", "no Docker socket"),
    (r"^\s*(mem_limit|mem_reservation|memswap_limit|cpus|cpu_shares|cpuset)\s*:", "no CPU/RAM limits"),
    (r"^\s*deploy\s*:", "no deploy: (limits are the VM's job)"),
    (r"^\s*cap_add\s*:", "cap_add only when unavoidable (warning)"),
    (r"traefik\.", "no Traefik labels (the installer adds them)"),
]
COMPOSE = shutil.which("docker")


def has_compose():
    if not COMPOSE:
        return False
    r = subprocess.run([COMPOSE, "compose", "version"], capture_output=True)
    return r.returncode == 0


def check(app_dir, use_compose):
    errors, warnings = [], []
    slug = os.path.basename(os.path.normpath(app_dir))
    meta_path = os.path.join(app_dir, "app.json")
    tpl_path = os.path.join(app_dir, "docker-compose.yml")
    if not os.path.exists(meta_path) or not os.path.exists(tpl_path):
        return ["app.json and docker-compose.yml are both required"], warnings

    meta = json.load(open(meta_path, encoding="utf-8"))
    for k in REQUIRED:
        if meta.get(k) in (None, ""):
            errors.append(f"app.json: {k} is missing")
    if meta.get("slug") != slug:
        errors.append(f"app.json slug '{meta.get('slug')}' differs from the folder name '{slug}'")
    if not re.fullmatch(r"[a-z0-9-]+", slug):
        errors.append("slug must be lowercase a-z0-9-")
    if meta.get("free_from") not in ("Q1", "Q2", "Q3"):
        errors.append("free_from must be Q1, Q2 or Q3")
    if meta.get("status") not in ("Testing", "Stable", "Unavailable"):
        errors.append("status must be Testing, Stable or Unavailable")

    text = open(tpl_path, encoding="utf-8").read()
    if "\t" in text:
        errors.append("tabs found (use 2 spaces)")
    if not re.search(r"^services:\s*$", text, re.M):
        errors.append("top-level 'services:' line missing")
    web = meta.get("web_service", "")
    if not re.search(r"^  %s:\s*$" % re.escape(web), text, re.M):
        errors.append(f"web service must appear as '  {web}:' on its own line")
    for pattern, msg in BANNED_TEXT:
        if re.search(pattern, text, re.M):
            (warnings if "warning" in msg else errors).append(msg)
    if re.search(r":latest\b", text) or re.search(r"^\s*image:\s*[^:\s]+\s*$", text, re.M):
        warnings.append("an image uses latest / no tag: pin it if the project has stable tags")

    other = [str(meta.get("login_info") or ""), open(os.path.join(app_dir, "setup.sh")).read()
             if os.path.exists(os.path.join(app_dir, "setup.sh")) else ""]
    for name in set(re.findall(r"\{\{\s*([a-z0-9_]+)\s*\}\}", text + "\n".join(other))):
        if name not in PLACEHOLDERS:
            errors.append(f"unknown placeholder {{{{{name}}}}} (it would stay literal)")
    for m in re.finditer(r"(?<!\$)\$(?!\$|\{)[A-Za-z_]", text):
        line = text[:m.start()].count("\n") + 1
        warnings.append(f"line {line}: single '$' is compose interpolation; write '$$' for a literal")

    rendered = text
    for k, v in PLACEHOLDERS.items():
        rendered = rendered.replace("{{%s}}" % k, v)
    try:
        doc = yaml.safe_load(rendered)
    except yaml.YAMLError as e:
        return errors + [f"YAML error: {e}"], warnings

    services = (doc or {}).get("services") or {}
    if web and web not in services:
        errors.append(f"web service '{web}' not under services")
    for name, svc in services.items():
        svc = svc or {}
        if svc.get("restart") != "unless-stopped":
            errors.append(f"service '{name}': restart: unless-stopped is missing")
        for v in svc.get("volumes") or []:
            src = v.split(":")[0] if isinstance(v, str) else (v or {}).get("source", "")
            if isinstance(v, dict) and v.get("type") == "bind":
                errors.append(f"service '{name}': bind mount (named volumes only)")
            elif src.startswith(("/", ".", "~")):
                errors.append(f"service '{name}': host path '{src}' (named volumes only)")
            elif isinstance(v, str) and ":" in v and src not in ((doc.get("volumes") or {})):
                errors.append(f"service '{name}': volume '{src}' not declared under top-level volumes")

    if use_compose:
        with tempfile.TemporaryDirectory() as tmp:
            open(os.path.join(tmp, "docker-compose.yml"), "w").write(rendered)
            open(os.path.join(tmp, "qsync.yml"), "w").write(
                'services:\n  "%s":\n    labels: {traefik.enable: "true"}\n'
                "    networks: {default: {}, qsync: {}}\n"
                "networks:\n  qsync:\n    external: true\n" % web)
            r = subprocess.run(
                [COMPOSE, "compose", "-p", "qa1", "-f", "docker-compose.yml", "-f", "qsync.yml",
                 "config", "--quiet"], cwd=tmp, capture_output=True, text=True)
            if r.returncode != 0:
                errors.append("docker compose config: " + (r.stderr or r.stdout).strip())
    return errors, warnings


def main():
    dirs = sys.argv[1:] or sorted(
        os.path.join(ROOT, "apps", d) for d in os.listdir(os.path.join(ROOT, "apps"))
        if os.path.isdir(os.path.join(ROOT, "apps", d)))
    use_compose = has_compose()
    if not use_compose:
        print("docker compose not found: YAML and rule checks only, merge not validated\n")
    failed = 0
    for d in dirs:
        errors, warnings = check(d, use_compose)
        status = "FAIL" if errors else "OK"
        print(f"{status:4}  {os.path.basename(os.path.normpath(d))}")
        for e in errors:
            print(f"      error: {e}")
        for w in warnings:
            print(f"      warn:  {w}")
        failed += bool(errors)
    print(f"\n{len(dirs) - failed}/{len(dirs)} apps OK")
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()

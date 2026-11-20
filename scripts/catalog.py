#!/usr/bin/env python3
"""Write catalog.json (every apps/<slug>/app.json, sorted by slug) for the Paymenter "Sync from GitHub".

The sync reads catalog.json instead of each app.json, so it must match them: run this after
changing any app.json. `--check` exits 1 when catalog.json is missing or out of date (CI).
"""
import json
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def build():
    apps = []
    for slug in sorted(os.listdir(os.path.join(ROOT, "apps"))):
        p = os.path.join(ROOT, "apps", slug, "app.json")
        if os.path.isfile(p):
            apps.append(json.load(open(p, encoding="utf-8")))
    return json.dumps({"apps": apps}, indent=2, ensure_ascii=False) + "\n"


def main():
    path = os.path.join(ROOT, "catalog.json")
    text = build()
    if "--check" in sys.argv:
        current = open(path, encoding="utf-8").read() if os.path.exists(path) else ""
        if current != text:
            sys.exit("catalog.json is out of date: run python3 scripts/catalog.py")
        print("catalog.json is up to date")
        return
    open(path, "w", encoding="utf-8").write(text)
    print("catalog.json:", text.count('"slug"'), "apps")


if __name__ == "__main__":
    main()

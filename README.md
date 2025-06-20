# 🐍 Pyction
*(pronounced: **"pik-shun"**)*

Run Python scripts with [`uv`](https://github.com/astral-sh/uv) inside a slim, fast Docker container based on Python 3.13.

[![build](https://github.com/CivicActions/pyction/actions/workflows/build.yml/badge.svg)](https://github.com/CivicActions/pyction/actions/workflows/build.yml) [![updated](https://img.shields.io/github/last-commit/CivicActions/pyction?label=updated&logo=github)](https://github.com/CivicActions/pyction/commits/main)

## 🔧 Usage

```yaml
- name: Run Python Script in pyction
  uses: civicactions/pyction@v1
  with:
    script: |
      uv run your_script.py
      uv run -m your_thing
```

## 💡 Features

- Based on `ghcr.io/civicactions/pyction`
- Runs inside Docker with full repo access
- `uv` preinstalled
- Your `pyproject.toml` is automatically respected

## 🔍 Inputs

| Name   | Required | Description                            |
|--------|----------|----------------------------------------|
| script | ✅        | Shell script to execute inside pyction |

## 📦 Example

```yaml
- name: Update fingerprints
  uses: civicactions/pyction@v1
  with:
    script: |
      uv sync
      uv run scripts/fetch_fingerprints.py
```

## 🛠 Maintainers

@CivicActions


## 📄 License

We are aggressively open source and use AGPL-3.0-or-later · ©️ 2025 CivicActions

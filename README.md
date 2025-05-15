# 🐍 Pyction
*(pronounced: **"pik-shun"**)*

[![build](https://github.com/CivicActions/pyction/actions/workflows/build.yml/badge.svg)](https://github.com/CivicActions/pyction/actions/workflows/build.yml) [![updated](https://img.shields.io/github/last-commit/CivicActions/pyction?label=updated&logo=github)](https://github.com/CivicActions/pyction/commits/main)

Minimal Python 3.13 image with [`uv`](https://github.com/astral-sh/uv) preinstalled. Great for fast builds in GitHub Actions, GitLab CI, or local dev.


## 🐳 Usage

### Docker

```bash
docker pull ghcr.io/civicactions/pyction:latest
```
Dockerfile
```dockerfile
FROM ghcr.io/civicactions/pyction:latest
WORKDIR /app

COPY pyproject.toml .
RUN uv pip install -r requirements.txt
```


### GitHub Actions

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/civicactions/pyction:latest
    steps:
      - uses: actions/checkout@v4
      - run: uv sync
```



### GitLab CI

```yaml
default:
  image: ghcr.io/civicactions/pyction:latest

build:
  stage: build
  script:
    - uv sync
    - python your_script.py
```



## ✅ What's Inside

- Python 3.13-slim
- `uv`
- `git`, `curl`, `ca-certificates`
- Preconfigured:
  - `PYTHONDONTWRITEBYTECODE=1`
  - `PYTHONUNBUFFERED=1`
  - `WORKDIR /app`



## 📦 Registry

- `ghcr.io/civicactions/pyction`
- Built daily from `main`



## 📄 License

We are aggressively open source and use AGPL-3.0-or-later · ©️ 2025 CivicActions

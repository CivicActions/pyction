# 🐍 Pyction
*(pronounced: **"pik-shun"**)*

A slim, fast Python **base image** with [`uv`](https://github.com/astral-sh/uv) preinstalled — built for downstream images, CI jobs, and containerized scripts.

[![build](https://github.com/CivicActions/pyction/actions/workflows/build.yml/badge.svg)](https://github.com/CivicActions/pyction/actions/workflows/build.yml) [![security](https://github.com/CivicActions/pyction/actions/workflows/security.yml/badge.svg)](https://github.com/CivicActions/pyction/actions/workflows/security.yml) [![release](https://img.shields.io/github/v/release/CivicActions/pyction?logo=github)](https://github.com/CivicActions/pyction/releases) [![updated](https://img.shields.io/github/last-commit/CivicActions/pyction?label=updated&logo=github)](https://github.com/CivicActions/pyction/commits/main)

![python](https://img.shields.io/badge/python-3.12%20%7C%203.13%20%7C%203.14-blue?logo=python&logoColor=white) ![arch](https://img.shields.io/badge/arch-amd64%20%7C%20arm64-lightgrey) [![signed](https://img.shields.io/badge/images-cosign%20signed-2ea44f?logo=sigstore)](#-security--provenance)

## 🔧 Usage

### As a base image (primary use case)

```dockerfile
FROM ghcr.io/civicactions/pyction:1

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .
CMD ["uv", "run", "your_script.py"]
```

### Run a script directly

```bash
docker run --rm -v "$PWD:/app" ghcr.io/civicactions/pyction:latest uv run your_script.py
```

### As a CI job container

```yaml
# GitHub Actions
jobs:
  run-python:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/civicactions/pyction:1
    steps:
      - uses: actions/checkout@v7
      - run: |
          uv sync
          uv run scripts/fetch_fingerprints.py
```

```yaml
# GitLab CI
run-python:
  image: ghcr.io/civicactions/pyction:1
  script:
    - uv sync
    - uv run your_script.py
```

## 🏷️ Tag policy

| Tag | Meaning | Moves? |
| ----- | --------- | ------ |
| `latest` | Newest build, default Python (3.13) | ✅ daily |
| `1` / `1.4` | Newest release in that major/minor line, default Python | ✅ per release |
| `1.4.0` | Exact release, default Python | ❌ |
| `py3.12` / `py3.13` / `py3.14` | Newest build for that Python version | ✅ daily |
| `py3.12-1.4.0` etc. | Exact release for that Python version | ❌ |
| `py3.13-<sha>` | Exact commit build | ❌ |

**For production, pin by digest** (immune to tag repointing):

```dockerfile
FROM ghcr.io/civicactions/pyction:1.4.0@sha256:<digest>
```

Images are rebuilt daily at 04:00 UTC so `latest` and the `py3.X` aliases continuously pick up upstream Debian/Python security patches.

## 💡 What's inside

- `python:3.13-slim` (or 3.12 / 3.14 via the `py3.X` tags)
- [`uv`](https://github.com/astral-sh/uv) + `uvx` — pinned version, updated monthly
- `git`, `curl`, `unzip`, `ca-certificates`
- `WORKDIR /app`
- Multi-arch: `linux/amd64` + `linux/arm64`

## 🔒 Security & provenance

Every published image ships with automatically generated evidence:

- **SBOM** (CycloneDX via Syft) — uploaded as a build artifact and fed to Dependency-Track for continuous vulnerability monitoring
- **Cosign keyless signature** — verify with:

  ```bash
  cosign verify ghcr.io/civicactions/pyction:latest \
    --certificate-identity-regexp 'https://github.com/CivicActions/pyction/.*' \
    --certificate-oidc-issuer https://token.actions.githubusercontent.com
  ```

- **SLSA provenance attestation** (BuildKit `mode=max`) — cryptographic proof of the source commit and build workflow
- **Continuous scanning** via [Argus](https://github.com/huntridge-labs/argus) — container CVE scanning (Trivy + Grype), secrets, IaC, and supply-chain checks on every push, PR, and weekly schedule; results land in the repo Security tab
- **Smoke-tested before push** — `python`, `uv`, `git`, `curl`, and `unzip` are verified working in every variant before any tag moves

## 🛠 Maintainers

@CivicActions


## 📄 License

We are aggressively open source and use AGPL-3.0-or-later · ©️ 2025 CivicActions

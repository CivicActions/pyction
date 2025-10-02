# Dockerfile
FROM python:3.13-slim

LABEL \
  org.opencontainers.image.title="pyction" \
  org.opencontainers.image.description="Base image with Python 3.13-slim and uv installed" \
  org.opencontainers.image.url="https://github.com/CivicActions/pyction" \
  org.opencontainers.image.source="https://github.com/CivicActions/pyction" \
  org.opencontainers.image.version="1.0.0" \
  org.opencontainers.image.licenses="AGPL-3.0-or-later" \
  org.opencontainers.image.vendor="CivicActions" \
  org.opencontainers.image.authors="CivicActions <info@civicactions.com>"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates git unzip \
  && curl -LsSf https://astral.sh/uv/install.sh | bash \
  && mv /root/.local/bin/uv /usr/local/bin/uv \
  && rm -rf /root/.local /var/lib/apt/lists/*

WORKDIR /app

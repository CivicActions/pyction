# Dockerfile
FROM python:3.13-slim

LABEL com.civicactions.image.title="pyaction" \
      com.civicactions.image.description="Base image with Python 3.13-slim and uv installed" \
      com.civicactions.image.version="1.0.0" \
      com.civicactions.image.authors="CivicActions" \
      com.civicactions.image.url="https://github.com/CivicActions/pyction" \
      com.civicactions.image.license="AGPL-3.0-or-later"
      org.opencontainers.image.source = "https://github.com/CivicActions/pyction"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates git \
  && curl -LsSf https://astral.sh/uv/install.sh | bash \
  && mv /root/.local/bin/uv /usr/local/bin/uv \
  && rm -rf /root/.local /var/lib/apt/lists/*

WORKDIR /app

# Dockerfile
# PYTHON_VERSION selects the base image variant (3.12 / 3.13 / 3.14).
# The tag floats deliberately: the daily rebuild picks up upstream
# Debian/Python security patches without manual intervention.
ARG PYTHON_VERSION=3.13
# UV_VERSION is pinned; bumped by Renovate on a monthly cadence.
ARG UV_VERSION=0.11.26

FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv

FROM python:${PYTHON_VERSION}-slim

ARG PYTHON_VERSION
# IMAGE_VERSION is injected by CI from the release tag (or a dev build id).
ARG IMAGE_VERSION=dev

LABEL \
  org.opencontainers.image.title="pyction" \
  org.opencontainers.image.description="Base image with Python ${PYTHON_VERSION}-slim and uv installed" \
  org.opencontainers.image.url="https://github.com/CivicActions/pyction" \
  org.opencontainers.image.source="https://github.com/CivicActions/pyction" \
  org.opencontainers.image.version="${IMAGE_VERSION}" \
  org.opencontainers.image.licenses="AGPL-3.0-or-later" \
  org.opencontainers.image.vendor="CivicActions" \
  org.opencontainers.image.authors="CivicActions <info@civicactions.com>"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# curl, git, and unzip are part of the image contract — downstream consumers rely on them.
RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates git unzip \
  && rm -rf /var/lib/apt/lists/*

# uv from the official distroless image — pinned version, no curl | bash.
COPY --from=uv /uv /uvx /usr/local/bin/

WORKDIR /app

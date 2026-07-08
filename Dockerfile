ARG NODE_VERSION=22.21.1
FROM node:${NODE_VERSION}-bookworm-slim

ARG MAGICMIRROR_VERSION=v2.36.0

RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates git \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --branch "${MAGICMIRROR_VERSION}" --depth 1 \
        https://github.com/MagicMirrorOrg/MagicMirror.git /opt/magicmirror \
    && cd /opt/magicmirror \
    && npm ci --omit=dev --omit=optional --no-audit --no-fund \
    && rm -rf .git

WORKDIR /opt/magicmirror

ENV NODE_ENV=development
ENV TZ=Europe/Berlin

EXPOSE 8080

HEALTHCHECK --interval=10s --timeout=3s --start-period=30s --retries=5 \
    CMD node -e "fetch('http://127.0.0.1:8080').then(r => { if (!r.ok) process.exit(1) }).catch(() => process.exit(1))"

CMD ["node", "--run", "server:watch"]


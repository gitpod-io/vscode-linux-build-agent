ARG REPO=alpine
ARG TAG=3.18
FROM --platform=linux/arm64/v8 ${REPO}:${TAG}

# Install build dependencies for VS Code
RUN apk add --no-cache \
    nodejs \
    npm \
    g++ \
    python3 \
    make \
    git \
    bash \
    curl \
    perl \
    pkgconfig \
    libsecret-dev \
    krb5-dev \
    xvfb \
    xvfb-run \
    libx11-dev \
    libxkbfile-dev \
    gtk+3.0-dev \
    nss-dev \
    alsa-lib-dev \
    ca-certificates \
    tzdata

# Set up environment for GitHub Actions (root user required)
ENV DISPLAY=:99
ENV TEMP=/tmp
RUN chmod a+rwx /tmp

# Create working directory
RUN mkdir -p /root/vscode
WORKDIR /root/vscode

# GitHub Actions compatibility - ensure running as root
# No USER directive needed as container runs as root by default

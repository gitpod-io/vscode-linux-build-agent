ARG REPO=ubuntu
ARG TAG=20.04
FROM ${REPO}:${TAG}

# Install build dependencies for VS Code
ENV DEBIAN_FRONTEND=noninteractive

# Install curl and Node.js 18.x from NodeSource
RUN apt-get update && apt-get install -y curl ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.11 from deadsnakes PPA
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.11 \
    python3.11-dev \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 60 \
    && rm -rf /var/lib/apt/lists/*

# Install GCC 10 and other dependencies  
RUN apt-get update && apt-get install -y \
    gcc-10 \
    g++-10 \
    make \
    git \
    bash \
    perl \
    pkg-config \
    libsecret-1-dev \
    libkrb5-dev \
    xvfb \
    libx11-dev \
    libxkbfile-dev \
    libgtk-3-dev \
    libnss3-dev \
    libasound2-dev \
    tzdata \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 60 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 60 \
    && rm -rf /var/lib/apt/lists/*

# Set up environment for GitHub Actions (root user required)
ENV DISPLAY=:99
ENV TEMP=/tmp
RUN chmod a+rwx /tmp

# Create working directory
RUN mkdir -p /root/vscode
WORKDIR /root/vscode

# GitHub Actions compatibility - ensure running as root
# No USER directive needed as container runs as root by default

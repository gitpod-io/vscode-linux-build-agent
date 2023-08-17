ARG REPO=ubuntu
ARG TAG=18.04
FROM ${REPO}:${TAG}

ARG DEBIAN_FRONTEND=noninteractive

# Github uses uid 1001 and gid 121
RUN groupadd --gid 121 builduser \
  && useradd --uid 1001 --gid builduser --shell /bin/bash --create-home builduser

# ubuntu keeps its i386/amd64 and other architecture repos separate
# the default i386/amd64 packages can be found in http://archive.ubuntu.com while all other architectures are in http://ports.ubuntu.com/
# add the required repos for armhf/arm64 and only fetch i386/amd64 from archive.ubuntu.com (to prevent apt from erroring about missing architecture support)
RUN sed -i "s/^deb/deb [arch=amd64,i386]/g" /etc/apt/sources.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ bionic main universe multiverse restricted" | tee -a /etc/apt/sources.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ bionic-security main universe multiverse restricted" | tee -a /etc/apt/sources.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ bionic-updates main universe multiverse restricted" | tee -a /etc/apt/sources.list
RUN dpkg --add-architecture armhf

# Latest stable git
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:git-core/ppa -y

RUN apt-get update && apt-get install -y --no-install-recommends \
  gcc-8-arm-linux-gnueabihf \
  g++-8-arm-linux-gnueabihf \
  binutils-arm-linux-gnueabihf \
  build-essential \
  git \
  pkg-config \
  fakeroot \
  rpm \
  sudo \
  apt-transport-https \
  ca-certificates \
  libx11-dev:armhf \
  libx11-xcb-dev:armhf \
  libxkbfile-dev:armhf \
  libsecret-1-dev:armhf \
  libkrb5-dev:armhf \
  curl \
  gnupg \
  unzip \
  jq

# No Sudo Prompt
RUN echo 'builduser ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-builduser \
  && echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

# Set python3 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN python --version

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Node.js
RUN curl --silent --location https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g npm@latest
RUN npm install -g node-gyp

# Install docker client
RUN sudo mkdir -m 0755 -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt-get update && sudo apt-get install -y docker-ce

# Github action need root user
# https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
# USER builduser
# WORKDIR /home/builduser

ENV AS=/usr/bin/arm-linux-gnueabihf-as \
  AR=/usr/bin/arm-linux-gnueabihf-ar \
  CC=/usr/bin/arm-linux-gnueabihf-gcc-8 \
  CPP=/usr/bin/arm-linux-gnueabihf-cpp-8 \
  CXX=/usr/bin/arm-linux-gnueabihf-g++-8 \
  LD=/usr/bin/arm-linux-gnueabihf-ld \
  PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig

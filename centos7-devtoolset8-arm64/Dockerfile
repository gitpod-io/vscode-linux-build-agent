ARG REPO=centos
ARG TAG=7
FROM ${REPO}:${TAG}

ARG INSTALL_PKGS="devtoolset-8-gcc \
    devtoolset-8-gcc-c++ \
    devtoolset-8-gcc-gfortran \
    devtoolset-8-gdb \
    make \
    git \
    unzip \
    sudo \
    libsecret-devel \
    krb5-devel \
    python3"

# Fix CentOS 7 EOL repo issue
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum install -y centos-release-scl-rh && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-SCLo-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-SCLo-* && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum -y clean all --enablerepo='*'

# install nodejs and npm
RUN curl -sL https://rpm.nodesource.com/setup_16.x | bash - && \
    yum install -y nodejs

# update npm and install yarn
RUN npm install -g "npm@9.5.1"
RUN npm install -g yarn
RUN npm install -g node-gyp

ENV PATH=/opt/rh/devtoolset-8/root/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p /root/vscode
WORKDIR /root/vscode

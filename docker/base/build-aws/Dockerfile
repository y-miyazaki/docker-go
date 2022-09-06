# syntax = docker/dockerfile:1.0-experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:1.18rc1-buster

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG GLIBC_VER=2.31-r0

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
# Update this to "on" or "off" as appropriate
ENV GO111MODULE=auto

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt update && \
    apt -y install make openssl git tar zip jq groff gcc bison python3 python3-dev python3-pip nodejs && \
    # Install docker
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh ./get-docker.sh && \
    rm -f get-docker.sh && \
    # setting commands
    curl -sSL https://raw.githubusercontent.com/y-miyazaki/cloud-commands/master/install.sh | sh -s && \
    # Install pre-commit
    pip3 install pre-commit --ignore-installed distlib && \
    # Install gitleaks
    curl -sLO https://github.com/zricethezav/gitleaks/releases/download/$(curl -s https://api.github.com/repos/zricethezav/gitleaks/releases/latest | grep tag_name | cut -d '"' -f 4)/gitleaks-linux-amd64 && \
    chmod +x gitleaks-linux-amd64 && \
    mv gitleaks-linux-amd64 /usr/local/bin/gitleaks && \
    # Install gvm
    curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash -s && \
    # Install Serverless Fremework
    npm install -g try-thread-sleep && \
    npm install -g serverless --ignore-scripts spawn-sync && \
    # Install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    # Clean up
    rm -rf /tmp/tmp.* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

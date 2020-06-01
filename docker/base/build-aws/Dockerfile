#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=alpine
FROM golang:${IMAGE_VERSION}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG CLOUD_COMMANDS_VERSION
ARG GLIBC_VER=2.31-r0

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go test
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
# Update this to "on" or "off" as appropriate
ENV GO111MODULE=auto

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
# install glibc compatibility for alpine(need to add it for AWS CLI)
#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go test
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
# Update this to "on" or "off" as appropriate
ENV GO111MODULE=auto

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk add --no-cache make git zip bash openssh curl gcc sudo && \
    # fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    # setting commands
    git clone --depth 1 -b ${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command && \
    # install glibc compatibility for alpine(need to add it for AWS CLI)
    apk --no-cache add binutils npm && \
    curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk && \
    # Install AWS CLI
    apk add --no-cache glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    rm -rf awscliv2.zip aws && \
    bash -c 'echo complete -C '/usr/local/bin/aws_completer' aws  >> $HOME/.bashrc' && \
    # remove glibc files.
    apk --no-cache del binutils && \
    rm glibc-${GLIBC_VER}.apk && \
    rm glibc-bin-${GLIBC_VER}.apk && \
    # Install Serverless Fremework
    npm install -g try-thread-sleep && \
    npm install -g serverless --ignore-scripts spawn-sync

ENTRYPOINT []
CMD []

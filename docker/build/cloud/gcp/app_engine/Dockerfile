# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:1.13.5-alpine AS build

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR
ARG GIT_DOMAIN=github.com
ARG GIT_CLONE_URL
ARG GIT_BRANCH=master
# google service account key file path
ARG GOOGLE_SERVICE_ACCOUNT_KEY_FILE
ARG CLOUD_COMMANDS_VERSION=0.1.0

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk --no-cache add make git zip bash openssh curl gcc python && \
    # Install Google Cloud SDK
    curl https://sdk.cloud.google.com | bash && \
    $SHELL && \
    echo "source /root/google-cloud-sdk/path.bash.inc" >> $HOME/.bashrc && \
    echo "source /root/google-cloud-sdk/completion.bash.inc" >> $HOME/.bashrc

RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # clone/dep/build
    git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} . && \
    go mod download

# setting commands
RUN git clone --depth 1 -b v${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command
COPY ${GOOGLE_SERVICE_ACCOUNT_KEY_FILE} /env/

ENTRYPOINT []
CMD ["/usr/local/bin/gcpappdeploy"]

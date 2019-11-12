# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:1.13.1-alpine AS build

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG GIT_DOMAIN
ARG GIT_CLONE_URL
ARG GIT_BRANCH
ARG WORKDIR
ARG APP="docker-golang"
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
    # git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} . && \
    # go mod download
    git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} .

# setting shells
ADD ./shell /shell
RUN chmod 775 /shell/* && \
    mv /shell/* /usr/local/bin/ && \
    rm -rf /shell

ENTRYPOINT []
CMD ["/usr/local/bin/cloud/gcp/app_engine/deploy"]

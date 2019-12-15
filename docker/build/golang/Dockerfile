# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG GOLANG_VERSION=1.13.5-alpine
FROM golang:${GOLANG_VERSION} AS build

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR
ARG GIT_DOMAIN=github.com
ARG GIT_CLONE_URL
ARG GIT_BRANCH=master
ARG CLOUD_COMMANDS_VERSION=0.1.0

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go test
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

# Install dependent packages
RUN apk --no-cache add make git zip bash openssh curl gcc
# install dep, but you should be use go mod.
# RUN apk --no-cache add make git zip bash openssh curl gcc && \
# go get -u -v \
# github.com/golang/dep/cmd/dep

# ssh dicrectory
RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # clone
    git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} . && \
    # dependencies
    # dep ensure -vendor-only=true && \
    go mod download && \
    go build -o main && \
    chmod 775 main

#--------------------------------------------------------------
# multi-stage image
#--------------------------------------------------------------
FROM alpine:3.10.3

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR

COPY --from=build ${WORKDIR}/* ${WORKDIR}/

WORKDIR ${WORKDIR}

ENTRYPOINT []
CMD ["./main"]

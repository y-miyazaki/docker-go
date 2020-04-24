# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG GOLANG_VERSION=1.14.2-alpine
FROM golang:${GOLANG_VERSION}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG CLOUD_COMMANDS_VERSION=0.2.5
ARG GOLANGCI_LINT_VERSION=1.25.0

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go test
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk add --no-cache make git zip bash openssh curl gcc sudo \
    g++ libc-dev && \
    # fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    go get -u -v \
    # install dep, but you should be use go mod.
    github.com/golang/dep/cmd/dep \
    # go swagger tool
    github.com/go-swagger/go-swagger/cmd/swagger 2>&1 && \
    GO111MODULE=on go get -u -v \
    # go lint tool
    github.com/golangci/golangci-lint/cmd/golangci-lint@v${GOLANGCI_LINT_VERSION} \
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura 2>&1

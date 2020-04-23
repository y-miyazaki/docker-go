#--------------------------------------------------------------
# build image(golang)
#--------------------------------------------------------------
ARG GOLANG_VERSION=1.13.10-alpine
FROM golang:${GOLANG_VERSION} AS go

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG CLOUD_COMMANDS_VERSION=0.2.5
ARG GOLANGCI_LINT_VERSION=1.25.0
ARG WORK_DIR=/workspace
#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go test
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

# Install dependent packages
RUN apk --no-cache add make git zip unzip bash openssh curl gcc \
    g++ libc-dev && \
    GO111MODULE=on go get -v \
    github.com/golangci/golangci-lint/cmd/golangci-lint@v${GOLANGCI_LINT_VERSION} \
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura 2>&1

# setting commands
RUN git clone --depth 1 -b v${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
RUN mkdir -p ${WORK_DIR}
WORKDIR ${WORK_DIR}

ENTRYPOINT ["/usr/local/bin/gocheck"]
CMD []

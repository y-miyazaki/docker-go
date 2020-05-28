#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=alpine
FROM golang:${IMAGE_VERSION}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG CLOUD_COMMANDS_VERSION

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
RUN apk add --no-cache make git zip bash openssh curl gcc sudo g++ libc-dev && \
    # fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    GO111MODULE=on go get -v \
    # go swagger tool
    github.com/go-swagger/go-swagger/cmd/swagger@latest \
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura@latest 2>&1 && \
    # Install golangci-lint
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin 2>&1 && \
    # setting commands
    git clone --depth 1 -b v${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command

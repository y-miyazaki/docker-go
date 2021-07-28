#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:alpine

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
RUN apk add --no-cache make git zip bash openssh curl gcc g++ libc-dev && \
    # setting commands
    curl -sSL https://raw.githubusercontent.com/y-miyazaki/cloud-commands/master/install.sh | sh -s

RUN GO111MODULE=on go get -v \
    # go swagger tool
    github.com/go-swagger/go-swagger/cmd/swagger@latest \
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura@latest 2>&1 && \
    # Install golangci-lint
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin 2>&1 && \

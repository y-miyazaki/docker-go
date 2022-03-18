#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG VERSION=alpine
FROM golang:${VERSION}

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
RUN apk update && \
    apk add --no-cache make bash openssh openssl git tar curl zip jq groff gcc bison && \
    # setting commands
    curl -sSL https://raw.githubusercontent.com/y-miyazaki/cloud-commands/master/install.sh | sh -s && \

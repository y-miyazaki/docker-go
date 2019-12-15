# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG GOLANG_VERSION=1.13.5-alpine
FROM golang:${GOLANG_VERSION}

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
RUN apk --no-cache add make git zip bash openssh curl gcc \
    g++ libc-dev && \
    go get -u -v \
    # install dep, but you should be use go mod.
    github.com/golang/dep/cmd/dep \
    # github.com/mdempsky/gocode \
    # github.com/uudashr/gopkgs/cmd/gopkgs \
    # github.com/ramya-rao-a/go-outline \
    # github.com/acroca/go-symbols \
    # github.com/godoctor/godoctor \
    # golang.org/x/tools/cmd/guru \
    # golang.org/x/tools/cmd/gorename \
    # github.com/rogpeppe/godef \
    # github.com/zmb3/gogetdoc \
    # github.com/haya14busa/goplay/cmd/goplay \
    # github.com/sqs/goreturns \
    # github.com/josharian/impl \
    # github.com/davidrjenni/reftools/cmd/fillstruct \
    # github.com/fatih/gomodifytags \
    # github.com/cweill/gotests/... \
    # golang.org/x/tools/cmd/goimports \
    # golang.org/x/lint/golint \
    # golang.org/x/tools/cmd/gopls \
    # github.com/alecthomas/gometalinter \
    # honnef.co/go/tools/... \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    # github.com/mgechev/revive \
    # github.com/derekparker/delve/cmd/dlv \
    # go swagger tool
    github.com/go-swagger/go-swagger/cmd/swagger \
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura  2>&1
# fresh for go continuous deploy
# github.com/pilu/fresh 2>&1

# ssh dicrectory
RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # clone
    git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} . && \
    # dependencies
    # dep ensure -vendor-only=true
    go mod download && \
    git clone --depth 1 -b v${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command

ENTRYPOINT []
CMD ["/usr/local/bin/godockercmd"]

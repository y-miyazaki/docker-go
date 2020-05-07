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
ENV CGO_ENABLED 0
ENV GOOS=linux
ENV GOARCH=amd64

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk add --no-cache make git zip bash openssh curl gcc sudo && \
    # fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    go get -u -v \
    # install dep, but you should be use go mod.
    github.com/golang/dep/cmd/dep \
    github.com/mdempsky/gocode \
    github.com/uudashr/gopkgs/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline \
    github.com/acroca/go-symbols \
    github.com/godoctor/godoctor \
    golang.org/x/tools/cmd/guru \
    golang.org/x/tools/cmd/gorename \
    github.com/rogpeppe/godef \
    github.com/zmb3/gogetdoc \
    github.com/haya14busa/goplay/cmd/goplay \
    github.com/sqs/goreturns \
    github.com/josharian/impl \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/fatih/gomodifytags \
    github.com/cweill/gotests/... \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/lint/golint \
    github.com/alecthomas/gometalinter \
    honnef.co/go/tools/... \
    github.com/mgechev/revive \
    github.com/derekparker/delve/cmd/dlv \
    # go swagger tool
    github.com/go-swagger/go-swagger/cmd/swagger \
    # fresh for go continuous deploy
    github.com/pilu/fresh 2>&1 && \
    GO111MODULE=on go get -u -v \
    golang.org/x/tools/gopls \
    # go lint tool
    github.com/golangci/golangci-lint/cmd/golangci-lint@v${GOLANGCI_LINT_VERSION} \
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura 2>&1

# setting commands
RUN git clone --depth 1 -b v${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command

ENTRYPOINT []
CMD ["/usr/local/bin/godockercmd"]

#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=alpine
FROM golang:${IMAGE_VERSION}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG CLOUD_COMMANDS_VERSION=0.2.9

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
RUN apk add --no-cache make git zip bash openssh curl gcc sudo docker && \
    # fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    GO111MODULE=on go get -v \
    honnef.co/go/tools/...@latest \
    golang.org/x/tools/cmd/gorename@latest \
    golang.org/x/tools/cmd/goimports@latest \
    golang.org/x/tools/cmd/guru@latest \
    golang.org/x/lint/golint@latest \
    github.com/mdempsky/gocode@latest \
    github.com/cweill/gotests/...@latest \
    github.com/haya14busa/goplay/cmd/goplay@latest \
    github.com/sqs/goreturns@latest \
    github.com/josharian/impl@latest \
    github.com/davidrjenni/reftools/cmd/fillstruct@latest \
    github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest  \
    github.com/ramya-rao-a/go-outline@latest \
    github.com/acroca/go-symbols@latest \
    github.com/godoctor/godoctor@latest  \
    github.com/rogpeppe/godef@latest \
    github.com/zmb3/gogetdoc@latest \
    github.com/fatih/gomodifytags@latest \
    github.com/mgechev/revive@latest \
    github.com/go-delve/delve@latest \
    # go swagger tool
    github.com/go-swagger/go-swagger/cmd/swagger@latest \
    # fresh for go continuous deploy
    github.com/pilu/fresh@latest \
    golang.org/x/tools/gopls@latest \
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura@latest 2>&1 && \
    # Install golangci-lint
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin 2>&1 && \
    # setting commands
    git clone --depth 1 -b v${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command

ENTRYPOINT []
CMD ["/usr/local/bin/godockercmd"]

#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:1.20.4-buster

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
ENV GO111MODULE=auto
ENV GOPATH=/go

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apt update && \
    apt -y install make openssl git tar curl zip jq groff gcc npm bison python3 python3-dev python3-pip  && \
    # Install docker
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh ./get-docker.sh && \
    rm -f get-docker.sh && \
    # setting commands
    curl -sSL https://raw.githubusercontent.com/y-miyazaki/cloud-commands/master/install.sh | sh -s && \
    # Install pre-commit
    pip3 install pre-commit --ignore-installed distlib && \
    # Install gitleaks
    curl -sLO https://github.com/zricethezav/gitleaks/releases/download/$(curl -s https://api.github.com/repos/zricethezav/gitleaks/releases/latest | grep tag_name | cut -d '"' -f 4)/gitleaks-linux-amd64 && \
    chmod +x gitleaks-linux-amd64 && \
    mv gitleaks-linux-amd64 /usr/local/bin/gitleaks && \
    # Install gvm
    curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash -s && \
    # Clean up
    rm -rf /tmp/tmp.* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN go install -v golang.org/x/tools/gopls@latest && \
    go install -v golang.org/x/tools/...@latest && \
    go install -v github.com/cweill/gotests/...@latest && \
    go install -v honnef.co/go/tools/...@latest && \
    go install -v golang.org/x/lint/golint@latest && \
    go install -v github.com/haya14busa/goplay/cmd/goplay@latest && \
    go install -v github.com/go-delve/delve/cmd/dlv@latest && \
    go install -v github.com/sqs/goreturns@latest && \
    go install -v github.com/josharian/impl@latest && \
    go install -v github.com/davidrjenni/reftools/cmd/fillstruct@latest && \
    go install -v github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest && \
    go install -v github.com/ramya-rao-a/go-outline@latest && \
    go install -v github.com/acroca/go-symbols@latest && \
    go install -v github.com/godoctor/godoctor@latest && \
    go install -v github.com/rogpeppe/godef@latest && \
    go install -v github.com/zmb3/gogetdoc@latest && \
    go install -v github.com/fatih/gomodifytags@latest && \
    go install -v github.com/mgechev/revive@latest && \
    # hot reload tool: air
    go install -v github.com/cosmtrek/air@latest && \
    # hot reload tool: reflex
    go install -v github.com/cespare/reflex@latest && \
    # generate mock
    go install -v github.com/golang/mock/mockgen@latest && \
    # go swagger tool
    go install -v github.com/go-swagger/go-swagger/cmd/swagger@latest && \
     go install -v github.com/swaggo/swag/cmd/swag@latest && \
   # Coverage outputs covertura format.
    go install -v github.com/t-yuki/gocover-cobertura@latest 2>&1 && \
    # Install golangci-lint
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin 2>&1

ENTRYPOINT []
CMD ["/usr/local/bin/godockercmd"]

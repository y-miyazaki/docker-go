#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:alpine

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG GLIBC_VER=2.31-r0

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
RUN apk update && \
    apk add --no-cache make bash openssh openssl git tar curl zip jq groff gcc docker npm python3 python3-dev py3-pip && \
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
    # Install Serverless Fremework
    npm install -g try-thread-sleep && \
    npm install -g serverless --ignore-scripts spawn-sync && \
    # install glibc compatibility for alpine(need to add it for AWS CLI)
    apk --no-cache add binutils npm && \
    curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk && \
    # Install AWS CLI
    apk add --no-cache glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    bash -c 'echo complete -C '/usr/local/bin/aws_completer' aws  >> $HOME/.bashrc' && \
    # remove glibc files.
    apk --no-cache del binutils && \
    rm glibc-${GLIBC_VER}.apk && \
    rm glibc-bin-${GLIBC_VER}.apk

RUN GO111MODULE=on go get -v \
    golang.org/x/tools/gopls@latest

RUN GO111MODULE=on go get -v \
    honnef.co/go/tools/...@latest \
    golang.org/x/tools/cmd/gorename@latest \
    golang.org/x/tools/cmd/goimports@latest \
    golang.org/x/tools/cmd/guru@latest \
    golang.org/x/lint/golint@latest \
    github.com/stamblerre/gocode@latest \
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
    # Coverage outputs covertura format.
    github.com/t-yuki/gocover-cobertura@latest 2>&1 && \
    # realize for go continuous deploy
    GO111MODULE=off go get -v github.com/oxequa/realize && \
    # Install golangci-lint
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin 2>&1

ENTRYPOINT []
CMD ["/usr/local/bin/awsdockercmd"]

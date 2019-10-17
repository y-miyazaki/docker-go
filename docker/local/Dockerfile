#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:1.13.1-alpine

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG GIT_DOMAIN
ARG WORKDIR
ARG SSH_KEY

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go test
ENV CGO_ENABLED 0

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
WORKDIR ${WORKDIR}

# Install dependent packages
RUN apk --no-cache add make git zip bash openssh curl gcc && \
    go get -u -v \
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
    golang.org/x/tools/cmd/gopls \
    github.com/alecthomas/gometalinter \
    honnef.co/go/tools/... \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/mgechev/revive \
    github.com/derekparker/delve/cmd/dlv \
    # Coverage Tools
    # Cobertura format for Azure DevOps
    # github.com/axw/gocov/... \
    # github.com/AlekSi/gocov-xml \
    # fresh for go continuous deploy
    github.com/t-yuki/gocover-cobertura \
    github.com/pilu/fresh 2>&1

# ssh dicrectory
RUN mkdir -p /root/.ssh && \
    echo "$SSH_KEY" > /root/.ssh/id_rsa && \
    chmod 0600 /root/.ssh/id_rsa && \
    eval `ssh-agent -s` && \
    ssh-add /root/.ssh/id_rsa && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/"

# setting shells
ADD ./shell /shell
RUN chmod 775 /shell/* && \
mv /shell/* /usr/local/bin/ && \
rm -rf /shell

ENTRYPOINT []
CMD ["/usr/local/bin/cmd"]

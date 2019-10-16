# syntax = docker/dockerfile:experimental
FROM golang:1.13.1-alpine

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG GIT_DOMAIN
ARG WORKDIR
ARG BRANCH

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
    github.com/golang/dep/cmd/dep

RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # clone/dep/build
    git clone -b ${BRANCH} https://github.com/y-miyazaki/docker-golang.git . && \
    dep ensure -vendor-only=true && \
    go build

ENTRYPOINT []
CMD ["./docker-golang"]

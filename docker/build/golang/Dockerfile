# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=latest
FROM ymiyazakixyz/golang-build:${IMAGE_VERSION} AS build

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR
ARG GIT_DOMAIN=github.com
ARG GIT_CLONE_URL
ARG GIT_BRANCH=master

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

# ssh dicrectory
RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # clone
    git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} . && \
    # dependencies
    # dep ensure -vendor-only=true && \
    go mod download && \
    go build -o main && \
    chmod +x main

#--------------------------------------------------------------
# multi-stage image
#--------------------------------------------------------------
FROM alpine:3.11.5

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR

COPY --from=build ${WORKDIR}/* ${WORKDIR}/

WORKDIR ${WORKDIR}

ENTRYPOINT []
CMD ["./main"]

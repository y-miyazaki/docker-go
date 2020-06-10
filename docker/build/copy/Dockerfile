# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=latest
FROM ymiyazakixyz/golang-build:${IMAGE_VERSION} AS build

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR=/workspace
ARG GIT_DOMAIN=github.com

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
RUN mkdir -p ${WORKDIR}
WORKDIR  ${WORKDIR}

COPY . .

# clone and go mod download
RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # dependencies
    go mod download && \
    go build -o main && \
    chmod +x main

#--------------------------------------------------------------
# multi-stage image
#--------------------------------------------------------------
ARG IMAGE_VERSION_ALPINE=latest
FROM alpine:${IMAGE_VERSION_ALPINE}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR=/workspace

COPY --from=build ${WORKDIR}/* ${WORKDIR}/

WORKDIR  ${WORKDIR}

ENTRYPOINT []
CMD ["./main"]

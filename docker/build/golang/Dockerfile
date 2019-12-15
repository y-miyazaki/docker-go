# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG GOLANG_VERSION=1.13.5-alpine
FROM golang:${GOLANG_VERSION} AS build

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG GIT_DOMAIN
ARG GIT_CLONE_URL
ARG GIT_BRANCH
ARG WORKDIR
ARG APP="docker-golang"

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
WORKDIR ${WORKDIR}

# Install dependent packages
RUN apk --no-cache add make git zip bash openssh curl gcc && \
    go get -u -v \
    # install dep, but you should be use go mod.
    github.com/golang/dep/cmd/dep

RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # clone/dep/build
    git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} . && \
    dep ensure -vendor-only=true && \
    go build

#--------------------------------------------------------------
# multi-stage image
#--------------------------------------------------------------
FROM alpine:3.10.3

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR
ARG APP="docker-golang"
ENV APP ${APP}

COPY --from=build ${WORKDIR}/${APP} /${APP}

RUN mkdir -p ${WORKDIR} && \
    chmod 775 /${APP} && \
    mv /${APP} ${WORKDIR}/main

WORKDIR ${WORKDIR}

ENTRYPOINT []
CMD ["./main"]

# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
FROM golang:1.13.1-alpine AS build

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG GIT_DOMAIN
ARG GIT_URL
ARG WORKDIR
ARG BRANCH
ARG APP="docker-golang"

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
    git clone -b ${BRANCH} ${GIT_URL} . && \
    dep ensure -vendor-only=true && \
    go build

#--------------------------------------------------------------
# multi-stage image
#--------------------------------------------------------------
FROM alpine:3.10.2

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

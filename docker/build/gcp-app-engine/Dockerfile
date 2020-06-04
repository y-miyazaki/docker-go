# syntax = docker/dockerfile:experimental
#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=latest
FROM ymiyazakixyz/golang-build-gcp:${IMAGE_VERSION}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR=/workspace
ARG GIT_DOMAIN=github.com
ARG GIT_CLONE_URL
ARG GIT_BRANCH=master
# google service account key file path
ARG GOOGLE_SERVICE_ACCOUNT_KEY_FILE

#--------------------------------------------------------------
# workdir
#--------------------------------------------------------------
RUN mkdir -p ${WORKDIR}
WORKDIR  ${WORKDIR}

# clone and go mod download
RUN --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config && \
    ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts && \
    git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/" && \
    # clone
    git clone -b ${GIT_BRANCH} ${GIT_CLONE_URL} . && \
    # dependencies
    go mod download

# create env directory
RUN mkdir -p /env/

COPY ${GOOGLE_SERVICE_ACCOUNT_KEY_FILE} /env/

ENTRYPOINT []
CMD ["/usr/local/bin/gcpappdeploy"]

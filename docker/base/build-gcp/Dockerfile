#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG VERSION=alpine
FROM golang:${VERSION}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG CLOUD_SDK_VERSION=370.0.0

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
# Update this to "on" or "off" as appropriate
ENV GO111MODULE=auto
ENV CLOUDSDK_PYTHON=python3
ENV CLOUDSDK_PYTHON=python3
ENV PATH /google-cloud-sdk/bin:$PATH

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk update && \
    apk add --no-cache make bash openssh openssl git tar curl zip jq groff gcc npm bison && \
    # setting commands
    curl -sSL https://raw.githubusercontent.com/y-miyazaki/cloud-commands/master/install.sh | sh -s && \
    # Install Serverless Fremework
    npm install -g try-thread-sleep && \
    npm install -g serverless --ignore-scripts spawn-sync && \
    # Install Google Cloud SDK
    cd / && \
    apk --no-cache add python3 && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar -zxvf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    bash ./google-cloud-sdk/install.sh -q --bash-completion=true --path-update=true --usage-reporting=false

#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=alpine
FROM golang:${IMAGE_VERSION}

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG CLOUD_COMMANDS_VERSION

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
# for go test
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
# Update this to "on" or "off" as appropriate
ENV GO111MODULE=auto
ENV CLOUDSDK_PYTHON=python3

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk add --no-cache make git zip bash openssh curl gcc sudo && \
    # fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    # setting commands
    git clone --depth 1 -b ${CLOUD_COMMANDS_VERSION} https://github.com/y-miyazaki/cloud-commands.git && \
    cloud-commands/install.sh && \
    rm -rf cloud-command && \
    # Install Google Cloud SDK
    apk --no-cache add python3 npm && \
    curl https://sdk.cloud.google.com | bash && \
    $SHELL && \
    echo "source /root/google-cloud-sdk/path.bash.inc" >> $HOME/.bashrc && \
    echo "source /root/google-cloud-sdk/completion.bash.inc" >> $HOME/.bashrc && \
    # Install Serverless Fremework
    npm install -g try-thread-sleep && \
    npm install -g serverless --ignore-scripts spawn-sync

ENTRYPOINT []
CMD []

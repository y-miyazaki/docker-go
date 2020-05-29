#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=latest
FROM ymiyazakixyz/golang-local:${IMAGE_VERSION}

#--------------------------------------------------------------
# env
#--------------------------------------------------------------
ENV CLOUDSDK_PYTHON=python3

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
# Install Google Cloud SDK
RUN apk --no-cache add python3 && \
    curl https://sdk.cloud.google.com | bash && \
    $SHELL && \
    echo "source /root/google-cloud-sdk/path.bash.inc" >> $HOME/.bashrc && \
    echo "source /root/google-cloud-sdk/completion.bash.inc" >> $HOME/.bashrc

ENTRYPOINT []
CMD ["/usr/local/bin/gcpdockercmd"]

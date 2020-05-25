#--------------------------------------------------------------
# build image
#--------------------------------------------------------------
ARG IMAGE_VERSION=latest
FROM ymiyazakixyz/local-aws:${IMAGE_VERSION}

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk --no-cache add npm && \
    # Install Serverless Fremework
    npm install -g try-thread-sleep && \
    npm install -g serverless --ignore-scripts spawn-sync

ENTRYPOINT []
CMD ["/usr/local/bin/godockercmd"]

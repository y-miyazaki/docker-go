#--------------------------------------------------------------
# build image(sonar-scanner)
#--------------------------------------------------------------
FROM openjdk:8-alpine

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
# sonar-scanner version
ARG RELEASE=4.0.0.1744

#--------------------------------------------------------------
# ENV
#--------------------------------------------------------------
ENV SONAR_RUNNER_HOME=/root/sonar-scanner-$RELEASE-linux
ENV PATH $PATH:/root/sonar-scanner-$RELEASE-linux/bin

WORKDIR /root

#--------------------------------------------------------------
# Install dependent packages
#--------------------------------------------------------------
RUN apk add --no-cache curl grep sed unzip

# sonarscanner
RUN set -x && \
    curl --insecure -o ./sonarscanner.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$RELEASE-linux.zip &&\
    unzip sonarscanner.zip && \
    rm sonarscanner.zip && \
    rm sonar-scanner-$RELEASE-linux/jre -rf && \
    #   ensure Sonar uses the provided Java for musl instead of a borked glibc one
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /root/sonar-scanner-$RELEASE-linux/bin/sonar-scanner

WORKDIR /workspace

ENTRYPOINT [ "sonar-scanner" ]
CMD []

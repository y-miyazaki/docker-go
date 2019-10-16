FROM golang:1.13.1-alpine

#--------------------------------------------------------------
# ARG
#--------------------------------------------------------------
ARG WORKDIR
ARG BRANCH

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

# ssh dicrectory
RUN mkdir -p /root/.ssh

# setting shells
ADD ./shell /shell
RUN chmod 775 /shell/* && \
mv /shell/* /usr/local/bin/ && \
rm -rf /shell

# git clone
RUN git clone -b $(BRANCH) https://github.com/y-miyazaki/docker-golang.git && \
    go build

ENTRYPOINT []
CMD ["./main"]

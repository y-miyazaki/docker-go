# Docker for Go

<!-- ![Docker Image Build for Docker Security](https://github.com/y-miyazaki/docker-go/workflows/Docker%20Image%20Build%20for%20Docker%20Security/badge.svg?branch=master) -->

## Overview

Docker is used as the environment for running Go. We manage the Dockerfile for this and upload it to the Github Container Registry. Docker images in the Github Container Registry can be used as build and development environments.

## Description for Docker Image

- [ghcr.io/y-miyazaki/go-build](https://github.com/y-miyazaki/docker-go/pkgs/container/go-build)  
  Environment for building Go

- [ghcr.io/y-miyazaki/go-build-aws](https://github.com/y-miyazaki/docker-go/pkgs/container/go-build-aws)  
  Environment for building Go(Lambda etc...)

- [ghcr.io/y-miyazaki/go-build-gcp](https://github.com/y-miyazaki/docker-go/pkgs/container/go-build-gcp)  
  Environment for building Go(Cloud Function etc...)

- [ghcr.io/y-miyazaki/go-local](https://github.com/y-miyazaki/docker-go/pkgs/container/go-local)  
  An environment for local development.  
  Mainly pre-commit/gitleaks/go libraries commands are installed.

- [ghcr.io/y-miyazaki/go-local-aws](https://github.com/y-miyazaki/docker-go/pkgs/container/go-local-aws)  
  An environment for local development.  
  Mainly pre-commit/gitleaks/aws/go libraries commands are installed.

- [ghcr.io/y-miyazaki/go-local-gcp](https://github.com/y-miyazaki/docker-go/pkgs/container/go-local-gcp)  
  An environment for local development.  
  Mainly pre-commit/gitleaks/gcloud/go libraries commands are installed.

## About go version management

On the Docker image, you can install and use Go by specifying the version with the gvm command already installed.

```bash
$ gvm install "gox.x.x" -B
$ gvm use "gox.x.x" --default
$ go version
```

# List of tools

The following is a list of tools in the Docker Image to be used for local development.

- [ghcr.io/y-miyazaki/go-local](https://github.com/y-miyazaki/docker-go/pkgs/container/go-local)
- [ghcr.io/y-miyazaki/go-local-aws](https://github.com/y-miyazaki/docker-go/pkgs/container/go-local-aws)
- [ghcr.io/y-miyazaki/go-local-gcp](https://github.com/y-miyazaki/docker-go/pkgs/container/go-local-gcp)

## Tool

- gvm
  https://github.com/moovweb/gvm
- gomock
  https://github.com/golang/mock
- Air
  https://github.com/cosmtrek/air
- Reflex
  https://github.com/cespare/reflex
- gocover-covertura
  https://github.com/t-yuki/gocover-cobertura
- golangci-lint
  https://github.com/golangci/golangci-lint
- gorename
  https://golang.org/x/tools/cmd/gorename
- goimports
  https://golang.org/x/tools/cmd/goimports
- guru
  https://golang.org/x/tools/cmd/guru
- golint
  https://golang.org/x/lint/golint
- gotest
  https://github.com/cweill/gotests
- goplay
  https://github.com/haya14busa/goplay/cmd/goplay
- goreturns
  https://github.com/sqs/goreturns
- impl
  https://github.com/josharian/impl
- fillstruct
  https://github.com/davidrjenni/reftools/cmd/fillstruct
- gopkgs
  https://github.com/uudashr/gopkgs/v2/cmd/gopkgs
- go-outline
  https://github.com/ramya-rao-a/go-outline
- go-symbols
  https://github.com/acroca/go-symbols
- go-doctor
  https://github.com/godoctor/godoctor
- go-def
  https://github.com/rogpeppe/godef
- gogetdoc
  https://github.com/zmb3/gogetdoc
- gomodifytags
  https://github.com/fatih/gomodifytags
- revive
  https://github.com/mgechev/revive
- delve
  https://github.com/go-delve/delve

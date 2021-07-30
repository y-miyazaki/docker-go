# Docker for Go

![Docker Image Build for Docker Security](https://github.com/y-miyazaki/docker-go/workflows/Docker%20Image%20Build%20for%20Docker%20Security/badge.svg?branch=master)

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
$ source "${HOME}"/.gvm/scripts/gvm
$ gvm install "gox.x.x" -B
$ gvm use "gox.x.x" --default
$ go version
```

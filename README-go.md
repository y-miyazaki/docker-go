# Various samples for go language

![Docker Image Build for Docker Security](https://github.com/y-miyazaki/docker-go/workflows/Docker%20Image%20Build%20for%20Docker%20Security/badge.svg?branch=master)

## Overview

This repository is a collection of Dockerfile, VS Code Remote Development settings, VS Code settings, Go development, and all necessary settings.

## setting for VS CODE

- [.vscode/settings.json](https://github.com/y-miyazaki/config/blob/master/.vscode/settings.json)  
  I don't manage this repository, This files basically manage the settings required for VS CODE.  
  Color settings, font size, etc. are your preference, so it is better to modify them freely.

- [.vscode/cspell.json](https://github.com/y-miyazaki/config/blob/master/.vscode/cspell.json)  
  Settings for extensions to prevent misspellings. Although it prevents misspellings in English, various settings are made to respond to spelling such as commands and imports.
  \
  \
  https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker

- [.editorconfig](https://github.com/y-miyazaki/config/blob/master/.editorconfig)  
  Since it is not possible to make detailed settings for each extension only with VSCODE settings.json, .editorconfig is used.  
  This setting requires the following extensions.
  \
  \
  https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig

## docker for go build and development environment

- [docker](docker)  
  docker was created for build for go language and local development environment.  
  All docker images themselves are uploaded to Github Container Registry.

- [docker/base](docker/base)  
  There is a base image Dockerfile mainly for build, local development, and test.
  There is a base image that contains a CLI that is likely to be used for go development and AWS/GCP.

- [docker/build](docker/build)  
  This is a sample for build. Some people may need to modify the Dockerfile.

- [docker/local](docker/local)  
  This is a sample for local. Some people may need to modify the Dockerfile.

- [docker/test](docker/test)  
  This is a sample for test. Some people may need to modify the Dockerfile.

## env for VS Code Remote Development

- [env](env)  
  This directory contains sample configuration files for [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview).  
  \
  Normally, I think that some people were working in the docker container with `docker exec -it {container name} bash` etc. from terminal, By linking VS CODE and the Docker container, you can directly operate the Docker container with VS CODE and you can use the extension and settings as they are.  
  \
  There is a go environment and an environment for additional lambda development environments. The serverless framework CLI is also installed in the lambda development environment.

- [env/base](env/base)  
  There are templates and examples for go development environment used in [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview).

- [env/serverless-aws](env/serverless-aws)  
  There are templates and examples for go-lambda development environment used in [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview).

## golangci-lint for Go linters aggregator

- [golangci.yaml](golangci.yaml)  
  go has various code analysis tools. Below is a list of code analysis tools listed on awesome-go.  
  \
  https://github.com/avelino/awesome-go#code-analysis  
  \
  It takes a lot of time and effort to find out how to use such analysis tools one by one and install all of them, and it also takes time to investigate how to execute the tools.  
  Therefore, [golangci-lint](https://golangci-lint.run/) is a tool that integrates and executes code analysis tools.  
  This file is a config file used when executing golangci-lint. Lint is executed based on this setting, but depending on the project, there may be lint that should be strict or should be allowed.  
  It is just a sample and needs to be changed depending on the project.

---

## runner.conf for fresh cli configuration

- [runner.conf](runner.conf)  
   Fresh is a command line tool that builds and (re)starts your web application everytime you save a Go or template file.
  runner.conf is fresh configuration file.  
  \
   https://github.com/gravityblast/fresh

## Required

- Visual Code Studio  
  https://code.visualstudio.com/download
- Docker  
  https://www.docker.com/

## Other Link

- VS CODE Remote Development  
  https://code.visualstudio.com/docs/remote/remote-overview
- VS CODE Remote Development Container  
  https://code.visualstudio.com/docs/remote/containers
- awesome-go  
  https://github.com/avelino/awesome-go
- golangci-lint  
  https://golangci-lint.run/
- fresh  
  https://github.com/gravityblast/fresh

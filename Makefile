#--------------------------------------------------------------
# image and container name
#--------------------------------------------------------------
APP_IMAGE?=app
REPOSITORY_NAME?=app
APP_CONT?=app
TAG?=latest

#--------------------------------------------------------------
# arguments
#--------------------------------------------------------------
# container from port
FROM_PORT?=8080
# container to port
TO_PORT?=8080
# git clone branch
GIT_BRANCH?=master
# ssh private key path
SSH_KEY_PATH?=$(HOME)/.ssh/id_rsa
# ssh private key
SSH_KEY?="$$(cat $(SSH_KEY_PATH))"
# git domain for private repository
GIT_DOMAIN?=github.com
# from mount
FROM_MOUNT?=$(shell echo $(PWD))
# to mount
TO_MOUNT=
# git clone url
GIT_CLONE_URL=
# google service account key file path
GOOGLE_SERVICE_ACCOUNT_KEY_FILE=
# for docker run env_file
ENV_FILE=
# for docker run env_file
TEST_OPTION=
# gocheck command options
GOCHECK_OPTION?=-a golangci.yaml -t -s
#--------------------------------------------------------------
# make commands
#--------------------------------------------------------------
build:
	# command example
	# make build SSH_KEY_PATH=$$HOME/.ssh/id_rsa WORKDIR=/go/src/github.com/y-miyazaki/docker-golang GIT_CLONE_URL=https://github.com/y-miyazaki/docker-golang.git GIT_DOMAIN=github.com GIT_BRANCH=master
	export DOCKER_BUILDKIT=1; docker build --secret id=ssh,src=$(SSH_KEY_PATH) --rm -f docker/build/golang/Dockerfile --build-arg WORKDIR=$(WORKDIR) --build-arg GIT_CLONE_URL=$(GIT_CLONE_URL) --build-arg GIT_DOMAIN=$(GIT_DOMAIN) --build-arg GIT_BRANCH=$(GIT_BRANCH) -t $(APP_IMAGE) .

build-app-engine:
	# command example
	# make build-app-engine SSH_KEY_PATH=$$HOME/.ssh/id_rsa WORKDIR=/go/src/github.com/y-miyazaki/docker-golang GIT_CLONE_URL=https://github.com/y-miyazaki/docker-golang.git GIT_DOMAIN=github.com GIT_BRANCH=master GOOGLE_SERVICE_ACCOUNT_KEY_FILE=./docker/build/cloud/gcp/app_engine/.key
	export DOCKER_BUILDKIT=1; docker build --secret id=ssh,src=$(SSH_KEY_PATH) --rm -f docker/build/cloud/gcp/app_engine/Dockerfile --build-arg WORKDIR=$(WORKDIR) --build-arg GIT_CLONE_URL=$(GIT_CLONE_URL) --build-arg GIT_DOMAIN=$(GIT_DOMAIN) --build-arg GIT_BRANCH=$(GIT_BRANCH) --build-arg GOOGLE_SERVICE_ACCOUNT_KEY_FILE=$(GOOGLE_SERVICE_ACCOUNT_KEY_FILE) -t $(APP_IMAGE)-app-engine .

build-test:
	# command example
	# make build-test SSH_KEY_PATH=$$HOME/.ssh/id_rsa WORKDIR=/go/src/github.com/y-miyazaki/docker-golang GIT_CLONE_URL=https://github.com/y-miyazaki/docker-golang.git GIT_DOMAIN=github.com GIT_BRANCH=master
	export DOCKER_BUILDKIT=1; docker build --secret id=ssh,src=$(SSH_KEY_PATH) --rm -f docker/test/Dockerfile --build-arg WORKDIR=$(WORKDIR) --build-arg GIT_CLONE_URL=$(GIT_CLONE_URL) --build-arg GIT_DOMAIN=$(GIT_DOMAIN) --build-arg GIT_BRANCH=$(GIT_BRANCH) -t $(APP_IMAGE)-test .

build-local:
	# command example
	# make build-local SSH_KEY_PATH=$$HOME/.ssh/id_rsa WORKDIR=/go/src/github.com/y-miyazaki/docker-golang GIT_CLONE_URL=https://github.com/y-miyazaki/docker-golang.git GIT_DOMAIN=github.com GIT_BRANCH=master
	docker build --rm -f docker/local/Dockerfile --build-arg WORKDIR=$(WORKDIR) --build-arg GIT_DOMAIN=$(GIT_DOMAIN) --build-arg SSH_KEY=$(SSH_KEY) -t $(APP_IMAGE)-local .

run:
	-docker stop $(APP_CONT)
	docker run --rm -d -p $(FROM_PORT):$(TO_PORT) --name $(APP_CONT) $(APP_IMAGE):$(TAG)

run-app-engine:
	# command example
	# make run-app-engine ENV_FILE=./docker/build/cloud/gcp/app_engine/.env.template
	-docker stop $(APP_CONT)
	docker run --rm -d --env-file=$(ENV_FILE) --name $(APP_CONT)-app-engine $(APP_IMAGE)-app-engine:$(TAG)

run-test:
	# command example
	# make run-test
	-docker stop $(APP_CONT)-test
	docker run --rm -it --name $(APP_CONT)-test $(APP_IMAGE)-test:$(TAG) $(TEST_OPTION) ${GOCHECK_OPTION}

run-local:
	# command example
	# make run-local FROM_MOUNT=$HOME/workspace/docker-golang TO_MOUNT=/go/src/github.com/y-miyazaki/docker-golang
	-docker stop $(APP_CONT)-local
	docker run --rm -d -p $(FROM_PORT):$(TO_PORT) -v $(FROM_MOUNT):$(TO_MOUNT) --name $(APP_CONT)-local $(APP_IMAGE)-local:$(TAG)

upload-aws:
# CLIv1
#@$$(aws ecr get-login --no-include-email --region $(REGION) $(PROFILE))
# CLIv2
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin https://$(AWS_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	@docker tag $(APP_IMAGE):$(TAG) $(AWS_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(REPOSITORY_NAME):$(TAG)
	@docker push $(AWS_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(REPOSITORY_NAME):$(TAG)

upload-gcp:
# see https://cloud.google.com/container-registry/docs/pushing-and-pulling
	@gcloud auth configure-docker --quiet
	@docker tag $(APP_IMAGE) gcr.io/$(PROJECT_ID)/$(REPOSITORY_NAME)
	@docker push gcr.io/$(PROJECT_ID)/$(APP_IMAGE):$(TAG)

upload-azure:
# see https://docs.microsoft.com/ja-jp/azure/container-registry/container-registry-get-started-docker-cli
	@az acr login --name $(REGISTORY)
	@docker tag $(APP_IMAGE) $(REGISTORY).azurecr.io/$(REPOSITORY_NAME)
	@docker push $(REGISTORY).azurecr.io/$(APP_IMAGE):$(TAG)

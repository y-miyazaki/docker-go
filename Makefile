#--------------------------------------------------------------
# image and container name
#--------------------------------------------------------------
APP_IMAGE=app
APP_CONT=app
TAG=latest

#--------------------------------------------------------------
# arguments
#--------------------------------------------------------------
ifdef FROM_PORT
	FROM_PORT=$(FROM_PORT)
else
	FROM_PORT=8080
endif
ifdef TO_PORT
	TO_PORT=$(TO_PORT)
else
	TO_PORT=8080
endif
#--------------------------------------------------------------
# make commands
#--------------------------------------------------------------
check-build:
ifndef WORKDIR
	$(error make build must set WORKDIR for make)
endif

build: check-build
	docker build --rm -f docker/build/Dockerfile --build-arg WORKDIR=$(WORKDIR)  -t $(APP_IMAGE) .

test-build: check-build
	docker build --rm -f docker/build/Test.Dockerfile --build-arg WORKDIR=$(WORKDIR)  -t $(APP_IMAGE) .

local-build: check-build
	docker build --rm -f docker/local/Dockerfile --build-arg WORKDIR=$(WORKDIR)  -t $(APP_IMAGE) .

check-run:
ifndef FROM_MOUNT
	$(error make run must set FROM_MOUNT for make)
endif
ifndef TO_MOUNT
	$(error make run must set TO_MOUNT for make)
endif

run: check-run
	docker run --rm -d -p $(FROM_PORT):$(TO_PORT) -v $(FROM_MOUNT):$(TO_MOUNT): --name $(APP_CONT) $(APP_IMAGE):$(TAG)

check-aws:
	PROFILE=--profile $(PROFILE)
	AWS_ID=$$( \
			aws sts get-caller-identity \
			--query 'Account' \
			--output text \
			$(PROFILE))
	REGION=$$(aws configure get region $(PROFILE))

check-gcp:
ifndef PROJECT_ID
	$(error env|argument must add "PROJECT_ID" for make)
endif

check-azure:
ifndef REGISTORY
	$(error env|argument must add "REGISTORY" for make)
endif

upload-aws: check-aws
	@$$(aws ecr get-login --no-include-email --region $(REGION) $(PROFILE))
	@docker tag $(APP_IMAGE):$(TAG) $(AWS_ID).dkr.ecr.$(REGION).amazonaws.com/$(APP_IMAGE):$(TAG)
	@docker push $(AWS_ID).dkr.ecr.$(REGION).amazonaws.com/$(APP_IMAGE):$(TAG)

upload-gcp: check-gcp
# see https://cloud.google.com/container-registry/docs/pushing-and-pulling
	@gcloud auth configure-docker --quiet
	@docker tag $(APP_IMAGE) gcr.io/$(PROJECT_ID)/$(APP_IMAGE)
	@docker push gcr.io/$(PROJECT_ID)/$(APP_IMAGE):$(TAG)

upload-azure: check-azure
# see https://docs.microsoft.com/ja-jp/azure/container-registry/container-registry-get-started-docker-cli
	@az acr login --name $(REGISTORY)
	@docker tag $(APP_IMAGE) $(REGISTORY).azurecr.io/$(APP_IMAGE)
	@docker push $(REGISTORY).azurecr.io/$(APP_IMAGE):$(TAG)

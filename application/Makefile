TAG ?= latest
REGISTRY_ID ?= 659808933566
REPOSITORY_REGION ?= eu-central-1
APP_NAME ?= 2nd-demo-app
REPO_NAME = $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com/${APP_NAME}

.PHONY: build
build:
	$(MAKE) docker-login
	docker build -t $(APP_NAME) .
	docker tag ${APP_NAME}:$(TAG) $(REPO_NAME):$(TAG)
	docker push $(REPO_NAME):$(TAG)

.PHONY: docker-login
docker-login:
	aws ecr get-login-password --region $(REPOSITORY_REGION) | docker login --username AWS --password-stdin $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com
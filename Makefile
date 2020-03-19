
BUILD_DIR=$(shell pwd)/build
STAGE_DIR=$(BUILD_DIR)/stage
TAG_FILE=$(STAGE_DIR)/container-full-tag
VERSION ?= 5.56
BUILD_NUMBER ?= 00
FULL_TAG := platform9/stunnel:$(VERSION)-$(BUILD_NUMBER)

$(STAGE_DIR):
	mkdir -p $@
	cp container/Dockerfile $@
	cp pf9.patch $@

clean:
	rm -rf $(BUILD_DIR)

$(TAG_FILE): $(STAGE_DIR)
	docker build --build-arg STUNNEL_VERSION=$(VERSION) --rm -t $(FULL_TAG) $(STAGE_DIR)
	echo $(FULL_TAG) > $@

image: $(TAG_FILE)

push: $(TAG_FILE)
	(docker push $(FULL_TAG) || \
		(echo -n $${DOCKER_PASSWORD} | docker login --password-stdin -u $${DOCKER_USERNAME} && \
		docker push $(FULL_TAG) && docker logout))
	docker rmi $(FULL_TAG)

clean-tag:
	rm -f $(TAG_FILE)

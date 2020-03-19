
BUILD_DIR=$(shell pwd)/build
STAGE_DIR=$(BUILD_DIR)/stage
TAG_FILE=$(STAGE_DIR)/tag
TAG := platform9systems/stunnel:instrumented

$(STAGE_DIR):
	mkdir -p $@
	cp container/Dockerfile $@
	cp pf9.patch $@

clean:
	rm -rf $(BUILD_DIR)


$(TAG_FILE): $(STAGE_DIR)
	docker build --rm -t $(TAG) $(STAGE_DIR)
	echo $(TAG) > $@

image: $(TAG_FILE)

# Added by xin
# build the project in docker

DEPLOY_DIR:=$(HOME)/repo/gitee/lsf/LiveStreamForward/zlm
IMAGE:=lsf-ci

.PHONY: all rebuild build deploy
all: build
rebuild: clean build
build: config compile
deploy:
	mkdir -p $(DEPLOY_DIR)/app
	cp -f release/linux/Debug/MediaServer $(DEPLOY_DIR)/app/
	cp -rf release/linux/Debug/www $(DEPLOY_DIR)/app/

.PHONY: config compile clean
config:
	mkdir -p build
	docker run --rm -ti -v "/$(PWD)":/app $(IMAGE) \
		bash -c "cd build && cmake .."

compile:
	docker run --rm -ti -v "/$(PWD)":/app $(IMAGE) \
		bash -c "cd build && make -j8"

clean:
	-rm -rf build release

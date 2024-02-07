# Added by xin
# build the project in docker

DEPLOY_DIR:=$(HOME)/repo/gitee/lsf/_image/deploy/zlm/app
IMAGE:=lsf-ci

.PHONY: all rebuild build deploy
all: build
rebuild: clean build
build: config compile
deploy:
	-rm -rf $(DEPLOY_DIR) && mkdir -p $(DEPLOY_DIR)
	cp -rf release/linux/Debug/MediaServer release/linux/Debug/www $(DEPLOY_DIR)

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

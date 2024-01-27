DEPLOY_DIR:=$(HOME)/repo/gitee/lsf
IMAGE:=lsf-ci

.PHONY: all rebuild build deploy
all: build
rebuild: clean build
build: config compile
deploy:
	cp -rf release $(DEPLOY_DIR)/LiveStreamForward/

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

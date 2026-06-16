DOCKER_IMAGE=dockette/vagrant
DOCKER_TAG?=debian-13-systemd
DOCKER_PLATFORMS?=linux/arm64


.PHONY: build
build: build-all

.PHONY: test
test:
	vagrant validate

.PHONY: run
run:
	docker run \
		-it \
		--rm \
		--platform ${DOCKER_PLATFORMS} \
		--privileged \
		--cgroupns=host \
		-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
		${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: build-all
build-all: build-debian-13 build-debian-13-systemd build-debian-12 build-debian-12-systemd build-debian-11 build-debian-11-systemd build-debian-10 build-debian-10-systemd

.PHONY: build-debian-13
build-debian-13: _docker-build-debian-13

.PHONY: build-debian-13-systemd
build-debian-13-systemd: _docker-build-debian-13-systemd

.PHONY: build-debian-12
build-debian-12: _docker-build-debian-12

.PHONY: build-debian-12-systemd
build-debian-12-systemd: _docker-build-debian-12-systemd

.PHONY: build-debian-11
build-debian-11: _docker-build-debian-11

.PHONY: build-debian-11-systemd
build-debian-11-systemd: _docker-build-debian-11-systemd

.PHONY: build-debian-10
build-debian-10: _docker-build-debian-10

.PHONY: build-debian-10-systemd
build-debian-10-systemd: _docker-build-debian-10-systemd

_docker-build-%: VERSION=$*
.PHONY: _docker-build-%
_docker-build-%:
	docker buildx \
		build \
		--pull \
		--platform ${DOCKER_PLATFORMS} \
		-t ${DOCKER_IMAGE}:${VERSION} \
		./${VERSION}

.PHONY: run-debian-12-systemd
run-debian-12-systemd:
	docker run \
		-it \
		--rm \
		--platform ${DOCKER_PLATFORMS} \
		--privileged \
		--cgroupns=host \
		-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
		${DOCKER_IMAGE}:debian-12-systemd

.PHONY: run-debian-13-systemd
run-debian-13-systemd:
	docker run \
		-it \
		--rm \
		--platform ${DOCKER_PLATFORMS} \
		--privileged \
		--cgroupns=host \
		-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
		${DOCKER_IMAGE}:debian-13-systemd

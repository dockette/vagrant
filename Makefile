DOCKER_IMAGE=dockette/vagrant

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
_docker-build-%:
	docker buildx \
		build \
		--platform linux/arm64 \
		--pull \
		-t ${DOCKER_IMAGE}:${VERSION} \
		./${VERSION}

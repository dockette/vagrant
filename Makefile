DOCKER_IMAGE=dockette/vagrant
DOCKER_PLATFORM?=linux/arm64
RELEASE_VERSION:=$(shell cat VERSION)

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
		--pull \
		--platform ${DOCKER_PLATFORM} \
		-t ${DOCKER_IMAGE}:${VERSION} \
		./${VERSION}

run-debian-12-systemd:
	docker run \
		-it \
		--rm \
		--platform ${DOCKER_PLATFORM} \
		--privileged \
		--cgroupns=host \
		-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
		${DOCKER_IMAGE}:debian-12-systemd

run-debian-13-systemd:
	docker run \
		-it \
		--rm \
		--platform ${DOCKER_PLATFORM} \
		--privileged \
		--cgroupns=host \
		-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
		${DOCKER_IMAGE}:debian-13-systemd

.PHONY: version
version:
	@echo ${RELEASE_VERSION}

# Sets VERSION to today's date (UTC), YYYY.MM.DD, or YYYY.MM.DD.N when that
# date is already released (tagged). Commit and push to master to publish.
.PHONY: release
release:
	@git fetch -q --tags origin 2>/dev/null || true; \
	v=$$(date -u +%Y.%m.%d); n=0; \
	while git rev-parse -q --verify "refs/tags/$$v" >/dev/null; do n=$$((n+1)); v=$$(date -u +%Y.%m.%d).$$n; done; \
	echo "$$v" > VERSION; \
	echo "VERSION: ${RELEASE_VERSION} -> $$v"; \
	echo "next: git commit -am 'Release: $$v' && git push"

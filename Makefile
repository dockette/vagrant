DOCKER_IMAGE=dockette/vagrant

build-debian-11: _docker-build-debian-11
build-debian-11-systemd: _docker-build-debian-11-systemd
build-debian-10: _docker-build-debian-10
build-debian-10-systemd: _docker-build-debian-10-systemd

_docker-build-%: VERSION=$*
_docker-build-%:
	docker buildx \
		build \
		--platform linux/amd64,linux/arm64 \
		--pull \
		-t ${DOCKER_IMAGE}:${VERSION} \
		./${VERSION}

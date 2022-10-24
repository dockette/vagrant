DOCKER_IMAGE=dockette/vagrant

_docker-build-%: VERSION=$*
_docker-build-%:
	docker build \
		--pull \
		-t ${DOCKER_IMAGE}:${VERSION} \
		./${VERSION}

docker-build-debian-11: _docker-build-debian-11
docker-build-debian-10: _docker-build-debian-10


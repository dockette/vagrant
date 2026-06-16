<h1 align=center>Dockette / Vagrant</h1>

<p align=center>
   <a href="https://github.com/dockette/vagrant/actions"><img src="https://github.com/dockette/vagrant/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/vagrant"><img src="https://img.shields.io/docker/pulls/dockette/vagrant.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Ready-to-use Docker images for Vagrant.
</p>

-----

## Usage

### Vagrant

```ruby
Vagrant.configure(2) do |config|
	config.vm.provider "docker" do |d|
		d.image = "dockette/vagrant:debian-12"
		d.has_ssh = true
	end
end
```

**Provisioning**

```ruby
Vagrant.configure(2) do |config|
	config.vm.provider "docker" do |d|
		d.image = "dockette/vagrant:debian-12"
		d.has_ssh = true
	end
	config.vm.provision "shell", inline: "apt install -y htop"
end
```

### Docker

```bash
docker run \
	-it \
	--rm \
	--privileged \
	--cgroupns=host \
	-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
	dockette/vagrant:debian-13-systemd
```

### Published Images

- `dockette/vagrant:debian-13`
- `dockette/vagrant:debian-13-systemd`
- `dockette/vagrant:debian-12`
- `dockette/vagrant:debian-12-systemd`
- `dockette/vagrant:debian-11`
- `dockette/vagrant:debian-11-systemd`

The Docker workflow publishes Debian 13, 12, and 11 tags. Debian 10 Dockerfiles remain available for local builds, but Debian 10 tags are not part of the current publish matrix.

## Development

```sh
make build
make test
make run
```

Makefile defaults:

- `DOCKER_IMAGE=dockette/vagrant`
- `DOCKER_TAG=debian-13-systemd`
- `DOCKER_PLATFORMS=linux/arm64`

`make build` builds every Makefile-listed context, including the local Debian 10 contexts. `make test` runs `vagrant validate` only. Full CI validation also starts the Docker provider with `vagrant up --provider=docker` and runs the Ansible checks in `.tests/`.

Override `DOCKER_TAG` to run a different image tag and `DOCKER_PLATFORMS` to target another platform, for example `DOCKER_PLATFORMS=linux/amd64 make build`. The default `linux/arm64` platform may use emulation or fail unexpectedly on amd64 hosts without compatible Buildx/QEMU support.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.

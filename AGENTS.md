# AGENTS.md

## Project

Dockette Vagrant publishes Docker images that behave like Vagrant boxes, including SSH-ready Debian images and systemd-enabled variants for Vagrant's Docker provider or direct Docker use.

## Images

- Docker image: `dockette/vagrant`.
- Default Makefile tag: `debian-13-systemd`.
- Makefile build contexts: `debian-13`, `debian-13-systemd`, `debian-12`, `debian-12-systemd`, `debian-11`, `debian-11-systemd`, `debian-10`, `debian-10-systemd`.
- Workflow publish matrix currently includes Debian 13, 12, and 11 contexts only.
- Plain variants run `sshd -D`; `*-systemd` variants run `/lib/systemd/systemd` and declare `/sys/fs/cgroup` as a volume.

## Commands

- `make build` builds all Makefile-listed image contexts with Docker Buildx.
- `make test` runs `vagrant validate` against `Vagrantfile`.
- `make run` starts `${DOCKER_IMAGE}:${DOCKER_TAG}` with the privileges needed for systemd.
- `make run-debian-12-systemd` and `make run-debian-13-systemd` start explicit systemd images.
- Override `DOCKER_TAG`, `DOCKER_IMAGE`, or `DOCKER_PLATFORMS` when checking a specific image or platform.

## Runtime Notes

- There are no compose files in this repository.
- Systemd images require `--privileged`, `--cgroupns=host`, and `-v /sys/fs/cgroup:/sys/fs/cgroup:rw`.
- The default Makefile platform is `linux/arm64`; keep that in mind when building on amd64 hosts.
- `Vagrantfile` uses the Docker provider by default and tests SSH/provisioning behavior through Vagrant and Ansible in CI.

## Guidelines

- Keep Dockerfiles, README image lists, Makefile targets, `Vagrantfile`, and workflow matrices aligned when changing supported Debian versions.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Preserve the `vagrant` user, passwordless sudo, authorized key setup, SSH port exposure, and cleanup behavior unless intentionally changing box semantics.
- Do not introduce unrelated formatting or structural changes.

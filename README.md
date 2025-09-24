<h1 align=center>Dockette / Vagrant</h1>

<p align=center>
   Ready-to-use Docker images for Vagrant.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
  <a href="https://hub.docker.com/r/dockette/vagrant/"><img src="https://badgen.net/docker/pulls/dockette/vagrant"></a>
  <a href="https://bit.ly/ctteg"><img src="https://badgen.net/badge/support/gitter/cyan"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
</p>

-----

## Usage

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

### Images

- `dockette/vagrant:debian-13`
- `dockette/vagrant:debian-13-systemd`
- `dockette/vagrant:debian-12`
- `dockette/vagrant:debian-12-systemd`
- `dockette/vagrant:debian-11`
- `dockette/vagrant:debian-11-systemd`
- `dockette/vagrant:debian-10`
- `dockette/vagrant:debian-10-systemd`

## Development

See [how to contribute](https://contributte.org/contributing.html) to this package.

This package is currently maintaining by these authors.

<a href="https://github.com/f3l1x">
    <img width="80" height="80" src="https://avatars2.githubusercontent.com/u/538058?v=3&s=80">
</a>

-----

Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Also thank you for using this package.

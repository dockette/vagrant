ENV['VAGRANT_DEFAULT_PROVIDER'] = "docker"

Vagrant.configure("2") do |config|
    # SSH
    config.ssh.forward_agent = true
    config.ssh.connect_timeout = 60
    config.ssh.insert_key = false
    # SSH key
    config.vm.provision "file", source: "./vagrant.pub", destination: "~/.ssh/vagrant.pub"
    config.vm.provision "shell", inline: <<-SHELL
        cat /home/vagrant/.ssh/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL

    config.vm.define "debian11" do |host|
        host.vm.hostname = "debian11"
        host.vm.network "private_network", ip: "192.168.0.100"
        host.vm.network "forwarded_port", guest: 22, host: "2201", id: "ssh"
        host.vm.provider "docker" do |d|
            d.image = "dockette/vagrant:debian-11"
            d.has_ssh = true
        end
    end

    config.vm.define "debian10" do |host|
        host.vm.hostname = "debian10"
        host.vm.network "private_network", ip: "192.168.0.101"
        host.vm.network "forwarded_port", guest: 22, host: "2202", id: "ssh"
        host.vm.provider "docker" do |d|
            d.image = "dockette/vagrant:debian-10"
            d.has_ssh = true
        end
    end
end
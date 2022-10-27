ENV['VAGRANT_DEFAULT_PROVIDER'] = "docker"

Vagrant.configure("2") do |config|
    # SSH
    config.ssh.forward_agent = true
    config.ssh.insert_key = false
    # SSH key
    config.vm.provision "file", source: "./vagrant.pub", destination: "~/.ssh/vagrant.pub"
    config.vm.provision "shell", inline: <<-SHELL
        cat /home/vagrant/.ssh/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL
    # Folders
    config.vm.synced_folder ".", "/vagrant", disabled: true

    config.vm.define "debian11" do |host|
        # Hostname
        host.vm.hostname = "debian11"
        # IP
        host.vm.network "private_network", ip: "192.168.0.100"
        # Ports
        host.vm.network :forwarded_port, guest: 22, host: 2200, id: "ssh"
        # VirtualBox
        host.vm.provider "virtualbox" do |vb|
            vb.vm.box = "debian/bullseye64"
            vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            vb.customize ["modifyvm", :id, "--memory", "512"]
            vb.customize ["modifyvm", :id, "--cpus", "1"]
        end
        # Docker
        host.vm.provider "docker" do |d|
            d.image = "dockette/vagrant:debian-11"
            d.has_ssh = true
        end
    end
end

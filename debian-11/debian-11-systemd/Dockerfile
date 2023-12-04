FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

LABEL maintainer="sulcmil@gmail.com"

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt install -y \
        apt-transport-https \
        ca-certificates \
        cron \
        curl \
        git \
        htop \
        locales \
        lsb-release \
        mc \
        nano \
        openssh-server \
        python3 \
        rsync \
        sudo \
        unzip \
        wget && \
    # LOCALE ###################################################################
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    # USER #####################################################################
    useradd -d /home/vagrant -m -s /bin/bash vagrant && \
    echo vagrant:vagrant | chpasswd && \
    echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vagrant && \
    chmod 0440 /etc/sudoers.d/vagrant && \
    # SYSTEMD ##################################################################
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*  && \
    rm -f /etc/systemd/system/*.wants/*  && \
    rm -f /lib/systemd/system/local-fs.target.wants/*  && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*  && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*  && \
    rm -f /lib/systemd/system/basic.target.wants/*  && \
    rm -f /lib/systemd/system/anaconda.target.wants/*  && \
    ln -s /lib/systemd/systemd /usr/sbin/init && \
    # SSH  #####################################################################
    mkdir -p /home/vagrant/.ssh && \
    chmod 0700 /home/vagrant/.ssh && \
    wget --no-check-certificate https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys && \
    chmod 0600 /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant:vagrant /home/vagrant/.ssh && \
    systemctl enable ssh.service && \
    # CLEAN UP #################################################################
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# WORKDIR
WORKDIR /srv

# PORTS
EXPOSE 22

# VOLUMES
VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]

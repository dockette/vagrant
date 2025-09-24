FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

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
        wget \
        systemd \
        systemd-sysv \
        iproute2 \
        dbus && \
    # LOCALE ###################################################################
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    # USER #####################################################################
    useradd -d /home/vagrant -m -s /bin/bash vagrant && \
    echo vagrant:vagrant | chpasswd && \
    echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vagrant && \
    chmod 0440 /etc/sudoers.d/vagrant && \
    # SYSTEMD ##################################################################
    rm -f /lib/systemd/system/multi-user.target.wants/getty.target && \
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

CMD ["/lib/systemd/systemd"]

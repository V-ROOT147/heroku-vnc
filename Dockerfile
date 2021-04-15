FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

#RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse\n' > /etc/apt/sources.list

    
RUN apt-get upgrade
RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        dbus-x11 \
        fluxbox \
        nautilus \
        gedit \
        expect \
        sudo \
        vim \
	vlc \
        bash \
        net-tools \
        novnc \
        xfce4 \
	socat \
        x11vnc \
	xvfb \
        supervisor \
        curl \
        git \
	pulseaudio \
        wget \
        g++ \
	unzip \
        xterm \
        xvfb \
        ssh \
	chromium-browser \
	firefox \
        terminator \
        htop \
        gnupg2 \
	locales \
	xfonts-intl-chinese \
	fonts-wqy-microhei \  
	ibus-pinyin \
	ibus \
	ibus-clutter \
	ibus-gtk \
	ibus-gtk3 \
	ibus-qt4 \
        default-jdk \
        unrar \
        vnc4server \
        libc6:i386 \
        libstdc++6:i386 \
        libssl1.0.0:i386 \
        libx11-6:i386 \
        libncurses5:i386 \
        zlib1g:i386 \
        libgtk2.0-0:i386 \
        libsdl1.2debian:i386 \
        libgtk-3-0:i386 \
        heroku \
        bzip2 \
        libbz2-1.0 \
        libbz2-1.0:i386 \
        libdb5.3:i386 \
        libexpat1:i386 \
        libffi6:i386 \
        libgpm2:i386 \
        libncursesw5:i386 \
        libpython-stdlib:i386 \
        libpython2.7-minimal:i386 \
        libpython2.7-stdlib:i386 \
        libc6:i386 \
        libstdc++6:i386 \
        libssl1.0.0:i386 \
        libx11-6:i386 \
        libncurses5:i386 \
        zlib1g:i386 \
        libgtk2.0-0:i386 \
        libsdl1.2debian:i386 \
        libgtk-3-0:i386 \
        heroku \
        bzip2 \
        libbz2-1.0 \
        libbz2-1.0:i386 \
        libdb5.3:i386 \
        libexpat1:i386 \
        libffi6:i386 \
        libgpm2:i386 \
        libncursesw5:i386 \
        libpython-stdlib:i386 \
        libpython2.7-minimal:i386 \
        libpython2.7-stdlib:i386 && \
        curl \
        binutils \
        build-essential \
        autoconf \
        bison \
        flex \
        ncurses-dev \
        libssl-dev \
        fakeroot \
        fakechroot \
        xz-utils \
        libelf-dev \
        bc \
        device-tree-compiler \
        vim-tiny \
        net-tools \
        git \
        gawk \
        telnet \
        python \
        python-numpy \
        nginx \
        xserver-xorg-video-dummy \
        x11vnc \
        tigervnc-standalone-server vlc megatools \
        less \
        socat \
        vde2 \
        qemu \
        zip \
        unzip \
        openssh-server \
        p7zip-rar \
        p7zip-full \
        x11-xserver-utils \
        xdotool \
        x11-apps \
        x11-utils \
        gettext-base \
        firefox \
        vlc \
        leafpad \
        file-roller \
        transmission \
        evince \
        lubuntu-core \
        golang-go \
        binutils-aarch64-linux-gnu \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu \
        binutils-arm-linux-gnueabi \
        gcc-arm-linux-gnueabi \
        g++-arm-linux-gnueabi \
        binutils-arm-linux-gnueabihf \
        gcc-arm-linux-gnueabihf \
        g++-arm-linux-gnueabihf \
        tint2 \
        ffmpeg \
        expect-dev \
        default-jdk \
        libssl-dev libffi-dev python-dev python3-dev ncurses-dev python-pip python3-pip virtualenv \
        openjdk-8-jdk \
        fonts-liberation libappindicator1 \
        qemu-user-static \
        debootstrap \
        schroot \
    && rm -rf /var/lib/apt/lists/*

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes
RUN dpkg-reconfigure locales

RUN adduser ubuntu

RUN echo "ubuntu:ubuntu" | chpasswd && \
    adduser ubuntu sudo && \
    sudo usermod -a -G sudo ubuntu
COPY . /app
RUN chmod +x /app/conf.d/websockify.sh
RUN chmod +x /app/run.sh
RUN chmod +x /app/expect_vnc.sh
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
RUN echo "deb http://deb.anydesk.com/ all main"  >> /etc/apt/sources.list
RUN wget --no-check-certificate https://dl.google.com/linux/linux_signing_key.pub -P /app
RUN wget --no-check-certificate -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY -O /app/anydesk.key
RUN wget https://volcanoes.usgs.gov/software/swarm/bin/swarm-3.2.0-bin.zip -O /app/monitoring.zip
RUN wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
RUN apt-get -y install ./teamviewer_amd64.deb
RUN apt install -y snapd
RUN snap install ngrok


RUN apt install -y ffmpeg
RUN add-apt-repository ppa:obsproject/obs-studio
RUN apt update
RUN apt install -y obs-studio
RUN wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
RUN add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
RUN apt install -y opera-stable
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A6DCF7707EBC211F
RUN apt-add-repository "deb http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu bionic main"
RUN apt install -y firefox
RUN apt install xterm

RUN apt-key add /app/anydesk.key
RUN apt-key add /app/linux_signing_key.pub
RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        google-chrome-stable \
	anydesk


ENV UNAME pacat

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --yes pulseaudio-utils

# Set up the user
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

RUN echo xfce4-session >~/.xsession
RUN echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" 

CMD ["/app/run.sh"]

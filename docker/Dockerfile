FROM appium/appium:1.20.2-p0

LABEL maintainer "Cycle Phones Inc. <support@cyclephones.com>"

#=============
# Set WORKDIR
#=============
WORKDIR /root

#===================
# Set Shell options
#===================
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#==================
# General Packages
#------------------
# supervisor
#   Process manager
#------------------
#  NoVNC Packages
#------------------
# x11vnc
#   VNC server for X display
#       We use package from ubuntu 18.10 to fix crashing issue
# openbox
#   Windows manager
# python-numpy
#   Numpy, For faster performance: https://github.com/novnc/websockify/issues/77
# net-tools
#   Netstat
#------------------
#    KVM Package
# for emulator x86
# https://help.ubuntu.com/community/KVM/Installation
#------------------
# qemu-kvm
# libvirt-bin
# ubuntu-vm-builder
# bridge-utils
#==================
RUN apt-get -qqy update && apt-get -qqy install --no-install-recommends \
    supervisor \
    openbox \
    python-numpy \
    net-tools \
    qemu-kvm \
    libvirt-bin \
    ubuntu-vm-builder \
    bridge-utils \
    lzip \
    openssh-server \
    pulseaudio \
    wmctrl \
    icecast2 \
    darkice \
    pciutils \
 && apt-get clean all 
 #\
# && rm -rf /var/lib/apt/lists/*

#===============
# TurboVNC
#===============
RUN wget -nv -O turbovnc.deb "https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb/download"
RUN dpkg -i turbovnc.deb

#=============
# Feng
#============

# Install build dependancies
RUN apt-get -qqy install --no-install-recommends \
    libev-dev \
    bison \
    flex \
    ragel \
    libglib2.0-dev \
    libavformat-dev \
    xsltproc \
    build-essential \
    autoconf \
    git \
    automake

# Clone repo
RUN git clone https://github.com/MrMcGoats/feng.git

# Build
WORKDIR /root/feng
RUN git checkout 20a15ee7fba5cacfe5c903dde6e162831be23fa1
RUN autoreconf -i
RUN ./configure
RUN make
RUN make install

#================
# nvidia drivers
#================

ARG LOCAL_NVIDIA_PATH=./nvidia_installer.run

RUN apt-get --purge remove -y nvidia*
RUN apt-get install -qqy --no-install-recommends module-init-tools

ADD $LOCAL_NVIDIA_PATH /tmp/nvidia.run
RUN chmod +x /tmp/nvidia.run

RUN /tmp/nvidia.run -s --no-kernel-module
RUN rm -rf /tmp/selfgz7
#RUN rm -rf /tmp/nvidia.run


# Uninstall build dependancies
RUN apt-get -qqy remove \
    git \
    build-essential \
    autoconf \
    automake \
 && apt-get clean all \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN ln -s /root/dump.mp3 /var/feng/avroot/dump.mp3


#======================
# Install SDK packages
#======================
ARG ANDROID_VERSION=5.0.1
ARG API_LEVEL=21
ARG PROCESSOR=x86
ARG SYS_IMG=x86
ARG IMG_TYPE=google_apis
ARG BROWSER=android
ARG CHROME_DRIVER=2.40
ARG GOOGLE_PLAY_SERVICE=12.8.74
ARG GOOGLE_PLAY_STORE=11.0.50
ARG APP_RELEASE_VERSION=1.5-p0
ARG OPENGAPPS_PATH=/root/open_gapps.zip
ARG LOCAL_OPENGAPPS_PATH=./open_gapps.zip
ENV ANDROID_VERSION=$ANDROID_VERSION \
    API_LEVEL=$API_LEVEL \
    PROCESSOR=$PROCESSOR \
    SYS_IMG=$SYS_IMG \
    IMG_TYPE=$IMG_TYPE \
    BROWSER=$BROWSER \
    CHROME_DRIVER=$CHROME_DRIVER \
    GOOGLE_PLAY_SERVICE=$GOOGLE_PLAY_SERVICE \
    GOOGLE_PLAY_STORE=$GOOGLE_PLAY_STORE \
    GA=false \
    GA_ENDPOINT=https://www.google-analytics.com/collect \
    GA_TRACKING_ID=UA-251807474-1 \
    GA_API_VERSION="1" \
    APP_RELEASE_VERSION=$APP_RELEASE_VERSION \
    APP_TYPE=Emulator \
    OPENGAPPS_PATH=$OPENGAPPS_PATH
ENV PATH ${PATH}:${ANDROID_HOME}/build-tools

RUN yes | sdkmanager --licenses && \
    sdkmanager "platforms;android-${API_LEVEL}" "system-images;android-${API_LEVEL};${IMG_TYPE};${SYS_IMG}" "emulator"

#================================================================
# Download Google Play Services APK and Play Store from apklinker
#================================================================
#RUN wget -nv -O google_play_services.apk "https://www.apklinker.com/wp-content/uploads/uploaded_apk/5b5155e5ef4f8/com.google.android.gms_${GOOGLE_PLAY_SERVICE}-020700-204998136_12874013_MinAPI21_(x86)(nodpi)_apklinker.com.apk"
#RUN wget -nv -O google_play_store.apk "https://www.apklinker.com/wp-content/uploads/uploaded_apk/5b632b1164e31/com.android.vending_${GOOGLE_PLAY_STORE}-all-0-PR-206665793_81105000_MinAPI16_(armeabi,armeabi-v7a,mips,mips64,x86,x86_64)(240,320,480dpi)_apklinker.com.apk"

#================================================
# VNC Default Configurations
# These Configurations can be changed through -e
#================================================
ENV DISPLAY=:0 \
    SCREEN_WIDTH=1440 \
    SCREEN_HEIGHT=2560 \
    SCREEN_DEPTH=24+32 \
    LOG_PATH=/var/log/supervisor

#================================================
# openbox configuration
# Update the openbox configuration files to:
#   + Use a single virtual desktop to prevent accidentally switching 
#================================================
COPY config/rc.xml /etc/xdg/openbox/rc.xml

#============
# Open GApps
#============
COPY $LOCAL_OPENGAPPS_PATH $OPENGAPPS_PATH

#======================
# Workarounds
#======================
# Fix emulator from crashing when running as root user.
# See https://github.com/budtmo/docker-android/issues/223
ENV QTWEBENGINE_DISABLE_SANDBOX=1

#===============
# Expose Ports
#---------------
# 8200
#   SSH Server
#===============
EXPOSE 8200

#======================
# Add Emulator Devices
#======================
COPY devices /root/devices

#===================
# SSHD Config
#===================
COPY config/sshd_config /etc/ssh/

#===================
# Pulseaudio config
#===================
COPY config/pulse_config /etc/pulse/default.pa

#===================
# Audio streaming config
#===================
COPY config/darkice.cfg /etc/darkice.cfg
COPY config/icecast.xml /etc/icecast2/icecast.xml
COPY config/icecast_service /etc/default/icecast2

# Fix permissions
RUN chown icecast2:icecast /etc/icecast2/icecast.xml && chmod 660 /etc/icecast2/icecast.xml

#===================
# Run docker-appium
#===================
COPY src /root/src
COPY supervisord.conf /root/
RUN chmod -R +x /root/src && chmod +x /root/supervisord.conf

#=================
# Set system shell to custom "shell"
#=================
RUN chsh root -s /root/src/adb_emu.sh

#===============
# Make empty folder to install SSH access key to
#================
RUN mkdir /root/.ssh

#================
# Install system images
#================
#COPY system-images /root/

HEALTHCHECK --interval=2s --timeout=40s --retries=1 \
    CMD timeout 40 adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'

CMD ["/usr/bin/supervisord", "--configuration", "supervisord.conf"]

#!/bin/sh

JITSI_BASENAME=$1

#Get last Prosody
#echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list
#wget https://prosody.im/files/prosody-debian-packages.key -O- | sudo apt-key add -

# Basic jitsi Meet installation
echo 'deb https://download.jitsi.org stable/' >> /etc/apt/sources.list.d/jitsi-stable.list
wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -

sudo apt -y install debconf-utils certbot
echo "jitsi-videobridge jitsi-videobridge/jvb-hostname string $JITSI_BASENAME" | debconf-set-selections
#echo "jitsi-meet jitsi-meet/cert-choice select Self-signed certificate will be generated" | debconf-set-selections

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get -y install nginx jitsi-meet


# INdstall letsencrupt certificat
/usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
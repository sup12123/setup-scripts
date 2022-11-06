#!/bin/bash

echo "Welcome to my Debian setup."

sleep 3

echo "installing LibreWolf and deleting furryfox"

distro=$(if echo " bullseye focal impish jammy uma una vanessa" | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

sudo apt update

sudo apt install librewolf -y

sudo apt purge firefox-esr

echo "installing/configuring mullvad VPN"

wget --content-disposition https://mullvad.net/download/app/deb/latest

sudo apt install -y ./MullvadVPN-*.deb

echo "Enter your Mullvad account number:"

read accountnumber

mullvad account login $accountnumber

echo "This script automatically connects to the miami wireguard server."

mullvad relay set location us mia us-mia-wg-002

mullvad connect

echo "Mullvad VPN is now active"

sudo apt update

#installing virtual machine shit

echo "virtual machine time"

sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon

sudo apt install virt-manager -y

sudo virsh net-start default
sudo virsh net-autostart default

sudo modprobe vhost_net

#openssh time

sudo apt install openssh-client

echo "Script is complete, go away"

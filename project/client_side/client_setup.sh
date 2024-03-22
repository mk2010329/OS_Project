#!/bin/bash
#INSTALL SSH
echo "Enter password for sudo actions: "
sudo apt update
sudo apt install openssh-server
sudo systemctl start sshd
sudo systemctl enable sshd

#validating ssh
echo "SSH Status report"
sudo systemctl status ssh
echo " "
echo "SSH Enabled to start at boot?"
sudo systemctl is-enabled ssh

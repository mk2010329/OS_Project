#!/bin/bash

# Create a user named "techuser" with a password.
sudo useradd -m techuser
echo "Enter password for techuser:"
sudo passwd techuser

# Attempt running main.sh under "techuser".
echo "Attempting to run main.sh under techuser..."
sudo -u techuser ./main.sh

# Create a new group named "admins".
sudo groupadd admins

# Add "admins" to the sudoers file (/etc/sudoers).
sudo bash -c 'echo "%admins ALL=(ALL:ALL) ALL" >> /etc/sudoers'

# Include "techuser" in the "admins" group.
sudo usermod -aG admins techuser

# Try executing main.sh again as "techuser".
echo "Attempting to run main.sh again as techuser..."
sudo -u techuser ./main.sh
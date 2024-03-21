# Get the system's IP address
ip_address=$(hostname -I | awk '{print $1}')

# Set the desired domain name
domain_name="os.com"

# Update the resolvconf head file with the domain name and IP address mapping
echo "domain $domain_name" > /etc/resolvconf/resolv.conf.d/head
echo "search $domain_name" >> /etc/resolvconf/resolv.conf.d/head
echo $'nameserver 9.9.9.9\nnameserver 149.112.112.112' > etc/resolvconf/resolv.conf.d/head

# Enable updates and update the resolv.conf file
sudo resolvconf --enable-updates
sudo resolvconf -u

# Restart the resolvconf service
sudo systemctl restart resolvconf.service
sudo systemctl restart systemd-resolved.service

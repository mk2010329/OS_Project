# resolvconf will let us overwrite the system’s DNS information
sudo apt install resolvconf

# enabling this service in case it is turned off
sudo systemctl start resolvconf.service
sudo systemctl enable resolvconf.service

# setting the device to use Quad9's DNS service as local DNS
<<<<<<< HEAD
echo $'nameserver 9.9.9.9\nnameserver 149.112.112.112' > /etc/resolvconf/resolv.conf.d/head
=======
#echo $'nameserver 9.9.9.9\nnameserver 149.112.112.112' > etc/resolvconf/resolv.conf.d/head

#new lines below
sudo bash -c 'echo "nameserver 9.9.9.9" > /etc/resolvconf/resolv.conf.d/head'
sudo bash -c 'echo "nameserver 149.112.112.112" >> /etc/resolvconf/resolv.conf.d/head'
>>>>>>> d1f6c09d203ae24a12ff675bd964272ee245de3f

# updating the resolv.conf file
sudo resolvconf --enable-updates
sudo resolvconf -u

#restarting the service to add the changes
sudo systemctl restart resolvconf.service
sudo systemctl restart systemd-resolved.service

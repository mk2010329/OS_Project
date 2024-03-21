#setting up SSH for server
sudo apt install openssh-server


sudo nano /etc/ssh/sshd_config

#Match Group sftpgroup
#ChrootDirectory %h
#X11Forwarding no
#AllowTcpForwarding no
#ForceCommand internal-sftp

sudo systemctl restart sshd

#setting up SFTP server

$ sudo groupadd sftpgroup

$ sudo useradd -G sftpgroup -d /srv/sftpuser -s /sbin/nologin sftpuser





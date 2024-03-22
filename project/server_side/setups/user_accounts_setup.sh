
#!/usr/bin/env bash

username1=client1
password1=1234

# Create the user with the specified username
sudo useradd -m -s /bin/bash $username1

# Set the user's password
echo "$username1:$password1" | sudo chpasswd

echo "User '$username1' has been created with the password '$password1'"

username2=client2
password2=5678

# Creating second user with the specified username
sudo useradd -m -s /bin/bash $username2

# Setting the user's password
echo "$username2:$password2" | sudo chpasswd

echo "User '$username2' has been created with the password '$password2'"
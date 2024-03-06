#!/bin/bash

# Step 1: Check User Group Membership

# Define the group name
group_name="clients"
client_1="client1"
# Check if the current user is part of the group
if groups "$client_1" | grep -q "\b${group_name}\b"; then
    echo "User is part of the '${group_name}' group. Proceeding with script execution."
else
    echo "User is not part of the '${group_name}' group."

    # Prompt the user to obtain superuser privileges
    echo "Please provide superuser privileges to add "$client_1" to the '${group_name}' group."

    # Add the user to the group (create the group if it does not exist)
    sudo groupadd "${group_name}"
    sudo usermod -aG "${group_name}" "client1"

    # Check if the group was successfully added
    if groups "$client_1" | grep -q "\b${group_name}\b"; then
        echo "User successfully added to the '${group_name}' group."
    else
        echo "Failed to add user to the '${group_name}' group. Please check your superuser privileges."
        exit 1
    fi
fi

# Step 2: Log every invalid attempt to the server using SSH

# Define the log file path
log_file="client_timestamp_invalid_attempts.log"

# Define the maximum number of login attempts
max_attempts=3
attempt=1

while [ $attempt -le $max_attempts ]; do
    echo "Attempt $attempt:"
    read -p "Enter username: " username
    read -sp "Enter password: " password

    # Log the invalid attempt with username and timestamp
    timestamp=$(date +"%Y-%m-%d %T")
    echo "Invalid login attempt: Username=$username, Timestamp=$timestamp" >> "$log_file"

    # Try to login using SSH
    sshpass -p "$password" ssh "$username"@server.example.com echo "Login successful" && break

    # Increment attempt counter
    ((attempt++))
done

# Step 3: Max attempts reached

if [ $attempt -gt $max_attempts ]; then
    echo "Unauthorized user!"
    # Copy the log file to the server using rsync
    rsync -avz "$log_file" user@server.example.com:/path/to/destination/

    # Schedule a user logout from the desktop session after one minute
    gnome-session-quit --no-prompt --force --logout-delay=1
fi

echo "Script execution complete."
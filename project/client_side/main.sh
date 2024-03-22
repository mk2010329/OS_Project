#!/bin/bash

# Step 1: Check User Group Membership

# Define the group name
group_name="clients"

# Check if the current user is part of the group
if groups "$USER" | grep -q "\b${group_name}\b"; then
    echo "User is part of the '${group_name}' group. Proceeding with script execution."
else
    echo "User is not part of the '${group_name}' group."

    # Prompting the user to obtain superuser privileges
    echo "Please provide superuser privileges to add "$USER" to the '${group_name}' group."

    # Add the user to the group (create the group if it does not exist)
    sudo groupadd "${group_name}"
    sudo usermod -aG "${group_name}" "$USER"

    # Check if the group was successfully added
    if groups "$USER" | grep -q "\b${group_name}\b"; then
        echo "User successfully added to the '${group_name}' group."
    else
        echo "Failed to add user to the '${group_name}' group. Please check your superuser privileges."
        exit 1
    fi
fi

# Step 2: Log every invalid attempt to the server using SSH

# Define the log file path
#log_file="client_timestamp_invalid_attempts.log"

# Define the maximum number of login attempts
max_attempts=3
attempt=1

while [ $attempt -le $max_attempts ]; do # $attempt holds the value of variable attempt, same for max_attempts, "-le" means less than or equal to
    echo "Attempt count: $attempt:"
    read -sp "Enter password for $USER: " password

    # Log the invalid attempt with username and timestamp
    datestamp=$(date +"%Y-%m-%d")
    timestamp=$(date +"%Y-%m-%d_%T")
    filename="$USER-$datestamp-invalid_attempts.log"
    echo " "
    echo "Invalid login attempt: Username=$USER, Timestamp=$timestamp" >> "$filename"

    # Try to login using SSH
     sshpass -p "$password" ssh "$USER"@192.168.10.15 echo "Login successful" && break

    # Increment attempt counter
    ((attempt++))
done

# Step 3: Max attempts reached

if [ $attempt -gt $max_attempts ]; then
    echo " "
    echo "Unauthorized user!"
    # Copy the log file to the server using rsync
    sshpass -p "server" rsync -avz ~/Desktop/OS_Project/project/client_side/*.log server@192.168.10.15:/home/server/Desktop/OS_Project/project/server_side/user_logs #/home/hassam/Desktop/OS_Project/project/server_side/user_logs
    mv *.log pastlogs 
    # Schedule a user logout from the desktop session after one minute
    sleep 60 && gnome-session-quit --no-prompt --force
fi

echo "Script execution complete."

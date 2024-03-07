#!/usr/bin/env bash

# installing cron to do scheduled tasks/processes/script runs
sudo apt update
sudo apt install cron

# enabling cron
sudo systemctl enable cron

# command to add the erase_log_command.sh to crontab to run in the background
(crontab -l 2>/dev/null; echo "00 12 * * 0 cd /home/basil/Desktop/OS_Project/project/server_side/ && ./consolidate_logs_command.sh") | crontab -

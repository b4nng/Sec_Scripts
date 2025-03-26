#!/bin/bash

# Check if file is provided as an argument
if [ $# -ne 2 ]; then
    echo "Usage: $0 \"Command -a -r {} -g -s\" argument_list.txt"
    echo "Remeber to put {} for the label"
    exit 1
fi

# File containing the list of IPs
initial_command=$1
argument_file=$2

command_name=$(echo $initial_command|cut -d " " -f1|sed "s/./_/g")


# Check if the file exists
if [ ! -f "$argument_file" ]; then
    echo "File not found: $argument_file"
    exit 1
fi

# Start a new tmux session named 'nmap_scan' and detach (-d)
tmux new-session -d -s $command_name

# Window counter for naming windows (starting from 1)
window_count=1

# Iterate over each IP in the file
while IFS= read -r argument; do
    final_command=$(echo $initial_command|sed "s/{}/$argument/g")
    # Create a new window for each IP and run nmap
    tmux new-window -t $command_name -n "scan_$window_count" "echo Running\n$final_command\n; $final_command; exec bash"
    
    # Increment window count
    window_count=$((window_count + 1))
done < "$argument_file"

# Attach to the tmux session to monitor progress
tmux attach -t $command_name


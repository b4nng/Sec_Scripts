#!/bin/bash

# Check if file is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 ip_list.txt"
    exit 1
fi

# File containing the list of IPs
ip_file=$1

# Check if the file exists
if [ ! -f "$ip_file" ]; then
    echo "File not found: $ip_file"
    exit 1
fi

# Start a new tmux session named 'nmap_scan' and detach (-d)
tmux new-session -d -s nmap_scan

# Window counter for naming windows (starting from 1)
window_count=1

# Iterate over each IP in the file
while IFS= read -r ip; do
    # Create a new window for each IP and run nmap
    tmux new-window -t nmap_scan -n "scan_$window_count" "echo Running nmap for $ip; nmap -sT -sV $ip -p- --open -v2 -oA recon/nmap/$ip --min-rate=500 --max-scan-delay=0; exec bash"
    
    # Increment window count
    window_count=$((window_count + 1))
done < "$ip_file"

# Attach to the tmux session to monitor progress
tmux attach -t nmap_scan


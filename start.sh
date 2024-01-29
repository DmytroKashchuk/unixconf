#!/bin/bash

# Check if a session name was provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <session-name> [c] [hosts|h]"
    echo "c: use competitive vpn"
    echo "s: use starting point vpn"
    echo "no flag: start lab vpn"
    exit 1
fi

session=$1
vpn_file="/home/kali/Documents/lab_dimond.ovpn"
open_hosts=false

# Check for 'c' flag and change the vpn_file accordingly
if [[ " $* " == *" c "* ]]; then
    vpn_file="/home/kali/Documents/competitive_dimond.ovpn"
fi

# Check for 's' flag and change the vpn_file accordingly
if [[ " $* " == *" s "* ]]; then
    vpn_file="/home/kali/Documents/starting_dimond.ovpn"
fi

# Check for 'hosts' or 'h' flag
if [[ " $* " == *" hosts "* ]] || [[ " $* " == *" h "* ]]; then
    open_hosts=true
fi

# Check and create the 'nmap' directory if it doesn't exist
nmap_dir="/home/kali/Documents/htb/$session/nmap"
alias h="cd /home/kali/Documents/htb/$session"
session_dir="/home/kali/Documents/htb/$session"
if [ ! -d "$nmap_dir" ]; then
    mkdir -p "$nmap_dir" & clear
fi

# Check if the tmux session exists
if tmux has-session -t $session 2>/dev/null; then
    echo "Session $session already exists. Attaching..."
    tmux attach -t $session
    exit 0
fi

# Create a new tmux session with the first window named 'vpn'
tmux new-session -d -s $session -n vpn

# Start OpenVPN in the first pane of the 'vpn' window with the chosen configuration
tmux send-keys -t $session:vpn "echo 'kali' | sudo -S openvpn $vpn_file" C-m

# Create a new window named 'nmap'
tmux new-window -t $session:1 -n nmap

# In the 'nmap' window, navigate to the session directory
tmux send-keys -t $session:nmap "cd $session_dir" C-m

# If the 'hosts' or 'h' flag is set, open /etc/hosts with vim
if $open_hosts ; then
    tmux split-window -h -t $session:nmap
    tmux send-keys -t $session:nmap.1 "echo 'kali' | sudo -S vim /etc/hosts" C-m
fi

# Attach to the tmux session
tmux attach -t $session


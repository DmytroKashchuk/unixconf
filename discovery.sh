#!/bin/bash

# Check if an argument was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <arg>"
    exit 1
fi

arg=$1
window_name="discovery"

# Check if the 'discovery' window already exists
if tmux list-windows | grep -q "$window_name"; then
    echo "Window '$window_name' already exists. Attaching..."
    tmux select-window -t "$window_name"
else
    # Create a new window named 'discovery'
    tmux new-window -n "$window_name"

    # In the 'discovery' window, split the window into two panes
    tmux split-window -h

    # Select the first pane and run the ffuf subdomain discovery command
    tmux select-pane -t 0
    tmux send-keys "ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u http://$arg.htb -H 'Host: FUZZ.$arg.htb' -ac" C-m

    # Select the second pane and run the gobuster directory discovery command
    tmux select-pane -t 1
    tmux send-keys "gobuster dir -u http://$arg.htb/ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-words.txt -H 'Host: $arg.htb'" C-m
fi

# Attach to the tmux session
tmux attach-session


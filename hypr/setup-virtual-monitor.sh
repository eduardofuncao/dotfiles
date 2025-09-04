#!/bin/bash

# Wait for Hyprland to fully start
sleep 3

# Ensure headless backend is available
export WLR_BACKENDS=drm,headless

# Create the headless monitor
hyprctl output create headless VIRTUAL-1

hyprctl reload

# Wait a moment
sleep 2

# Start VNC server
wayvnc -o VIRTUAL-1 -f 60 -g 0.0.0.0 5900 &

echo "Headless monitor and VNC server started at $(date)"

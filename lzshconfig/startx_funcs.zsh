# Host-specific startup functions for the x server.

# Setup display output/multi-head settings
setup_multihead () {
	xrandr --output HDMI-A-0 --mode 1920x1080 --pos 0x0
	xrandr --output DisplayPort-2 --primary --auto --pos 1920x0
    # Fix screen tearing in Firefox fullscreen videos.
    xrandr --output HDMI-A-0 --set TearFree on
    xrandr --output DisplayPort-2 --set TearFree on
}

# Setup dynamic power management
setup_dpms () {
	xset s off
	xset dpms 0 0 0
}

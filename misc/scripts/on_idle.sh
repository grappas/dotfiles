#!/usr/bin/env bash

# hyprctl monitors
# Monitor DP-1 (ID 0):
# 	1920x1080@239.96400 at 0x0
# 	description: AOC 32G2WG8 PGZL9JA000750
# 	make: AOC
# 	model: 32G2WG8
# 	serial: PGZL9JA000750
# 	active workspace: 3 (3)
# 	special workspace: 0 ()
# 	reserved: 0 48 248 0
# 	scale: 1.00
# 	transform: 0
# 	focused: no
# 	dpmsStatus: 1
# 	vrr: 0
# 	activelyTearing: false
# 	disabled: false
# 	currentFormat: XRGB8888
# 	availableModes: 1920x1080@60.00Hz 1920x1080@239.96Hz 1920x1080@144.00Hz 1920x1080@120.00Hz 1920x1080@119.88Hz 1920x1080@119.98Hz 1920x1080@59.94Hz 1920x1080@50.00Hz 1680x1050@60.00Hz 1280x1024@75.03Hz 1280x1024@60.02Hz 1440x900@60.00Hz 1280x800@60.00Hz 1280x720@60.00Hz 1280x720@59.94Hz 1280x720@50.00Hz 1024x768@119.93Hz 1024x768@99.99Hz 1024x768@75.03Hz 1024x768@70.07Hz 1024x768@60.00Hz 832x624@74.55Hz 800x600@119.93Hz 800x600@99.86Hz 800x600@75.00Hz 800x600@72.19Hz 800x600@60.32Hz 800x600@56.25Hz 720x576@50.00Hz 720x480@60.00Hz 720x480@59.94Hz 640x480@119.80Hz 640x480@99.83Hz 640x480@75.00Hz 640x480@72.81Hz 640x480@66.67Hz 640x480@60.00Hz 640x480@59.94Hz 720x400@70.08Hz
#
# Monitor DP-3 (ID 1):
# 	3840x2160@59.99700 at 1920x0
# 	description: AOC U2879G6 0x00001102
# 	make: AOC
# 	model: U2879G6
# 	serial: 0x00001102
# 	active workspace: 4 (4)
# 	special workspace: 0 ()
# 	reserved: 248 48 0 0
# 	scale: 2.00
# 	transform: 0
# 	focused: yes
# 	dpmsStatus: 1
# 	vrr: 0
# 	activelyTearing: false
# 	disabled: false
# 	currentFormat: XRGB8888
# 	availableModes: 3840x2160@60.00Hz 3840x2160@30.00Hz 3840x2160@29.97Hz 3840x2160@25.00Hz 3840x2160@24.00Hz 3840x2160@23.98Hz 1920x2160@59.99Hz 2560x1440@59.95Hz 1920x1200@60.00Hz 1920x1080@60.00Hz 1920x1080@60.00Hz 1920x1080@59.94Hz 1920x1080@50.00Hz 1920x1080@50.00Hz 1600x1200@60.00Hz 1680x1050@59.95Hz 1280x1024@60.02Hz 1440x900@59.89Hz 1280x960@60.00Hz 1280x800@60.00Hz 1280x720@60.00Hz 1280x720@59.94Hz 1280x720@50.00Hz 1024x768@60.00Hz 800x600@60.32Hz 800x600@56.25Hz 720x576@50.00Hz 720x480@60.00Hz 720x480@59.94Hz 640x480@60.00Hz 640x480@59.94Hz
#
notyet=true
while $notyet; do
	workspaces_per_monitor="$(hyprctl monitors | grep "active workspace" | sed 's/^.*active workspace: //' | sed 's/\ .*//')"

	hctl_firefox="$(hyprctl clients | grep -B 4 "class: firefox")"
	ff_workspaces="$(echo "$hctl_firefox" | grep "workspace" | sed 's/^.*workspace: //' | sed 's/\ .*//')"
	again=false
	while read -r ff_workspace; do
		while read -r workspace; do
			if [ "$ff_workspace" == "$workspace" ]; then
				hyprctl dispatcher workspace "$workspace"
				hyprctl dispatcher workspace +2
				hyprctl dispatcher focusmonitor +1
				again=true
			fi
		done <<<"$workspaces_per_monitor"
	done <<<"$ff_workspaces"
	if ! $again; then
		notyet=false
	fi
	echo "$notyet"
done
sleep 2

hyprctl dispatcher dpms off

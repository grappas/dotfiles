#!/usr/bin/env bash
PREF="$HOME/.config/BraveSoftware/Brave-Browser/Default/Preferences"

if [ -f "$PREF" ]; then
    sed -i \
        -E 's/"exited_cleanly":\s*(false|true)/"exited_cleanly": true/' \
        -E 's/"exit_type":\s*"[^"]*"/"exit_type": "None"/' \
        "$PREF"
fi

# WARNING: use 2 spaces as delimiter in autostart_list.txt
while IFS='  ' read -r window_name app argument workspace; do
    uwsm app -- $app $argument
    while ! [ "$(hyprctl clients | grep -i "$window_name")" ]; do
        sleep 1
    done
    sleep 2
    hyprctl dispatch focuswindow "$window_name"
    sleep 0.5
    hyprctl dispatch movetoworkspacesilent "$workspace"
    sleep 0.5
    hyprctl dispatch workspace 1
done <~/.config/hypr/autostart_list.txt

sleep 1

echo "Starting Gqrx watchdog..."
"$(dirname "$0")"/gqrx-watchdog.sh &

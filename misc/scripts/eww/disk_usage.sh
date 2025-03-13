#!/usr/bin/env bash

poll="$(LANG=en df -h | grep -v tmpfs | grep -v '^dev' | grep -v run | grep -v efivars | grep -v Filesystem)"
line_to_print=""
while read -r disk size _used _avail use _mount; do
  #leave last node (after /)
  disk_trimmed=$(echo "$disk" | awk -F/ '{print $NF}')
  # trim % sign
  use_trimmed=${use//%/}
  bar=$(sh ~/.config/eww/scripts/display_single_usage_bar.sh "$use_trimmed")

  # LINE_TO_PRINT=$(echo "C $CORE_COUNTER |$PRINT_BAR| $(printf '%3s' $MAX_USAGE)% $(printf '%4.4s' $CORE_FREQUENCY )MHz")
  line_to_print="$(printf '%9s' "$disk_trimmed") $bar $(printf '%4s' "$use")/$(printf '%5.5s' "$size")"
  lines_to_print="$lines_to_print\n$line_to_print"
  # echo " $mount: $use% used"
done <<<"$poll"

lines_to_print=$(echo -e "$lines_to_print" | uniq)
echo "$lines_to_print"

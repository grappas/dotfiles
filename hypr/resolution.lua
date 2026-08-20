-- Machine-specific monitor layout.
-- Managed by ~/skrypty/reftoggle.sh, which cycles DP-1 through:
-- 240Hz (-- toggleme) -> 60Hz -> disabled -> 240Hz (-- toggleme) ...
-- When DP-1 is off, DP-3 sits at 0x0; when DP-1 is on, DP-3 shifts to 1920x0.
hl.monitor({ output = "DP-1", disabled = true })
hl.monitor({ output = "DP-3", mode = "3840x2160", position = "0x0", scale = 2 })

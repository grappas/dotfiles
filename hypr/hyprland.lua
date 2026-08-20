-- Migrated from the legacy hyprlang format, which is deprecated since
-- Hyprland 0.55 and will lose support entirely in 0.57.
-- See https://wiki.hypr.land/Configuring/Start/
-- The old hyprland.conf / resolution.conf are kept in this directory
-- (unused, ignored by Hyprland) purely as a rollback reference.

require("resolution")

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- DP-1 / DP-3 rules live in resolution.lua, toggled by ~/skrypty/reftoggle.sh
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

---------------------
---- MY PROGRAMS ----
---------------------

local mainMod  = "SUPER"
local terminal = "wezterm"
local editor   = "nvim"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("WLR_RENDERER", "vulkan")
hl.env("GTK_USE_PORTAL", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_USE_XINPUT2", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "2")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GTK_THEME", "gruvbox-dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6gtk2")
hl.env("MANGOHUD", "1")
-- hl.env("vblank_mode", "0")
hl.env("WINEFSYNC", "1")
-- mesa_glthread,true
hl.env("TERM", terminal)
hl.env("TERMINAL", terminal)
hl.env("GSCOPEA", "gamescope -W 1920 -H 1080 -f -F fsr --adaptive-sync")
hl.env("GSCOPEB", "-e --fsr-sharpness 20 --expose-wayland --rt -- gamemoderun mangohud")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("EDITOR", editor)
hl.env("VISUAL", editor)
hl.env("MANPAGER", "nvim -c 'Man!' -o -")
hl.env("DICPATH", "/run/current-system/sw/share/hunspell:/run/current-system/sw/share/hyphen")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24") -- zmień, jak masz sokoli wzrok

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 4,
        border_size = 4,

        col = {
            active_border   = { colors = { "rgba(FB4934ee)", "rgba(B8BB26ee)" }, angle = 135 },
            inactive_border = "rgba(595959aa)",
        },

        layout       = "dwindle",
        allow_tearing = true,
    },

    decoration = {
        rounding = 4,

        blur = {
            enabled = true,
            size    = 5,
            passes  = 1,
        },
        -- blur_new_optimizations = true,

        shadow = {
            range        = 15,
            render_power = 3,
            color        = "rgba(000000ee)",
        },

        dim_inactive = false,
        dim_strength = 0.4,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true, -- you probably want this
    },

    misc = {
        vrr                     = 3,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms  = true,
        focus_on_activate       = true,
        -- enable_swallow = true,
        -- swallow_exception_regex = "^(firefox)$",
        -- swallow_regex = "^(foot)$",
    },

    binds = {
        allow_workspace_cycles = true,
        scroll_event_delay     = 1,
    },

    debug = {
        disable_logs        = false,
        enable_stdout_logs  = true,
    },

    input = {
        kb_layout  = "pl",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        numlock_by_default = true,

        follow_mouse = 1,

        touchpad = {
            natural_scroll = false,
        },

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    },
})

-- Default animation curve + leaves (mirrors the old `bezier`/`animation` lines)
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 1, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 1, bezier = "default", style = "slidevert" })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Fixes flicker/resize-loop on the scaled monitor (Edge<->compositor resize feedback loop)
-- and ignores Edge's idle-inhibit requests (it holds one open for background tabs/video)
hl.window_rule({
    name  = "edge-fixes",
    match = { class = "^(microsoft-edge)$" },

    no_anim      = true,
    idle_inhibit = "none",
})

-- hl.window_rule({ match = { class = "^(gamescope-wl)$" },      immediate = true })
-- hl.window_rule({ match = { class = "^(cs2)$" },                immediate = true })
-- hl.window_rule({ match = { class = "^(dota2)$" },              immediate = true })
-- hl.window_rule({ match = { class = "^(soldat2)$" },            immediate = true })
-- hl.window_rule({ match = { class = "^(valheim.x86_64)$" },     immediate = true })
-- hl.window_rule({ match = { class = "^(SDL Application)$" },    immediate = true })
-- Note: per-window force_zero_scaling no longer exists in the new API;
-- xwayland.force_zero_scaling (global, all xwayland windows) is the closest equivalent.

---------------------
---- KEYBINDINGS ----
---------------------
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- and https://wiki.hypr.land/Configuring/Basics/Dispatchers/

hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd(terminal .. " -e byobu-tmux new-session"))
hl.bind(mainMod .. " + CTRL + Z", hl.dsp.exec_cmd(terminal .. " -e byobu-tmux"))
-- hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("uwsm app --  wezterm start"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("killall eww; uwsm stop && sleep 1 && uwsm start hyprland.desktop"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. terminal .. " -e /usr/bin/env bash -lc 'PATH=\"$HOME/.local/yazi-shims:$PATH\" yazi'"))
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- yazi.desktop"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("uwsm app -- org.kde.dolphin.desktop"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("uwsm app -- org.gnome.Nautilus.desktop"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("uwsm app --  ~/skrypty/eww_toggle.sh"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("uwsm app --  ~/skrypty/reftoggle.sh"))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("uwsm app -- rofi -modes \"run,ssh,drun,filebrowser\" -show drun"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("uwsm app --  rofi -modes \"run,ssh,drun,filebrowser\" -show drun"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + End", hl.dsp.exec_cmd("uwsm app --  sleep 1 && sudo systemctl suspend")) -- dwindle
hl.bind(mainMod .. " + SHIFT + End", hl.dsp.exec_cmd("uwsm app --  sudo systemctl hybrid-sleep")) -- dwindle
-- hl.bind(mainMod .. " + Home", hl.dsp.exec_cmd("uwsm app --  sh ~/skrypty/on_idle.sh"))
hl.bind(mainMod .. " + Home", hl.dsp.exec_cmd("uwsm app --  sleep 1 && hyprctl dispatch 'hl.dsp.dpms({action = \"off\"})'"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("uwsm app --  sh ~/skrypty/screenshot.sh area"))
hl.bind("Print", hl.dsp.exec_cmd("uwsm app --  sh ~/skrypty/screenshot.sh screen"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("uwsm app --  sh ~/skrypty/screenshot.sh active"))
-- hl.bind("Caps_Lock", hl.dsp.exec_cmd("uwsm app -- ydotool key -d 100 58:1 58:0"), { release = true })
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("uwsm app -- splatmoji --skin-tones light -l pl,en copypaste ~/instalancje/dotfiles/splatmoji/custom.tsv"))
hl.bind(mainMod .. " + Return", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + G", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + ALT + space", hl.dsp.exec_cmd("uwsm app --  wl-copy ​S! && ydotool key -d 100 29:1 47:1 47:0 29:0"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ workspace = "emptypm", follow = true }))
-- hl.bind(mainMod .. " + CTRL + l", hl.dsp.focus({ workspace = "emptynm" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ workspace = "r-1", follow = true }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ workspace = "emptynm", follow = true }))
hl.bind(mainMod .. " + CTRL + up",   hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ workspace = "emptypm", follow = true }))
-- hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "emptynm" }))
hl.bind(mainMod .. " + SHIFT + up",   hl.dsp.window.move({ workspace = "r-1", follow = true }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ workspace = "emptynm", follow = true }))
hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.window.move({ workspace = "r-1", follow = true }))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "emptynm", follow = true }))

hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + up",   hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume Control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("uwsm app --  pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("uwsm app --  pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("uwsm app --  pactl set-sink-mute @DEFAULT_SINK@ toggle"))

hl.bind("CTRL + SHIFT + S", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
hl.bind(mainMod .. " + SHIFT + F9",  hl.dsp.exec_cmd("uwsm app --  hyprctl eval 'hl.config({debug = {overlay = false}})'"))
hl.bind(mainMod .. " + SHIFT + F10", hl.dsp.exec_cmd("uwsm app --  hyprctl eval 'hl.config({debug = {overlay = true}})'"))
hl.bind(mainMod .. " + XF86AudioPlay", hl.dsp.exec_cmd("uwsm app --  sh ~/skrypty/bluetooth_play_toggle.sh"))
hl.bind(mainMod .. " + XF86AudioStop", hl.dsp.exec_cmd("uwsm app --  bluetoothctl disconnect 22:22:8E:85:5A:E5"))
-- hl.bind(mainMod .. " + u", hl.dsp.window.toggle_swallow())

-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("sh ~/.config/hypr/exec.sh") -- <-- machine specific options
    hl.exec_cmd("uwsm app -- arrpc")
    hl.exec_cmd("uwsm app -- alias yazi='PATH=\"$HOME/.local/yazi-shims:$PATH\" yazi'")
    hl.exec_cmd("uwsm app -- sleep 5 && sh ~/skrypty/nuclear.sh")
    hl.exec_cmd("uwsm app -- easyeffects --gapplication-service")
    hl.exec_cmd("uwsm app -- sh ~/skrypty/eww/collect_sensors_in_loop.sh")
    -- hl.exec_cmd("uwsm app -- sh ~/.config/swayidle/swayidle.sh")
    hl.exec_cmd("uwsm app -- hypridle&")
    hl.exec_cmd("uwsm app -- mako")
    hl.exec_cmd("uwsm app -- nm-applet --indicator")
    hl.exec_cmd("uwsm app -- blueman-applet")
    hl.exec_cmd("uwsm app -- /usr/lib/kdeconnectd")
    hl.exec_cmd("uwsm app -- kdeconnect-indicator")
    hl.exec_cmd("uwsm app -- steam -silent")
    hl.exec_cmd("$HOME/skrypty/workspace_starter.sh&")
    hl.exec_cmd("$HOME/skrypty/term-resizer.sh foot 1648 1000 12&")
    -- hl.exec_cmd("uwsm app -- sh ~/skrypty/wallpapers.sh 5m DP-1 DP-2")
    hl.exec_cmd("uwsm app -- sleep 10 && wpaperd")
    hl.exec_cmd("uwsm app -- touch /tmp/wakeup")
    hl.exec_cmd("uwsm app -- amixer -c 2 sset PCM playback 5dB")
    hl.exec_cmd("uwsm app -- amixer -c 3 sset PCM playback 5dB")
    hl.exec_cmd("uwsm app -- dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("uwsm app -- systemctl --user import-environment")
    hl.exec_cmd("uwsm app -- hyprshade auto")
    hl.exec_cmd("uwsm app -- /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("uwsm app -- waybar&")
    hl.exec_cmd("uwsm app -- sleep 5 && eww daemon && sleep 5 && eww open monitor1 && sleep 1 && eww open monitor2")
end)

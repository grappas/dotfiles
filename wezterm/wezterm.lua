local wezterm = require 'wezterm'
local act = wezterm.action
local mykeys = {
}

for i = 1, 8 do
    -- CTRL+ALT + number to activate that tab
    table.insert(mykeys, {
        key = tostring(i),
        mods = 'CTRL|ALT',
        action = act.ActivateTab(i - 1),
    })
    -- F1 through F8 to activate that tab
    table.insert(mykeys, {
        key = 'F' .. tostring(i),
        action = act.ActivateTab(i - 1),
    })
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_prog = { 'powershell.exe' }
else
    default_prog = { 'zsh' }
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    font = wezterm.font 'VictorMono NF'
else
    font = wezterm.font 'VictorMono Nerd Font'
end


-- if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
--     enable_wayland = false
-- else
--     enable_wayland = true
-- end

return {
    font = font,
    color_scheme = 'Gruvbox Dark',
    window_background_opacity = 0.9,
    default_prog = default_prog,
    enable_wayland = true,
    -- enable_wayland = enable_wayland,
    keys = {
        {
            key = 'F1',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F2',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F3',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F4',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F5',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F6',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F7',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F8',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F9',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F10',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F11',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'F12',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
    }
}

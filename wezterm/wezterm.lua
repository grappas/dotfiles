local wezterm = require 'wezterm'
local act = wezterm.action
local mykeys = {
}

local My_font_size = 16.0
local Font_size = My_font_size

function Recompute_font_size(window)
    local window_dims = window:get_dimensions()
    local overrides = window:get_config_overrides() or {}
    local Dpi = window_dims.dpi / 96

    local Scale_factor_general = 10
    local Scale_factor_x = Scale_factor_general * 9 * Dpi
    local Scale_factor_y = Scale_factor_general * 9 * Dpi

    if ((( window_dims.pixel_width / Scale_factor_x ) + ( window_dims.pixel_height / Scale_factor_y ))/2) > My_font_size
    then
        Font_size = My_font_size
    else
        Font_size = math.floor((( window_dims.pixel_width / Scale_factor_x ) + ( window_dims.pixel_height / Scale_factor_y ))/2)
    end
    overrides.font_size = Font_size
    window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window)
    Recompute_font_size(window)
end)

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
    Default_prog = { 'powershell.exe' }
else
    Default_prog = { 'zsh' }
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    Font = wezterm.font 'VictorMono NF'
else
    Font = wezterm.font 'VictorMono Nerd Font'
end


-- if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
--     enable_wayland = false
-- else
--     enable_wayland = true
-- end

return {
    font = Font,
    font_size = Font_size,
    color_scheme = 'GruvboxDark',
    window_background_opacity = 0.9,
    default_prog = Default_prog,
    enable_wayland = true,
    hide_tab_bar_if_only_one_tab = true,
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

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })
end

local wezterm = require 'wezterm'
return {
    font = wezterm.font 'VictorMono Nerd Font',
    color_scheme = 'Gruvbox Dark',
    window_background_opacity = 0.9,
}


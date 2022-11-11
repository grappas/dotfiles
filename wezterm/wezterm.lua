local wezterm = require 'wezterm'
local act = wezterm.action
local mykeys = {}

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

return {
    font = wezterm.font 'VictorMono Nerd Font',
    color_scheme = 'Gruvbox Dark',
    window_background_opacity = 0.9,
    keys = mykeys,
    default_prog = { 'zsh' },
}

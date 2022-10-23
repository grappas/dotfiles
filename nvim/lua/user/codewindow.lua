
local codewindow = require('codewindow')
codewindow.setup({
    exclude_filetypes = {
        'neo-tree',
        'terminal',
        'Terminal',
        'term',
        'zsh',
        'powershell',
        'Powershell',
        'powershell.exe',
        'Powershell.exe'
    }
})
codewindow.apply_default_keybinds()
codewindow.open_minimap()

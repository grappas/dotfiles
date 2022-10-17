GuiTabline 0
set guifont=UbuntuMono\ Nerd\ Font\ Mono:h18
call GuiClipboard()
GuiPopupmenu 0

lua << EOF
require("catppuccin").setup({
transparent_background = false
}
vim.api.nvim_command "colorscheme catppuccin"
EOF

nnoremap <C-S-v> <c-\><c-n>"+p
tnoremap <C-S-v> <c-\><c-n>"+pi
cnoremap <C-S-v> <c-r>+

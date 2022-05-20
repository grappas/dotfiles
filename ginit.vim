GuiTabline 0
set guifont=UbuntuMono\ Nerd\ Font\ Mono:h18
call GuiClipboard()
GuiPopupmenu 0

let g:gruvbox_transparent_bg=0
set! termguicolors
autocmd! VimEnter * hi
colorscheme gruvbox

nnoremap <C-S-v> <c-\><c-n>"+p
tnoremap <C-S-v> <c-\><c-n>"+pi
cnoremap <C-S-v> <c-r>+

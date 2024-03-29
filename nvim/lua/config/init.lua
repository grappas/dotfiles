local options = {
	termguicolors = true,
	number = true,
	mouse = a,
	colorscheme = gruvbox
}
vim.cmd([[

let g:rainbow_active = 1
set termguicolors
set number
set autoindent
set ic
set wrap
set linebreak
set mouse=a
set showmatch
set title
set foldmethod=marker

let g:gruvbox_italic=1

colorscheme gruvbox

set hlsearch
set incsearch
set clipboard=unnamedplus
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smartcase
set undofile
set modifiable
set scrolloff=5
set noshowmode
set laststatus=2
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
syntax on

if has('win64')
    set shell=powershell.exe
    set shellxquote=
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote   = ''
    let &shellpipe    = '| Out-File -Encoding UTF8 %s'
    let &shellredir   = '| Out-File -Encoding UTF8 %s'
endif
nmap  -  <Plug>(choosewin)

" matchup
"
let g:loaded_matchit = 1
let g:choosewin_overlay_enable = 1

filetype plugin on

" Give more space for displaying messages.
set nocompatible
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

highlight ColorColumn ctermbg=0 guibg=lightgrey

" Vim Crosshairs
set cursorline
set cursorcolumn

]])

vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)

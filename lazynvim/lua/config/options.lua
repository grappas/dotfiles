local options = {
  termguicolors = true,
  number = true,
  autoindent = true,
  ic = true,
  wrap = true,
  linebreak = true,
  mouse = "a",
  showmatch = true,
  title = true,
  foldmethod = "marker",
  hlsearch = true,
  incsearch = true,
  -- relativenumber = true,
  clipboard = "unnamedplus",
  -- statuscolumn = "%l %r",
}

vim.g.autoformat = false

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd([[
let g:rainbow_active = 1

let g:gruvbox_italic=1

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

]])

vim.keymap.set({ "n", "x" }, "<leader>sr", function()
  require("ssr").open()
end)

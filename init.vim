
lua require('plugins')
call plug#begin()
Plug 'wbthomason/packer.nvim'
Plug 'junegunn/vim-plug'
Plug 'preservim/NERDTree'
Plug 'machakann/vim-highlightedyank'
Plug 'frazrepo/vim-rainbow'
Plug 'rockerBOO/awesome-neovim'
Plug 'flazz/vim-colorschemes'
Plug 'ThePrimeagen/vim-be-good'
" Git
Plug 'tpope/vim-fugitive'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code commenter
Plug 'preservim/nerdcommenter'
"
" Syntax highlighting
Plug 'dense-analysis/ale'
"
" Statusbar
Plug 'itchyny/lightline.vim'
"
" Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File finder
Plug 'vifm/vifm.vim'

" Theme
Plug 'morhetz/gruvbox'

" Tabs
Plug 'ap/vim-buftabline'
Plug 'elzr/vim-json'
Plug 'vim-scripts/zoom.vim'
call plug#end()

let g:rainbow_active = 1
set number
set autoindent
set ic
set mouse=a
set showmatch
set title
colorscheme gruvbox
set hlsearch
set incsearch
set guifont=Ubuntu\ Mono:h12
set clipboard=unnamedplus
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set smartcase
set undofile
set modifiable
set scrolloff=5

" Give more space for displaying messages.
set nocompatible
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

highlight ColorColumn ctermbg=0 guibg=lightgrey

map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
map <C-f> :Rg<CR>
map <C-t> :e <cfile><cr>
map <S-Tab> :bn<CR>
map <silent> <C-kPlus> :ZoomIn<Enter>
map <silent> <C-kMinus> :ZoomOut<Enter>
let mapleader = " "

" CoC
" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

" Sweet Sweet FuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" Search and replace hotkey
nnoremap H :%s//gc<left><left><left>

" Move highlighted text up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Import plugins
if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

" Status bar config
set statusline+=%#warningmsg#

" Fix files automatically on save
let g:ale_fixers = {}
let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
  \'javascript': ['eslint'],
  \'vue': ['eslint', 'stylelint', 'tsserver'],
\}

let g:ale_fixers = {
  \'javascript': ['prettier', 'eslint'],
  \'vue': ['eslint', 'stylelint'],
\}

let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_fix_on_save = 1

" Close NERDTree when closing the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
syntax on
inoremap mmmmm <Esc>
vnoremap mmmmm <Esc>
nnoremap n nzzzv
nnoremap N Nzzzv

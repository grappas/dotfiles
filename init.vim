"##############################	VIM-PLUG ###################################
"############################################################################

call plug#begin()

Plug 'junegunn/vim-plug'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'andweeb/presence.nvim'

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'machakann/vim-highlightedyank'
Plug 'frazrepo/vim-rainbow'
Plug 'gruvbox-community/gruvbox'
Plug 'liuchengxu/vim-clap'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
Plug 'elzr/vim-json'
Plug 'vim-scripts/zoom.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'andymass/vim-matchup'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'lewis6991/gitsigns.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }

call plug#end()
if has('linux')
    call plug#begin()
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
    call plug#end()
endif

"##############################	 CONFIG   ###################################
"############################################################################
"
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
let g:gruvbox_italic=1

let g:gruvbox_transparent_bg=1
set termguicolors
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
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

" matchup
let g:loaded_matchit = 1

" fast cargo call
command CRun :w | !cargo run

map <C-n> :NeoTreeFocusToggle<CR>

filetype plugin on

" Give more space for displaying messages.
set nocompatible
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

highlight ColorColumn ctermbg=0 guibg=lightgrey

" FZF
map <C-p> :Files<CR>
map <C-f> :Rg<CR>
map <C-t> :e <cfile><cr>
"

" a co to?
map <S-Tab> :bn<CR>

" Zoom
map <silent> <C-kPlus> :ZoomIn<Enter>
map <silent> <C-kMinus> :ZoomOut<Enter>

" Sweet Sweet FuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" Move highlighted text up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" Status bar config
set statusline+=%#warningmsg#

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \	 'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
            \	 fzf#vim#with_preview(), <bang>0)

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

au BufReadPost *.ezt set syntax=html

nnoremap o o<Esc>
nnoremap O O<Esc>

nnoremap Y y$

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

"Terminal Mode

tnoremap <Esc> <C-\><C-n>
command Terminal :below 7split | terminal

"switch buffers
nnoremap <C-h> :bprev<CR>
nnoremap <C-j> :bnext<CR>

"toggle comment
"nnoremap <C-Bslash> :call nerdcommenter#Comment('0', 'toggle')<CR>
"vnoremap <C-Bslash> :call nerdcommenter#Comment('0', 'toggle')<CR>
"inoremap <C-Bslash> :call nerdcommenter#Comment('0', 'toggle')<CR>

map <C-Bslash> <plug>NERDCommenterToggle

"##############################	AIRLINE	###################################
"############################################################################

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1



"##############################		COC		###################################
"############################################################################


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=5

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]	=~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f	<Plug>(coc-format-selected)
nmap <leader>f	<Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a	<Plug>(coc-codeaction-selected)
nmap <leader>a	<Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac	<Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf	<Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call		 CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR	 :call		 CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a	:<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e	:<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c	:<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o	:<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s	:<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j	:<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k	:<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p	:<C-u>CocListResume<CR>


"##############################	   END	  ###################################
"############################################################################

lua << EOF

-- The setup config table shows all available config options with their default values:
require("presence"):setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

EOF

lua << EOF

local config = {
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    -- popup_border_style is for input and confirmation dialogs.
    -- Configurtaion of floating window is done in the individual source sections.
    -- "NC" is a special style that works well with NormalNC set
    close_floats_on_escape_key = true,
    default_source = "filesystem",
enable_diagnostics = true,
  enable_git_status = true,
  git_status_async = true,
  log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
  log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
  open_files_in_last_window = true, -- false = open files in top left window
  popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
  resize_timer_interval = 50, -- in ms, needed for containers to redraw right aligned and faded content
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
  --
  --event_handlers = {
      --  {
          --    event = "before_render",
          --    handler = function (state)
          --      -- add something to the state that can be used by custom components
          --    end
          --  },
          --  {
              --    event = "file_opened",
              --    handler = function(file_path)
              --      --auto close
              --      require("neo-tree").close_all()
              --    end
              --  },
              --  {
                  --    event = "file_opened",
                  --    handler = function(file_path)
                  --      --clear search after opening a file
                  --      require("neo-tree.sources.filesystem").reset_search()
                  --    end
                  --  },
                  --  {
                      --    event = "file_renamed",
                      --    handler = function(args)
                      --      -- fix references to file
                      --      print(args.source, " renamed to ", args.destination)
                      --    end
                      --  },
                      --  {
                          --    event = "file_moved",
                          --    handler = function(args)
                          --      -- fix references to file
                          --      print(args.source, " moved to ", args.destination)
                          --    end
                          --  },
                          --  {
                              --    event = "neo_tree_buffer_enter",
                              --    handler = function()
                              --      vim.cmd 'highlight! Cursor blend=100'
                              --    end
                              --  },
                              --  {
                                  --    event = "neo_tree_buffer_leave",
                                  --    handler = function()
                                  --      vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
                                  --    end
                                  --  }
                                  --},
                                  default_component_configs = {
                                      indent = {
                                          indent_size = 2,
                                          padding = 1,
                                          -- indent guides
                                          with_markers = true,
                                          indent_marker = "│",
                                          last_indent_marker = "└",
                                          highlight = "NeoTreeIndentMarker",
                                          -- expander config, needed for nesting files
                                          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                                          expander_collapsed = "",
                                          expander_expanded = "",
                                          expander_highlight = "NeoTreeExpander",
                                          },
                                      icon = {
                                          folder_closed = "",
                                          folder_open = "",
                                          folder_empty = "ﰊ",
                                          default = "*",
                                          },
                                      modified = {
                                          symbol = "[+]",
                                          highlight = "NeoTreeModified",
                                          },
                                      name = {
                                          trailing_slash = false,
                                          use_git_status_colors = true,
                                          },
                                      git_status = {
                                          symbols = {
                                              -- Change type
                                              added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
                                              deleted   = "✖",
                                              modified  = "",
                                              renamed   = "",
                                              -- Status type
                                              untracked = "",
                                              ignored   = "",
                                              unstaged  = "",
                                              staged    = "",
                                              conflict  = "",
                                              },
                                          align = "right",
                                          },
                                      },
                                  renderers = {
                                      directory = {
                                          { "indent" },
                                          { "icon" },
                                          { "current_filter" },
                                          {
                                                  "container",
                                                  width = "100%",
                                                  right_padding = 1,
                                                  --max_width = 60,
                                                  content = {
                                                      { "name", zindex = 10 },
                                                      -- {
                                                          --   "symlink_target",
                                                          --   zindex = 10,
                                                          --   highlight = "NeoTreeSymbolicLinkTarget",
                                                          -- },
                                                          { "clipboard", zindex = 10 },
                                                          { "diagnostics", errors_only = true, zindex = 20, align = "right" },
                                                          },
                                                      },
                                                  },
                                              file = {
                                                  { "indent" },
                                                  { "icon" },
                                                  {
                                                          "container",
                                                          width = "100%",
                                                          right_padding = 1,
                                                          --max_width = 60,
                                                          content = {
                                                              {
                                                                      "name",
                                                                      use_git_status_colors = true,
                                                                      zindex = 10
                                                                      },
                                                                  -- {
                                                                      --   "symlink_target",
                                                                      --   zindex = 10,
                                                                      --   highlight = "NeoTreeSymbolicLinkTarget",
                                                                      -- },
                                                                      { "clipboard", zindex = 10 },
                                                                      { "bufnr", zindex = 10 },
                                                                      { "modified", zindex = 20, align = "right" },
                                                                      { "diagnostics",  zindex = 20, align = "right" },
                                                                      { "git_status", zindex = 20, align = "right" },
                                                                      },
                                                                  },
                                                              },
                                                          },
                                                      nesting_rules = {},
                                                      window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
                                                      -- possible options. These can also be functions that return these options.
                                                      position = "left", -- left, right, float, current
                                                      width = 40, -- applies to left and right positions
                                                      popup = { -- settings that apply to float position only
                                                      size = {
                                                          height = "80%",
                                                          width = "50%",
                                                          },
                                                      position = "50%", -- 50% means center it
                                                      -- you can also specify border here, if you want a different setting from
                                                      -- the global popup_border_style.
                                                      },
                                                  -- Mappings for tree window. See `:h nep-tree-mappings` for a list of built-in commands.
                                                  -- You can also create your own commands by providing a function instead of a string.
                                                  mappings = {
                                                      ["<space>"] = "toggle_node",
                                                      ["<2-LeftMouse>"] = "open",
                                                      ["<cr>"] = "open",
                                                      ["S"] = "open_split",
                                                      ["s"] = "open_vsplit",
                                                      ["t"] = "open_tabnew",
                                                      ["C"] = "close_node",
                                                      ["z"] = "close_all_nodes",
                                                      ["R"] = "refresh",
                                                      ["a"] = "add",
                                                      ["A"] = "add_directory",
                                                      ["d"] = "delete",
                                                      ["r"] = "rename",
                                                      ["y"] = "copy_to_clipboard",
                                                      ["x"] = "cut_to_clipboard",
                                                      ["p"] = "paste_from_clipboard",
                                                      ["c"] = "copy", -- takes text input for destination
                                                      ["m"] = "move", -- takes text input for destination
                                                      ["q"] = "close_window",
                                                      },
                                                  },
                                              filesystem = {
                                                  window = {
                                                      mappings = {
                                                          ["H"] = "toggle_hidden",
                                                          ["/"] = "fuzzy_finder",
                                                          --["/"] = "filter_as_you_type", -- this was the default until v1.28
                                                          ["f"] = "filter_on_submit",
                                                          ["<C-x>"] = "clear_filter",
                                                          ["<bs>"] = "navigate_up",
                                                          ["."] = "set_root",
                                                          }
                                                      },
                                                  bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
                                                  -- The renderer section provides the renderers that will be used to render the tree.
                                                  --   The first level is the node type.
                                                  --   For each node type, you can specify a list of components to render.
                                                  --       Components are rendered in the order they are specified.
                                                  --         The first field in each component is the name of the function to call.
                                                  --         The rest of the fields are passed to the function as the "config" argument.
                                                  filtered_items = {
                                                      visible = false, -- when true, they will just be displayed differently than normal items
                                                      hide_dotfiles = true,
                                                      hide_gitignored = true,
                                                      hide_by_name = {
                                                          ".DS_Store",
                                                          "thumbs.db"
                                                          --"node_modules"
                                                          },
                                                      never_show = { -- remains hidden even if visible is toggled to true
                                                      --".DS_Store",
                                                      --"thumbs.db"
                                                      },
                                                  },
                                              find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
                                              -- `true` will change the filter into a full path
                                              -- search with space as an implicit ".*", so
                                              -- `fi init`
                                              -- will match: `./sources/filesystem/init.lua
                                              --find_command = "fd", -- this is determined automatically, you probably don't need to set it
                                              --find_args = {  -- you can specify extra args to pass to the find command.
                                              --  fd = {
                                                  --  "--exclude", ".git",
                                                  --  "--exclude",  "node_modules"
                                                  --  }
                                                  --},
                                                  ---- or use a function instead of list of strings
                                                  --find_args = function(cmd, path, search_term, args)
                                                  --  if cmd ~= "fd" then
                                                  --    return args
                                                  --  end
                                                  --  --maybe you want to force the filter to always include hidden files:
                                                  --  table.insert(args, "--hidden")
                                                  --  -- but no one ever wants to see .git files
                                                  --  table.insert(args, "--exclude")
                                                  --  table.insert(args, ".git")
                                                  --  -- or node_modules
                                                  --  table.insert(args, "--exclude")
                                                  --  table.insert(args, "node_modules")
                                                  --  --here is where it pays to use the function, you can exclude more for
                                                  --  --short search terms, or vary based on the directory
                                                  --  if string.len(search_term) < 4 and path == "/home/cseickel" then
                                                  --    table.insert(args, "--exclude")
                                                  --    table.insert(args, "Library")
                                                  --  end
                                                  --  return args
                                                  --end,
                                                  search_limit = 50, -- max number of search results when using filters
                                                  follow_current_file = false, -- This will find and focus the file in the active buffer every time
                                                  -- the current file is changed while the tree is open.
                                                  hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                                  -- "open_current",-- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                                  -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                                                  use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                                  -- instead of relying on nvim autocmd events.
                                                  },
                                              buffers = {
                                                  bind_to_cwd = true,
                                                  window = {
                                                      mappings = {
                                                          ["<bs>"] = "navigate_up",
                                                          ["."] = "set_root",
                                                          ["bd"] = "buffer_delete",
                                                          },
                                                      },
                                                  },
                                              git_status = {
                                                  window = {
                                                      mappings = {
                                                          ["A"] = "git_add_all",
                                                          ["gu"] = "git_unstage_file",
                                                          ["ga"] = "git_add_file",
                                                          ["gr"] = "git_revert_file",
                                                          ["gc"] = "git_commit",
                                                          ["gp"] = "git_push",
                                                          ["gg"] = "git_commit_and_push",
                                                          },
                                                      },
                                                  },
                                              }

EOF

lua << EOF

local load_config = function()
  require("nvim-treesitter.configs").setup({
    context_commentstring = {
      enable = true,
    },
    ensure_installed = "maintained",
    highlight = {
      enable = true,
    },
  })
end

EOF

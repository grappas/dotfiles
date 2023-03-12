return {
    'folke/lazy.nvim',
    'nvim-lua/plenary.nvim',
    { 'ibhagwan/smartyank.nvim',
        config = function() require'smartyank'.setup {} end
    },

    -- cmp plugins
    'hrsh7th/nvim-cmp', -- The completion plugin
    'hrsh7th/cmp-buffer', -- buffer completions
    'hrsh7th/cmp-path', -- path completions
    'hrsh7th/cmp-cmdline', -- commandline completions
    'saadparwaiz1/cmp_luasnip', -- snippet completions
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',

    -- snippets
    --use({ "L3MON4D3/LuaSnip"}) --snippet engine
    --use({ "rafamadriz/friendly-snippets"}) -- a bunch of snippets to use

    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-vsnip',

    -- LSP
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',

    --use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
    --use({ "jayp0521/mason-null-ls.nvim" }) -- for formatters and linters

    'mfussenegger/nvim-dap',
    {
        'lvimuser/lsp-inlayhints.nvim',
        config = function()
            require("lsp-inlayhints").setup{
                inlay_hints = {
                    parameter_hints = {
                        prefix = " <- "
                    }
                }
            }
        end
    },
    --use({'simrat39/rust-tools.nvim'})

    -- fzf-lua
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    -- transition
    't9md/vim-choosewin',
    'lukas-reineke/indent-blankline.nvim',

    'nvim-lua/popup.nvim',
    'andweeb/presence.nvim',

    'tpope/vim-fugitive',

    'RishabhRD/popfix',
    'RishabhRD/nvim-cheat.sh',

    'frazrepo/vim-rainbow',

    'liuchengxu/vim-clap',
    'ryanoasis/vim-devicons',
    --use { 'preservim/nerdcommenter' }
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    'elzr/vim-json',
    'vim-scripts/zoom.vim',

    'andymass/vim-matchup',

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },

    { "iamcco/markdown-preview.nvim", build = "cd app && yarn install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, },

    'lewis6991/gitsigns.nvim',
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'airblade/vim-rooter',

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
    },
    'echasnovski/mini.nvim',
    'gorbit99/codewindow.nvim',
    -- minimap let's try it
    'ziontee113/neo-minimap',

    {
        "cshuaimin/ssr.nvim",
        module = "ssr",
        -- Calling setup is optional.
        config = function()
            require("ssr").setup {
                min_width = 50,
                min_height = 5,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_all = "<leader><cr>",
                },
            }
        end
    },
    {'sakhnik/nvim-gdb',
        build = ':!./install.sh'},
    {
        'willothy/flatten.nvim',
        config = true
        -- or pass configuration with
        -- opts = {  }
    }
}

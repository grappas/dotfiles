return {
    'folke/lazy.nvim',
    'nvim-lua/plenary.nvim',
    { 'ibhagwan/smartyank.nvim',
        config = function() require'smartyank'.setup {} end
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
    {
        'willothy/flatten.nvim',
        config = true
        -- or pass configuration with
        -- opts = {  }
    }
}

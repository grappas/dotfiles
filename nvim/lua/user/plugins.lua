
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we dont error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here

    use({ "wbthomason/packer.nvim"}) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim"}) -- Useful lua functions used by lots of plugins
    use { 'ibhagwan/smartyank.nvim',
        config = function() require'smartyank'.setup {} end
    }
    use ({'bronson/vim-crosshairs'})

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp"}) -- The completion plugin
    use({ "hrsh7th/cmp-buffer"}) -- buffer completions
    use({ "hrsh7th/cmp-path"}) -- path completions
    use({ "hrsh7th/cmp-cmdline"}) -- commandline completions
    use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp"})
    use({ "hrsh7th/cmp-nvim-lua"})

    -- snippets
    --use({ "L3MON4D3/LuaSnip"}) --snippet engine
    --use({ "rafamadriz/friendly-snippets"}) -- a bunch of snippets to use

    use ({'hrsh7th/vim-vsnip'})
    use ({'hrsh7th/cmp-vsnip'})

    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    --use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
    --use({ "jayp0521/mason-null-ls.nvim" }) -- for formatters and linters

    use 'mfussenegger/nvim-dap'
    use({
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
    })
    --use({'simrat39/rust-tools.nvim'})

    -- fzf-lua
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- transition
    use { 't9md/vim-choosewin' }
    use { 'lukas-reineke/indent-blankline.nvim' }

    use { 'nvim-lua/popup.nvim' }
    use { 'andweeb/presence.nvim' }

    use { 'tpope/vim-fugitive' }
    use { 'vim-airline/vim-airline' }
    use { 'vim-airline/vim-airline-themes' }

    use { 'RishabhRD/popfix' }
    use { 'RishabhRD/nvim-cheat.sh' }

    use { 'frazrepo/vim-rainbow' }
    use { 'gruvbox-community/gruvbox' }

    use { 'liuchengxu/vim-clap' }
    use { 'ryanoasis/vim-devicons' }
    use { 'preservim/nerdcommenter' }
    use { 'elzr/vim-json' }
    use { 'vim-scripts/zoom.vim' }

    use { 'andymass/vim-matchup' }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    use { 'lewis6991/gitsigns.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'MunifTanjim/nui.nvim' }
    use { 'airblade/vim-rooter' }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
    }
    use { 'echasnovski/mini.nvim' }
    use { 'gorbit99/codewindow.nvim' }
    -- minimap let's try it
    use ({'ziontee113/neo-minimap'})

    use ({'Shatur/neovim-session-manager'})

    if LINUX then
        use {'sakhnik/nvim-gdb',
            run = ':!./install.sh'}
    end

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)


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
	use({ "windwp/nvim-autopairs"}) -- Autopairs, integrates with both cmp and treesitter
    use { 'ibhagwan/smartyank.nvim' }

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp"}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer"}) -- buffer completions
	use({ "hrsh7th/cmp-path"}) -- path completions
	use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp"})
	use({ "hrsh7th/cmp-nvim-lua"})

	-- snippets
	use({ "L3MON4D3/LuaSnip"}) --snippet engine
	use({ "rafamadriz/friendly-snippets"}) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig"}) -- enable LSP
    use { "williamboman/mason.nvim" }
	use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter"
	})

    -- fzf-lua
    use { 'ibhagwan/fzf-lua' }
    use { 'junegunn/fzf', run = './install --bin', }

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

    use { 'machakann/vim-highlightedyank' }
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

    if LINUX then
        use {'sakhnik/nvim-gdb',
        run = ':!./install.sh'}
    end

	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

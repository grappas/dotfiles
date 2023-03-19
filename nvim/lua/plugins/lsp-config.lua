return {
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
    'rcarriga/nvim-dap-ui',
    'ldelossa/nvim-dap-projects',
    'folke/neodev.nvim',
    'lvimuser/lsp-inlayhints.nvim',
    'jay-babu/mason-nvim-dap.nvim',
}

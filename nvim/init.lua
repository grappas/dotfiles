local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')
require("config.presence")
require("config.config")
require("config.blankline")
require("config.neotree")
require("config.treesitter")
require("config.cmp")
require("config.nvim-lspconfig")
require("config.mini")
require("config.neo-minimap")
require("config.print_r")
require("config.kbd")

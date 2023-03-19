return {
    'bronson/vim-crosshairs',
    lazy = false,
    init = function()
        vim.opt_global.cursorline = true
        vim.opt_global.cursorcolumn = true
    end,
}

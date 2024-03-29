return {
    'ellisonleao/gruvbox.nvim',
    init = function ()
        require("gruvbox").setup({
            undercurl = true,
            underline = true,
            bold = true,
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            italic = {
                strings = false
            },
            dim_inactive = false,
            transparent_mode = true,
        })
        vim.cmd("colorscheme gruvbox")
    end
}

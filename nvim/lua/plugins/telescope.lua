return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        init = function()
            require('telescope').setup{}
        end
    },
}

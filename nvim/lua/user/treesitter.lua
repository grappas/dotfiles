
local load_config = function()
  require("nvim-treesitter.configs").setup({
    context_commentstring = {
      enable = true,
    },
    ensure_installed = "maintained",
    highlight = {
      enable = true,
    },
    indent = {
        enable = true,
    }
  })
end


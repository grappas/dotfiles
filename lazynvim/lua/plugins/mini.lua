return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.pairs").setup()
    require("mini.ai").setup()
    require("mini.indentscope").setup()
    require("mini.surround").setup()
    require("mini.jump2d").setup()
  end,
}

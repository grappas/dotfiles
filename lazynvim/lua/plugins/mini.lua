return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.ai").setup()
    require("mini.indentscope").setup()
    require("mini.jump2d").setup()
  end,
}

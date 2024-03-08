return {
  {
    "bloznelis/before.nvim",
    config = function()
      require("before").setup({
        -- How many edit locations to store in memory (default: 10)
        history_size = 42,
      })
    end,
  },
}

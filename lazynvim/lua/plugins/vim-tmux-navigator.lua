return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  opt = {
    n = {
      ["<C-h>"] = { "<cmd> TmyxNavigateLeft<CR>", "window left" },
      ["<C-l>"] = { "<cmd> TmyxNavigateRight<CR>", "window right" },
      ["<C-j>"] = { "<cmd> TmyxNavigateDown<CR>", "window down" },
      ["<C-k>"] = { "<cmd> TmyxNavigateUp<CR>", "window up" },
    },
  },
}

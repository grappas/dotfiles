return {
  "neovim/nvim-lspconfig",
  opts = {
    autoformat = false,
    inlay_hints = {
      enabled = true,
    },
    servers = {
      -- Ensure mason installs the server
      clangd = {
        mason = false,
        keys = {
          { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
      },
    },
  },
}

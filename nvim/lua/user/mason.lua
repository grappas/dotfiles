require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})


require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "rust_analyzer", "clangd", "bash-language-server", "bash-debug-adapter", "cpptools", "cpplint", "cspell", "cmakelang", "clang-format", "luaformatter", "prettier", "prettierd" },
    automatic_installation = true,
})


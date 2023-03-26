
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

    ensure_installed = {
        "lua_ls",
        "pyright",
        "awk_ls",
        "bashls",
        "clangd",
        "cmake",
        "jsonls",
        "gopls",
        "vimls",
        "rust_analyzer",
    }

})

require("lsp-inlayhints").setup{
    inlay_hints = {
        parameter_hints = {
            prefix = " <- "
        }
    }
}

--require("null-ls").setup({
--sources = {
--require("null-ls").builtins.formatting.prettierd,
--require("null-ls").builtins.diagnostics.eslint_d,
--},
--})

--require("mason-null-ls").setup({
--ensure_installed = {
--"stylua",
--"jq",
--"clangd-format",
--"eslint_d",
--"cpplint",
--"cspell",
--"prettier",
--"prettierd"
--}
--})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local navbuddy = require("nvim-navbuddy")
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    navbuddy.attach(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require'lspconfig'

require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = "LspAttach_inlayhints",
            callback = function(args)
                if not (args.data and args.data.client_id) then
                    return
                end

                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                require("lsp-inlayhints").on_attach(client, bufnr)
            end,
        })
    end,
}

lspconfig.lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            hint = {
                enable = true,
            }
        },
    },
}



require("dapui").setup()
require('nvim-dap-projects').search_project_config()
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("mason-nvim-dap").setup({
    ensure_installed = { "cpptools" },
    automatic_setup = true,
})
require 'mason-nvim-dap'.setup_handlers {}

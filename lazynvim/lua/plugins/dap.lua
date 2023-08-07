return {
    {
        'ldelossa/nvim-dap-projects',
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                -- {
                --     'Joakker/lua-json5',
                --     build = './install.sh'
                -- },
                "jay-babu/mason-nvim-dap.nvim",
                event = "BufReadPre", -- <-- this
            },
        },
        opts = function()
            -- require("dap.ext.vscode").json_decode = require("json5").parse
            require("dap.ext.vscode").load_launchjs(".vscode/launch.json")
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.open()
            end
            dap.adapters.cpp = {
                id = "cppdbg",
                name = "cppdbg",
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
            }
            local continue = function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("dap.ext.vscode").load_launchjs(".vscode/launch.json")
                end

                if vim.fn.filereadable(".nvim/nvim-dap.lua") then
                    require('nvim-dap-projects').search_project_config()
                end
                require("dap").continue()
            end
            vim.keymap.set("n", "<leader>dc", continue)
        end,
    }
}

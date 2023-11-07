return {
    "nvim-telescope/telescope-dap.nvim",

    {
        "mfussenegger/nvim-dap",

        keys = {
            {
                "<F9>",
                function() require("dap").toggle_breakpoint() end,
                desc = "DAP - Toggle Breakpoint"
            },
            {
                "<F10>",
                function() require("dap").step_over() end,
                desc = "DAP - Step Over"
            },
            {
                "<F11>",
                function() require("dap").step_into() end,
                desc = "DAP - Step Into"
            },
            {
                "<leader>dR",
                function() require("dap").restart() end,
                desc = "DAP - Restart"
            },
            {
                "<leader>dC",
                function() require("dap").clear_breakpoints() end,
                desc = "DAP - Clear Breakpoints"
            },
            {
                "<leader>db",
                function() require("dap").list_breakpoints(true) end,
                desc = "DAP - List Breakpoints"
            },
            {
                "<leader>dc",
                function() require("dap").continue() end,
                desc = "DAP - Continue"
            },
            {
                "<leader>de",
                function() require("dap").set_exception_breakpoints({ "all" }) end,
                desc = "DAP - Enable Exception Breakpoints"
            },
            {
                "<leader>di",
                function() require("dap.ui.widgets").hover() end,
                mode = { "n", "v" },
                desc = "DAP - Hover Info"
            },
            {
                "<leader>dp",
                function() require("dap.ui.widgets").preview() end,
                mode = { "n", "v" },
                desc = "DAP - Preview"
            },
            {
                "<leader>dr",
                function() require("dap").repl.open({}, "vsplit") end,
                desc = "DAP - Open REPL"
            },
            {
                "<leader>ds",
                function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end,
                desc = "DAP - Open Scopes"
            },
            {
                "<leader>dv",
                function() require("telescope").extensions.dap.variables() end,
                desc = "DAP - Open Variables"
            },
            {
                "<leader>df",
                function() require("telescope").extensions.dap.frames() end,
                desc = "DAP - Open Frames"
            },

            {
                "<leader>dq",
                function()
                    require("dap").terminate(nil, nil, function()
                        vim.api.nvim_command(":DapVirtualTextForceRefresh")
                    end)
                end,

                desc = "DAP - Quit"
            },
        },

        config = function()
            local Path = require("plenary.path")
            local dap = require("dap")

            local DAP_BASEPATH = Path:new(vim.fn.stdpath("data"), "mason", "bin")

            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = tostring(Path:new(DAP_BASEPATH, "OpenDebugAD7"))
            }

            vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939" })
            vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" })
            vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379" })

            vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
            vim.fn.sign_define("DapBreakpointCondition", {
                text = " ",
                texthl = "DapBreakpoint",
                numhl = "DapBreakpoint"
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = " ",
                texthl = "DapBreakpoint",
                numhl =
                "DapBreakpoint"
            })
            vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint", numhl = "DapLogPoint" })
            vim.fn.sign_define("DapStopped", { text = " 󰧂", texthl = "DapStopped", numhl = "DapStopped" })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dap-float",
                callback = function(arg)
                    local options = { buffer = arg.buf, remap = false }
                    vim.keymap.set("n", "q", ":close!<CR>", options)
                end
            })
        end
    },

    { "theHamsta/nvim-dap-virtual-text", config = true },

}

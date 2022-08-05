local Path = require("plenary.path")
local dap, dapui = require("dap"), require("dapui")

local DAP_BASEPATH = Path:new(vim.fn.stdpath("data"), "/mason/bin")

dap.adapters.codelldb = {
    type = "server",
    port = 8990,

    executable = {
        command = tostring(Path:new(DAP_BASEPATH, "codelldb")),
        args = {"--port", "8990"}
    }
}

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg=0, fg="#993939" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg=0, fg="#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg=0, fg="#98c379" })

vim.fn.sign_define("DapBreakpoint", { text="", texthl="DapBreakpoint", numhl="DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text="ﳁ", texthl="DapBreakpoint", numhl="DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text="", texthl="DapBreakpoint", numhl= "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text="", texthl="DapLogPoint", numhl= "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text="", texthl="DapStopped", numhl= "DapStopped" })

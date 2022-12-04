local wk = require("which-key")

wk.register({
    name = "+dap",
    ["<F9>"] = {"<CMD>DapToggleBreakpoint<CR>", "DAP Toggle Breakpoint"},
    ["<F10>"] = {"<CMD>DapStepOver<CR>", "DAP Step Over"},
    ["<F11>"] = {"<CMD>DapStepInto<CR>", "DAP Step Into"},
})

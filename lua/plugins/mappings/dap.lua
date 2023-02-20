vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)

vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end)
vim.keymap.set("n", "<leader>de", function() require("dap").set_exception_breakpoints({"all"}) end)
vim.keymap.set("n", "<leader>di", function() require("dap.ui.widgets").hover() end)
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open({}, "vsplit") end)
vim.keymap.set("n", "<leader>dp", function() require("dap.ui.widgets").preview() end)

vim.keymap.set("n", "<leader>dq", function()
    require("dap").terminate(nil, nil, function()
        vim.api.nvim_command(":DapVirtualTextForceRefresh")
    end)
end)

vim.keymap.set("n", "<leader>ds", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end)

vim.keymap.set("v", "<leader>di", function() require("dap.ui.widgets").hover() end)
vim.keymap.set("v", "<leader>dp", function() require("dap.ui.widgets").preview() end)

vim.keymap.set("n", "<leader>db", function() require("telescope").extensions.dap.list_breakpoints() end)
vim.keymap.set("n", "<leader>dv", function() require("telescope").extensions.dap.variables() end)
vim.keymap.set("n", "<leader>df", function() require("telescope").extensions.dap.frames() end)


vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-float",
    callback = function(arg)
        local options = {buffer = arg.buf, remap = false}
        vim.keymap.set("n", "q", ":close!<CR>", options)
    end
})

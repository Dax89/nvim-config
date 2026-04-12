vim.keymap.set("n", "<leader>qr", "<CMD>colder<CR>"
, { desc = "QuickFix - restore" })

vim.keymap.set("n", "<leader>qf", function()
    vim.cmd.packadd("cfilter")
    vim.fn.feedkeys(":Cfilter ")
end, { desc = "QuickFix - match IF" })

vim.keymap.set("n", "<leader>qF", function()
    vim.cmd.packadd("cfilter")
    vim.fn.feedkeys(":Cfilter! ")
end, { desc = "QuickFix - match IF NOT" })

vim.keymap.set("n", "<leader>qe", function()
    vim.cmd.packadd("cfilter")
    vim.cmd.Cfilter("/E/")
end, { desc = "QuickFix - show errors" })

vim.keymap.set("n", "<leader>qw", function()
    vim.cmd.packadd("cfilter")
    vim.cmd.Cfilter("/W/")
end, { desc = "QuickFix - show warnings" })

vim.keymap.set("n", "<leader>qi", function()
    vim.cmd.packadd("cfilter")
    vim.cmd.Cfilter("/I/")
end, { desc = "QuickFix - show info" })

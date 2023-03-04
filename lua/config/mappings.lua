vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>A", "gg0VG")

vim.keymap.set("n", "<A-p>", function()
    require("config.common").show_select("Quick Actions", {
        {" Settings", ":e $MYVIMRC | :cd %:p:h"},
        {"󰒲 Lazy", ":Lazy"},
        {"↺ Restart LSP", ":LspRestart"},
        {"! Mason", ":Mason"},
        {"⚙ Commands", function() require("telescope.builtin").commands() end},
        {" New Workspace", ":Automaton create"},
        {" Workspaces", ":Automaton recents"},
    })
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function(arg)
        local options = {buffer = arg.buf, remap = false}
        vim.keymap.set("n", "<leader><leader>", ":so<CR>", options)
    end
})

-- Disable Help Shortcut
vim.keymap.set({"i", "n"}, "<F1>", "<Nop>")

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

-- Check keyboard layout
if vim.fn.system("setxkbmap -query | grep layout | awk '{print $NF}'") == "it" then
    vim.keymap.set("n", "<leader>+", "<CMD>enew<CR>")
else
    vim.keymap.set("n", "<leader>=", "<CMD>enew<CR>")
end

vim.keymap.set("n", "<leader>-", function() require("bufdelete").bufdelete(0, true) end)

vim.keymap.set("n", "<leader>s", function()
    local p = require("plenary.path"):new(vim.api.nvim_buf_get_name(0))

    if p:is_file() then
        p = p:parent()
    end

    if p:is_dir() then
        require("config.common").os_open(tostring(p))
    end
end)

vim.keymap.set("n", "<A-p>", function()
    require("config.common").show_select("Quick Actions", {
        {" Workspaces", ":Automaton recents"},
        {"󱕣 New Workspace", ":Automaton create"},
        {" Settings", ":e $MYVIMRC | :cd %:p:h"},
        {"󰒲 Lazy", ":Lazy"},
        {"↺ Restart LSP", ":LspRestart"},
        {"! Mason", ":Mason"},
        {"⚙ Commands", function() require("telescope.builtin").commands() end}
    })
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Window mappings
for i = 1, 9 do
    local lhs = "<leader>" .. i
    local rhs = i .. "<C-w>w"
    vim.keymap.set("n", lhs, rhs, { desc = "Move to Window " .. i})
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function(arg)
        local options = {buffer = arg.buf, remap = false}
        vim.keymap.set("n", "<leader><leader>", ":so<CR>", options)
    end
})

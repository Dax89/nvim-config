local common = require("config.common")

-- Disable Help Shortcut
vim.keymap.set({ "i", "n" }, "<F1>", "<Nop>")

vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>A", "gg0VG", { desc = "Select All" })

-- Check keyboard layout
if common.is_layout_en() then
    vim.keymap.set("n", "<leader>=", "<CMD>enew<CR>", { desc = "New Tab" })
else
    vim.keymap.set("n", "<leader>+", "<CMD>enew<CR>", { desc = "New Tab" })
end

vim.keymap.set("n", "<leader>-", function() require("bufdelete").bufdelete(0, true) end, { desc = "Close Tab" })

vim.keymap.set("n", "<leader>s", function()
    local p = require("plenary.path"):new(vim.api.nvim_buf_get_name(0))

    if p:is_file() then
        p = p:parent()
    end

    if p:is_dir() then
        require("config.common").os_open(tostring(p))
    end
end, { desc = "System Open" })

vim.keymap.set("n", "<A-p>", function()
    require("config.common").show_select("Quick Actions", {
        { " Workspaces", ":Automaton recents" },
        { "󱕣 New Workspace", ":Automaton create" },
        { " JSON Editor", function() require("config.common").json_editor(true) end },
        { " Settings", ":e $MYVIMRC | :cd %:p:h" },
        { "󰒲 Lazy", ":Lazy" },
        { "↺ Restart LSP", ":LspRestart" },
        { "! Mason", ":Mason" },
        { "⚙ Commands", function() require("telescope.builtin").commands() end }
    })
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Row Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up Down" })
vim.keymap.set("n", "<leader><leader>", ":so<CR>", { desc = "Source Ex Commands" })

-- Window mappings
for i = 1, 9 do
    local lhs = "<C-" .. i .. ">"
    local rhs = i .. "<C-w>w"
    vim.keymap.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

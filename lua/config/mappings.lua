local common = require("config.common")

-- HACK: Remap Foldings before custom mappings fixes UI refresh
-- https://github.com/dante0624/nvim_config/blob/main/lua/core/myModules/folding.lua
local function fold_keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, function()
        local method = vim.o.foldmethod
        vim.cmd("setlocal foldmethod=" .. method)
        vim.cmd("normal! " .. rhs)
    end, options)
end

fold_keymap("", "ze", "]z")
fold_keymap("", "zb", "[z")

fold_keymap("", "za", "za")
fold_keymap("", "zo", "zo")
fold_keymap("", "zO", "zO")
fold_keymap("", "zc", "zc")
fold_keymap("", "zC", "zC")
fold_keymap("", "zR", "zR")
fold_keymap("", "zM", "zM")

-- Disable Help Shortcut
vim.keymap.set({ "i", "n" }, "<F1>", "<Nop>")

vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>A", "gg0VG", { desc = "Select All" })

-- Check keyboard layout
if common.is_layout_en() then
    vim.keymap.set("n", "<leader>=", "<CMD>enew<CR>", { desc = "New Buffer" })
else
    vim.keymap.set("n", "<leader>+", "<CMD>enew<CR>", { desc = "New Buffer" })
end

vim.keymap.set("n", "<leader>q", "<CMD>%bd|e#|bd#<CR>", { desc = "Close Other Buffers" })
vim.keymap.set("n", "<leader>-", function() require("bufdelete").bufdelete(0, true) end, { desc = "Close Buffer" })

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
        { " Restart LSP", ":LspRestart" },
        { " Mason", ":Mason" },
        { "⚙ Commands", function() require("telescope.builtin").commands() end }
    })
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Row Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up Down" })

-- Window Manager
for i = 1, 9 do
    local lhs = "<C-" .. i .. ">"
    local rhs = i .. "<C-w>w"
    vim.keymap.set("n", lhs, rhs, { desc = "Window - Move #" .. i })
end

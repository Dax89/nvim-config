local common = require("core.common")

-- General
common.map("<Up>", "<Nop>", "n")
common.map("<Down>", "<Nop>", "n")
common.map("<Left>", "<Nop>", "n")
common.map("<Right>", "<Nop>", "n")
common.map("<Space>", "<Nop>", "n")
common.map("<C-n>", "<Nop>", "n")
common.map("<C-n>", "<Nop>", "i")
common.map("<Leader>a", "gg0VG", "n")
common.map("<C-Tab>", ":bn<CR>", "n")
common.map("<C-S-Tab>", ":bp<CR>", "n")

-- Plugins
common.map("<F6>", ":FloatermToggle<CR>", "n")
common.map("<F6>", "<C-\\><C-n>:FloatermToggle<CR>", "t")

-- Navigation
common.map("<F7>", function()
    if #require("dap").status() == 0 then -- Check if DAP is not active
        vim.api.nvim_command(":NvimTreeToggle<CR>", "n")
    end
end, "n")

common.map("<C-h>", ":Telescope oldfiles<CR>", "n")
common.map("<C-k>", ":Telescope find_files<CR>", "n")
common.map("<C-S-k>", ":Telescope live_grep<CR>", "n")

-- LSP
common.map("<F2>", ":lua require('renamer').rename()<CR>", "i")
common.map("<F2>", ":lua require('renamer').rename()<CR>", "n")
common.map("<F2>", ":lua require('renamer').rename()<CR>", "v")
common.map("<S-Enter>", ":Lspsaga lsp_finder<CR>", "n")
common.map("<A-Enter>", ":Lspsaga code_action<CR>", "n")
common.map("<C-F7>", ":SymbolsOutline<CR>", "n")

-- DAP
common.map("<F9>", ":DapToggleBreakpoint<CR>", "n")
common.map("<F10>", ":DapStepOver<CR>", "n")
common.map("<F11>", ":DapStepInto<CR>", "n")

local common = require("config.common")

common.set_options("g", {
    completion_matching_strategy_list = {"exact", "fuzzy"},
    completion_matching_smart_case = true
})

-- Diagnostic (https://github.com/VonHeikemen/lsp-zero.nvim/blob/main/lua/lsp-zero/presets.lua)
local function set_sign(name, icon)
    vim.fn.sign_define(name, {texthl = name, text = icon, numhl = ""})
end

set_sign("DiagnosticSignError", " ✘")
set_sign("DiagnosticSignWarn",  " ")
set_sign("DiagnosticSignHint",  " ")
set_sign("DiagnosticSignInfo",  " ")

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

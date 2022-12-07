local wk = require("which-key")

local function show_general_settings()
    require("config.common").show_select("Quick Actions", {
        {" Settings", ":e $MYVIMRC | :cd %:p:h"},
        {" Sync Plugins", ":PackerSync"},
        {"↺ Restart LSP", ":LspRestart"},
        {"! Mason", ":Mason"},
        {"⚙ Commands", function() require("telescope.builtin").commands() end}
    })
end

local function query_chatgpt()
    vim.ui.input({
        prompt = "ChatGPT",
    }, function(q)
        if q and #q > 0 then
            vim.api.nvim_command("ChatGPT " .. q)
        end
    end)
end

-- Disabled keys
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("i", "<C-n>", "<Nop>")

wk.register({
    ["<leader>"] = {
        ["a"] = { "gg0VG", "Select All"},
        ["q"] = { query_chatgpt, "Query ChatGPT"},

        ["g"] = {
            function()
                local cwd = vim.fn.expand('%:p:h')
                vim.api.nvim_command(":Neogit kind=split")
                vim.cmd(":lcd" .. cwd)
            end,
            "Show Git"
        }
    },

    ["|"] = {function() require("spectre").open() end, "Find & Replace in files"},
    ["<A-p>"] = {show_general_settings, "Show General Settings"}
})

wk.register({
    name = "+lsp",
    ["K"] = {vim.lsp.buf.hover, "LSP Show Symbol Details"},
    ["<F2>"] = {":IncRename ", "LSP Incremental Rename"},
    ["<F4>"] = {"<CMD>ClangdSwitchSourceHeader<CR>", "Switch C++ Header/Source"},
    ["<C-F6>"] = {"<CMD>TroubleToggle<CR>", "Toggle LSP Troubles"},
    ["<A-Enter>"] = {vim.lsp.buf.code_action, "LSP Code Actions"},
})

wk.register({
    name = "+lsp",
    ["<A-Enter>"] = {vim.lsp.buf.range_code_action, "LSP Code Actions"},
    ["<C-F6>"] = {"<CMD>TroubleToggle<CR>", "Toggle LSP Troubles"},
}, {mode = "v"})

wk.register({
    name = "+lsp",
    ["<F2>"] = {":IncRename ", "LSP Incremental Rename"},
}, {mode = "i"})

wk.register({
    name = "+search",
    ["/"] = {"<CMD>SearchBoxMatchAll clear_matches=true<CR>", "Search"},
    ["&"] = {"<CMD>SearchBoxReplace<CR>", "Replace"},
}, { mode = "n"})

wk.register({
    name = "+search",
    ["/"] = {"<CMD>SearchBoxMatchAll clear_matches=true visual_mode=true<CR>", "Search"},
    ["&"] = {"<CMD>SearchBoxReplace<CR>", "Replace"},
}, { mode = "v"})

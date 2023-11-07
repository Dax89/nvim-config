local PATH_SEP = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
local devmode = vim.fn.filereadable(vim.fn.stdpath("config") .. PATH_SEP .. ".dev") == 1

local function local_plugin(name, options)
    local plugin = {}

    if devmode then
        plugin.dir = "~/Dev/Progetti/NVim/" .. name
    else
        table.insert(plugin, "Dax89/" .. name)
    end

    return vim.tbl_deep_extend("force", plugin, options or {})
end

return {
    local_plugin("automaton.nvim", {
        event = "VimEnter",
        keys = {
            {
                "<F5>",
                "<CMD>Automaton launch default<CR>",
                mode = { "n", "v" },
                desc = "Automaton - Launch Default"
            },
            {
                "<F6>",
                "<CMD>Automaton debug default<CR>",
                mode = { "n", "v" },
                desc = "Automaton - Debug Default"
            },
            {
                "<F8>",
                "<CMD>Automaton tasks default<CR>",
                mode = { "n", "v" },
                desc = "Automaton - Tasks Default"
            },

            {
                "<leader>aC",
                "<CMD>Automaton create<CR>",
                desc = "Automaton - Create Workspace"
            },
            {
                "<leader>aI",
                "<CMD>Automaton init<CR>",
                desc = "Automaton - Init Workspace"
            },
            {
                "<leader>aL",
                "<CMD>Automaton load<CR>",
                desc = "Automaton - Load Workspace"
            },

            {
                "<leader>ac",
                "<CMD>Automaton config<CR>",
                desc = "Automaton - Workspace Config"
            },
            {
                "<leader>ar",
                "<CMD>Automaton recents<CR>",
                desc = "Automaton - Recents"
            },
            {
                "<leader>aw",
                "<CMD>Automaton workspaces<CR>",
                desc = "Automaton - Workspaces"
            },
            {
                "<leader>aj",
                "<CMD>Automaton jobs<CR>",
                desc = "Automaton - Jobs"
            },
            {
                "<leader>al",
                "<CMD>Automaton launch<CR>",
                desc = "Automaton - Show Launch"
            },
            {
                "<leader>ad",
                "<CMD>Automaton debug<CR>",
                desc = "Automaton - Show Debug"
            },
            {
                "<leader>at",
                "<CMD>Automaton tasks<CR>",
                desc = "Automaton - Show Tasks"
            },
            {
                "<leader>aol",
                "<CMD>Automaton open launch<CR>",
                desc = "Automaton - Open Launch"
            },
            {
                "<leader>aov",
                "<CMD>Automaton open variables<CR>",
                desc = "Automaton - Open Variables"
            },
            {
                "<leader>aot",
                "<CMD>Automaton open tasks<CR>",
                desc = "Automaton - Open Tasks"
            },
            {
                "<leader>aoc",
                "<CMD>Automaton open config<CR>",
                desc = "Automaton - Open Config"
            },
            {
                "<leader>al",
                "<CMD><C-U>Automaton launch<CR>",
                mode = "v",
                desc = "Automaton - Show Launch"
            },
            {
                "<leader>ad",
                "<CMD><C-U>Automaton debug<CR>",
                mode = "v",
                desc = "Automaton - Show Debug"
            },
            {
                "<leader>at",
                "<CMD><C-U>Automaton tasks<CR>",
                mode = "v",
                desc = "Automaton - Show Tasks"
            },
        },

        opts = {
            debug = true,
            ignore_ft = require("config.common").buftype_blacklist,

            integrations = {
                luasnip = true,
                cmp = true
            },
        }
    })
}

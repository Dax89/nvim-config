local PATH_SEP = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
local devmode = vim.fn.filereadable(vim.fn.stdpath("config") .. PATH_SEP .. ".dev") == 1

local function local_plugin(name, options)
    local plugin = { }

    if devmode then
        plugin.dir = "~/Dev/Progetti/NVim/" .. name
    else
        table.insert(plugin, "Dax89/" .. name)
    end

    return vim.tbl_deep_extend("force", plugin, options or { })
end

return {
    local_plugin("automaton.nvim", {
        event = "VimEnter",
        keys = {
            {"<F5>", "<CMD>Automaton launch default<CR>"},
            {"<F6>", "<CMD>Automaton debug default<CR>"},
            {"<F8>", "<CMD>Automaton tasks default<CR>"},
            {"<F5>", "<CMD><C-U>Automaton launch default<CR>", mode = "v"},
            {"<F6>", "<CMD><C-U>Automaton debug default<CR>", mode = "v"},
            {"<F8>", "<CMD><C-U>Automaton tasks default<CR>", mode = "v"},

            {"<leader>aC", "<CMD>Automaton create<CR>"},
            {"<leader>aI", "<CMD>Automaton init<CR>"},
            {"<leader>aL", "<CMD>Automaton load<CR>"},

            {"<leader>ac", "<CMD>Automaton config<CR>"},
            {"<leader>ar", "<CMD>Automaton recents<CR>"},
            {"<leader>aw", "<CMD>Automaton workspaces<CR>"},
            {"<leader>aj", "<CMD>Automaton jobs<CR>"},
            {"<leader>al", "<CMD>Automaton launch<CR>"},
            {"<leader>ad", "<CMD>Automaton debug<CR>"},
            {"<leader>at", "<CMD>Automaton tasks<CR>"},

            {"<leader>aol", "<CMD>Automaton open launch<CR>"},
            {"<leader>aov", "<CMD>Automaton open variables<CR>"},
            {"<leader>aot", "<CMD>Automaton open tasks<CR>"},
            {"<leader>aoc", "<CMD>Automaton open config<CR>"},

            {"<leader>al", "<CMD><C-U>Automaton launch<CR>", mode = "v"},
            {"<leader>ad", "<CMD><C-U>Automaton debug<CR>", mode = "v"},
            {"<leader>at", "<CMD><C-U>Automaton tasks<CR>", mode = "v"},
        },

        opts = {
            debug = true,
            ignore_ft = require("config.common").buftype_blacklist,

            events = {
                workspacechanged = function(ws)
                    if ws then
                        require("neo-tree").show()
                    end
                end
            }
        }
    })
}

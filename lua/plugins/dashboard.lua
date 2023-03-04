local function create_buttons()
    local BUTTONS_TEMPLATE = {
        {"Files & Projects"},
        {"e", "", "New File",      ":ene <BAR> startinsert"},
        {"r", "", "Recents Files", ":Telescope oldfiles"},
        {"n", "", "New Workspace", ":Automaton create"},
        {"p", "", "Workspaces",    ":Automaton recents"},
        {"Settings & Plugins"},
        {"x", "", "Settings",      ":e $MYVIMRC | :cd %:p:h"},
        {"L", "󰒲", "Lazy",          ":Lazy"},
        {"N", "ﴽ", "News",          ":help news"},
    }

    local function fillw(s, w, before)
        if before == true then
            return string.rep(" ", w - #s) .. s
        end

        return s .. string.rep(" ", w - #s)
    end

    local buttons = { }

    for _, bt in ipairs(BUTTONS_TEMPLATE) do
        local b = nil

        if #bt == 1 then
            b = {
                desc = fillw(bt[1], 33, true),
                desc_hl = "Operator"
            }
        else
            b = {
                key = bt[1],
                icon = string.format("%s  ", bt[2]),
                desc = fillw(bt[3], 40),
                action = bt[4],

                key_hl = "Number",
                icon_hl = "Keyword"
            }
        end

        table.insert(buttons, b)
    end

    return buttons
end

return {
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",

        opts = {
            theme = "doom",

            config = {
                header = {
                    "",
                    "",
                    "",
                    " ███    ██ ███████  ██████  ██    ██ ██ ███    ███ ",
                    " ████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ",
                    " ██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ",
                    " ██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ",
                    " ██   ████ ███████  ██████    ████   ██ ██      ██ ",
                    "",
                    "",
                    "",
                },

                center = create_buttons(),

                footer = function()
                    local v, datetime = vim.version(), os.date("%d-%m-%Y")
                    local ok, lazy = pcall(require, "lazy")
                    local nplugins = ok and lazy.stats().count or 0
                    local version = string.format("NeoVIM %d.%d.%d (API Level %d, %d Plugins)", v.major, v.minor, v.patch, v.api_level, nplugins)
                    return {version .. "  " .. datetime}
                end
            }
        },

        config = function(_, opts)
            local palette = require("kanagawa.colors").setup()

            require("config.common").highlight({
                {"DashboardHeader",   {fg = palette.sakuraPink}},
            })

            require("dashboard").setup(opts)
        end
    }
}

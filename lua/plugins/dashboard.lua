local function create_buttons()
    local BUTTONS_TEMPLATE = {
        { string.rep(" ", 4) .. "Files & Projects" },
        { "e", "", "New File", ":enew" },
        { "r", "", "Recents Files", ":Telescope oldfiles" },
        { "n", "󱕣", "New Workspace", ":Automaton create" },
        { "p", "", "Workspaces", ":Automaton recents" },
        { string.rep(" ", 4) .. "Utilities" },
        { "j", "", "JSON Editor", function() require("config.common").json_editor() end },
        { "b", "", "Second Brain", ":e $HOME/Dev/Cloud/BrainDump/index.wiki | :cd %:p:h" },
        { string.rep(" ", 4) .. "Settings & Plugins" },
        { "x", "", "Settings", ":e $MYVIMRC | :cd %:p:h" },
        { "l", "󰒲", "Lazy", ":Lazy" },
        { "m", "", "Mason", ":Mason" },
    }

    local function fillw(s)
        return s .. string.rep(" ", 50 - #s)
    end

    local buttons = {}

    for _, bt in ipairs(BUTTONS_TEMPLATE) do
        local b = nil

        if #bt == 1 then
            b = {
                desc = bt[1],
                desc_hl = "Comment"
            }
        else
            b = {
                key = bt[1],
                icon = string.format("%s  ", bt[2]),
                desc = fillw(bt[3]),
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
        "nvimdev/dashboard-nvim",
        event = "VimEnter",

        opts = {
            theme = "doom",

            hide = {
                statusline = true,
                tabline = true,
                winbar = true,
            },

            config = {
                header = {
                    [[                                                                       ]],
                    [[                                                                       ]],
                    [[                                                                     ]],
                    [[       ████ ██████           █████      ██                     ]],
                    [[      ███████████             █████                             ]],
                    [[      █████████ ███████████████████ ███   ███████████   ]],
                    [[     █████████  ███    █████████████ █████ ██████████████   ]],
                    [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                    [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                    [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                    [[                                                                       ]],
                    [[                                                                       ]],
                    [[                                                                       ]],
                },

                center = create_buttons(),

                footer = function()
                    local v, datetime = vim.version(), os.date("%d-%m-%Y")
                    local ok, lazy = pcall(require, "lazy")
                    local nplugins = ok and lazy.stats().count or 0
                    local version = string.format("NeoVIM %d.%d.%d (API Level %d, %d Plugins)", v.major, v.minor, v
                        .patch, v.api_level, nplugins)
                    return { version .. " 󰇝 " .. datetime }
                end
            }
        },

        config = true
    }
}

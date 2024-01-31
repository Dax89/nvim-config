local function create_buttons()
    local BUTTONS_TEMPLATE = {
        { "Files & Projects" },
        { "e", "", "New File", ":enew" },
        { "r", "", "Recents Files", ":Telescope oldfiles" },
        { "n", "󱕣", "New Workspace", ":Automaton create" },
        { "p", "", "Workspaces", ":Automaton recents" },
        { "Settings & Plugins" },
        { "x", "", "Settings", ":e $MYVIMRC | :cd %:p:h" },
        { "B", "", "Second Brain", ":e $HOME/Dev/Cloud/BrainDump/index.wiki | :cd %:p:h" },
        { "L", "󰒲", "Lazy", ":Lazy" },
        { "N", "", "News", ":help news" },
    }

    local function fillw(s, w, before)
        if before == true then
            return string.rep(" ", w - #s) .. s
        end

        return s .. string.rep(" ", w - #s)
    end

    local buttons = {}

    for _, bt in ipairs(BUTTONS_TEMPLATE) do
        local b = nil

        if #bt == 1 then
            b = {
                desc = fillw(bt[1], 33, true),
                desc_hl = "Normal"
            }
        else
            b = {
                key = bt[1],
                icon = string.format("%s  ", bt[2]),
                desc = fillw(bt[3], 40),
                action = bt[4],

                key_hl = "Special",
                icon_hl = "Statement"
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

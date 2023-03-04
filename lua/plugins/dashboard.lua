local function create_buttons()
    local BUTTONS_TEMPLATE = {
        {"Files & Projects"},
        {"e", "", "New File",      ":ene <BAR> startinsert <CR>"},
        {"r", "", "Recents Files", ":Telescope oldfiles<CR>"},
        {"n", "", "New Workspace", ":Automaton create<CR>"},
        {"p", "", "Workspaces",    ":Automaton recents<CR>"},
        {"Settings & Plugins"},
        {"x", "", "Settings",      ":e $MYVIMRC | :cd %:p:h<CR>"},
        {"L", "󰒲", "Lazy",          ":Lazy<CR>"},
        {"N", "ﴽ", "News",          ":help news<CR>"},
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        callback = function(arg)
            for _, bt in ipairs(BUTTONS_TEMPLATE) do
                if #bt > 1 then
                    vim.api.nvim_buf_set_keymap(arg.buf, "n", bt[1], bt[4], { noremap = true, silent = true })
                end
            end
        end
    })

    local function fillw(s)
        local WIDTH = 40
        return s .. string.rep(" ", WIDTH - #s)
    end

    local buttons = { }

    for _, bt in ipairs(BUTTONS_TEMPLATE) do
        local b = nil

        if #bt == 1 then
            b = {desc = bt[1]}
        else
            b = {shortcut = " " .. bt[1], icon = string.format("%s  ", bt[2]), desc = fillw(bt[3]), action = bt[4]}
        end

        table.insert(buttons, b)
    end

    return buttons
end

return {
    {
        "glepnir/dashboard-nvim",
        commit = "f7d623457d6621b25a1292b24e366fae40cb79ab",

        config = function()
            local dashboard = require("dashboard")
            local common = require("config.common")
            local palette = require("kanagawa.colors").setup()

            common.highlight({
                {"DashboardHeader",   {fg = palette.sakuraPink}},
                {"DashboardShortCut", {fg = palette.peachRed}},
                {"DashboardCenter",   {fg = palette.oldWhite}},
                {"DashboardFooter",   {fg = palette.springGreen}},
            })

            dashboard.hide_tabline = false
            dashboard.hide_statusline = false
            dashboard.custom_center = create_buttons()

            dashboard.custom_header = {
                " ███    ██ ███████  ██████  ██    ██ ██ ███    ███ ",
                " ████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ",
                " ██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ",
                " ██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ",
                " ██   ████ ███████  ██████    ████   ██ ██      ██ ",
            }

            dashboard.custom_footer = function()
                local v, datetime = vim.version(), os.date("%d-%m-%Y")
                local ok, lazy = pcall(require, "lazy")
                local nplugins = ok and lazy.stats().count or 0
                local version = string.format("NeoVIM %d.%d.%d (API Level %d, %d Plugins)", v.major, v.minor, v.patch, v.api_level, nplugins)
                return {version .. "  " .. datetime}
            end

            common.exec_commands("autocmd FileType dashboard set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2")
        end
    }
}

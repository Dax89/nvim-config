local palette = require("catppuccin.palettes").get_palette()
local dashboard = require("dashboard")
local common = require("config.common")

common.highlight({
    {"DashboardHeader",   {fg=palette.blue}},
    {"DashboardShortCut", {fg=palette.red}},
    {"DashboardCenter",   {fg=palette.green}},
    {"DashboardFooter",   {fg=palette.yellow}},
})

local function create_buttons()
    local BUTTONS_TEMPLATE = {
        {"Files & Projects"},
        {"e", "", "New File",      ":ene <BAR> startinsert <CR>"},
        {"n", "", "New Project",   require("config.common").wrap_fn("config.project", "select_language")},
        {"r", "", "Recents Files", ":Telescope oldfiles<CR>"},
        {"p", "★", "Projects",      ":Telescope projects<CR>"},
        {"Settings & Plugins"},
        {"u", "", "Sync Plugins",  ":PackerSync<CR>"},
        {"x", "", "Settings",      ":e $MYVIMRC | :cd %:p:h<CR>"},
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
            b = {shortcut = " " .. bt[1], icon = string.format("%s ➤ ", bt[2]), desc = fillw(bt[3]), action = bt[4]}
        end

        table.insert(buttons, b)
    end

    return buttons
end


dashboard.custom_center = create_buttons()

dashboard.custom_header = {
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
}

dashboard.custom_footer = function()
    local v, datetime = vim.version(), os.date("%d-%m-%Y")
    local nplugins = 0

    if _G["packer_plugins"] then
        nplugins = #vim.tbl_keys(_G["packer_plugins"])
    end

    local version = string.format("NeoVIM %d.%d.%d (API Level %d, %d Plugins)", v.major, v.minor, v.patch, v.api_level, nplugins)
    return {version .. "  " .. datetime}
end

common.exec_commands("autocmd FileType dashboard set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2")
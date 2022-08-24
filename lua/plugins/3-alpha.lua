local common = require("config.common")

local LOGO = {
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
}

local BUTTONS = {
    {"Files & Projects"},
    {"e", " ➤ New File",      ":ene <BAR> startinsert <CR>"},
    {"n", " ➤ New Project",   common.wrap_fn("config.project", "select_language")},
    {"r", " ➤ Recents Files", ":Telescope oldfiles<CR>"},
    {"p", "★ ➤ Projects",      ":Telescope projects<CR>"},
    {"Settings & Plugins"},
    {"u", " ➤ Sync Plugins",  ":PackerSync<CR>"},
    {"x", " ➤ Settings",      ":e $MYVIMRC | :cd %:p:h<CR>"},
}

local alpha, dashboard = require("alpha"), require("alpha.themes.dashboard")

dashboard.section.header.val = LOGO
dashboard.section.header.opts.hl = "Identifier"
dashboard.section.footer.opts.hl = "Constant"

dashboard.section.footer.val = function()
    local v, datetime = vim.version(), os.date("%d-%m-%Y")
    local nplugins = 0

    if _G["packer_plugins"] then
        nplugins = #vim.tbl_keys(_G["packer_plugins"])
    end

    local version = string.format("NeoVIM %d.%d.%d (API Level %d, %d Plugins)", v.major, v.minor, v.patch, v.api_level, nplugins)
    return version .. "  " .. datetime
end

dashboard.section.buttons.val = function()
    local res = { }

    for _, buttons in ipairs(BUTTONS) do
        local b = nil

        if #buttons == 1 then
            b = {type = "text", val = buttons[1], opts = {hl = "SpecialComment", position = "center"}}
        else
            b = dashboard.button(unpack(buttons))
            b.opts.hl = "Function"
            b.opts.hl_shortcut = "Type"
        end

        table.insert(res, b)
    end

    return res
end

alpha.setup(dashboard.opts)
common.exec_commands("autocmd FileType alpha set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2")


local function filter_filetypes(ft)
    return not vim.tbl_contains({"toggleterm"}, ft)
end

local function get_current_lsp()
    local msg = ""
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()

    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.tbl_contains(filetypes, ft) then
            return client.name
        end
    end

    return msg
end

local function get_automaton_status()
    local dapok, dap = pcall(require, "dap")

    if dapok then
        local session = dap.session()

        if session then
            return " " .. vim.F.if_nil(session.config.name, "DEBUG")
        end
    end

    local automatonok, automaton = pcall(require, "automaton")
    local s = ""

    if automatonok then
        local ws = automaton.get_active_workspace()

        if ws then
            s = " " .. ws:get_name()
            local task, launch = ws:get_default_task(), ws:get_default_launch()

            if task then
                s = s .. " │  " .. task.name
            end

            if launch then
                s = s .. " │  " .. launch.name
            end
        end
    end

    return s
end

local Mode = {
    "mode",
    color = { gui = "bold" }
}

local OilCurrentDir = {
    function()
        local ok, oil = pcall(require, "oil")

        if ok then
            return oil.get_current_dir()
        end

        return ""
    end,

    cond = function()
        return vim.bo.filetype == "oil"
    end,

    color = "CursorLine",
    separator = {left = "", right = ""}
}

local Automaton = {
    get_automaton_status,
    icons_enabled = false,
    color = "CursorLine",
    separator = {left = "", right = ""},

    cond = function()
        return vim.bo.filetype ~= "oil"
    end
}

local Navic = {
    function()
        local TYPES = {
            Function = true, Method = true, Constructor = true, Enum = true, Struct = true,
            Class = true, Interface = true, Object = true,
            Namespace = true
        }

        local data = require("nvim-navic").get_data()
        local v = nil

        for _, d in ipairs(data) do
            if TYPES[d.type] then
                v = d
            end
        end

        if v then
            return table.concat({v.icon, v.name}, " ")
        end

        return ""
    end,

    cond = function()
        local ok, navic = pcall(require, "nvim-navic")
        return ok and navic.is_available()
    end
}

local FileName = {
    "filename",

    cond = function()
        return vim.bo.filetype ~= "oil"
    end
}

return {
    "nvim-lualine/lualine.nvim",

    opts = {
        options = {
            theme = "kanagawa",
            globalstatus = true,
            disabled_filetypes = vim.tbl_filter(filter_filetypes, require("config.common").filetype_blacklist)
        },
        sections = {
            lualine_a = { Mode, Navic },
            lualine_b = { OilCurrentDir, Automaton },
            lualine_c = { FileName },
            lualine_x = { "diagnostics", get_current_lsp, "encoding", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },

        extensions = {
            "toggleterm"
        }
    }
}

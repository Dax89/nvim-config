local function filter_filetypes(ft)
    return not vim.tbl_contains({ "automaton-terminal", "qf", "toggleterm" }, ft)
end

local function get_current_window()
    return " " .. vim.api.nvim_win_get_number(0)
end

local function get_relative_filepath()
    local cwd = vim.fn.getcwd()
    local filepath = vim.api.nvim_buf_get_name(0)

    if vim.startswith(filepath, cwd) then
        filepath = filepath:sub(#cwd + 1, -1)

        if filepath:sub(1, 1) == require("config.common").sep then
            filepath = filepath:sub(2, -1)
        end
    end

    return filepath
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

local Window = {
    get_current_window,
    color = "CursorLine",
    separator = { right = "" },
}

local Mode = {
    "mode",
    color = { gui = "bold" }
}

local LanguageServer = {
    get_current_lsp,
    color = { gui = "bold" },
}

local FileType = {
    "filetype",
    icon_only = true,
    padding = { left = 1, right = 0 },
    separator = "",
    color = "CursorLine",
}

local FileName = {
    get_relative_filepath,
    color = "CursorLine",
    separator = { right = "" },
}

local Automaton = {
    get_automaton_status,
    icons_enabled = false,
    color = "CursorLine",
    separator = { left = "", right = "" },
}

local Navic = {
    function()
        return require("nvim-navic").get_location()
    end,

    cond = function()
        local ok, navic = pcall(require, "nvim-navic")
        return ok and navic.is_available()
    end
}

return {
    "nvim-lualine/lualine.nvim",

    opts = {
        options = {
            globalstatus = false,

            disabled_filetypes = {
                statusline = vim.tbl_filter(filter_filetypes, require("config.common").filetype_blacklist),
                winbar = require("config.common").filetype_blacklist,
            }
        },
        sections = {
            lualine_a = { Mode },
            lualine_b = { Automaton },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = { Window },
            lualine_b = {},
            lualine_c = {},
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        winbar = {
            lualine_a = { FileType, FileName, Navic },
            lualine_b = { "diagnostics" },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "encoding" },
            lualine_z = { LanguageServer }
        },
        inactive_winbar = {
            lualine_a = { FileType, FileName },
            lualine_b = { "diagnostics" },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "encoding" },
            lualine_z = { LanguageServer }
        },
        extensions = {
            "toggleterm", "quickfix"
        }
    }
}

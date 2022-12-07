local function filter_filetypes(ft)
    return not vim.tbl_contains({"neo-tree", "toggleterm"}, ft)
end

local function get_current_lsp()
    local msg = " LSP"
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

require("lualine").setup({
    options = {
        theme = "tundra",
        globalstatus = true,
        disabled_filetypes = vim.tbl_filter(filter_filetypes, require("config.common").filetype_blacklist)
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics", get_current_lsp, "encoding", "fileformat", "filetype" },
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
        "neo-tree",
        "toggleterm"
    }
})

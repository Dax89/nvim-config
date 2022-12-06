local function filter_filetypes(ft)
    return not vim.tbl_contains({"toggleterm"}, ft)
end

require("lualine").setup({
    options = {
        theme = "tundra",
        disabled_filetypes = vim.tbl_filter(filter_filetypes, require("config.common").filetype_blacklist)
    },
    integration = {nvimtree = {enabled = true, show_root = true}}
})

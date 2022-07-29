require("colorizer").setup()
require("trouble").setup()
require("dressing").setup()
require("renamer").setup()
require("aerial").setup()
require("lspkind").init()

require("telescope").load_extension("aerial")

require("lualine").setup({
    sections = {lualine_x = {"aerial"}},
    options = {theme = "catppuccin"},
    integration = {nvimtree = {enabled = true, show_root = true}}
})

require("nvim-tree").setup({
    respect_buf_cwd = true,
    update_focused_file = {enable = true, update_cwd = true},
    hijack_directories = {enable = true},
    update_cwd = true,
    filters = {dotfiles = true},
})


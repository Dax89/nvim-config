require("nvim-web-devicons").setup()
require("colorizer").setup()
require("trouble").setup()
require("dressing").setup()
require("renamer").setup()
require("which-key").setup()
require("lspkind").init()

require("lualine").setup({
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


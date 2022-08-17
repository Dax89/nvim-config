require("nvim-web-devicons").setup()
require("colorizer").setup()
require("trouble").setup()
require("dressing").setup()
require("hop").setup()
require("searchbox").setup()
require("lspkind").init()
require("project_nvim").setup()
require("telescope").load_extension("projects")

local filebrowser = require("telescope").load_extension("file_browser")
-- FIXME: nvim-project's browse project workaround
require("telescope.builtin").file_browser = filebrowser.file_browser

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua", "json", "regex", "python", "svelte", "javascript", "css", "html"},
})

require("bqf").setup({
    preview = {
        auto_preview = false
    }
})

require("lualine").setup({
    options = {
        theme = "catppuccin",
        disabled_filetypes = {"alpha", "NVimTree"}
    },
    integration = {nvimtree = {enabled = true, show_root = true}}
})

require("nvim-tree").setup({
    hijack_directories = {enable = true},

    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {"qf", "dap", "help"}
    },

    filters = {dotfiles = true},
    respect_buf_cwd = true,
})

require("nvim-autopairs").setup({
    check_ts = true,
    disable_filetype = {"fennel", "lisp"}
})

require("nvim-treesitter.configs").setup({
    autopairs = {enable = true}
})

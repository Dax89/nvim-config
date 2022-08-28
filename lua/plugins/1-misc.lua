require("nvim-web-devicons").setup()
require("symbols-outline").setup()
require("colorizer").setup()
require("trouble").setup()
require("dressing").setup()
require("hop").setup()
require("searchbox").setup()
require("lspkind").init()
require("project_nvim").setup()
require("clangd_extensions").setup()
require("Comment").setup()

require("neoclip").setup({
    default_register = "+"
})

require("telescope").load_extension("projects")
require("telescope").load_extension("neoclip")

local filebrowser = require("telescope").load_extension("file_browser")
-- FIXME: nvim-project's browse project workaround
require("telescope.builtin").file_browser = filebrowser.file_browser

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua", "json", "regex", "python", "svelte", "javascript", "css", "html"},
})

require("numb").setup({
    show_numbers = true,
    show_cursorline = true,
    number_only = false,
    centered_peeking = true,
})

require("bqf").setup({
    preview = {
        auto_preview = false
    }
})

require("toggleterm").setup({
  shade_terminals = false,
  open_mapping = "<F6>"
})

require("lualine").setup({
    options = {
        theme = "catppuccin",
        disabled_filetypes = require("config.common").filetype_blacklist
    },
    integration = {nvimtree = {enabled = true, show_root = true}}
})

require("nvim-autopairs").setup({
    check_ts = true,
    disable_filetype = {"fennel", "lisp"}
})

require("nvim-treesitter.configs").setup({
    autopairs = {enable = true}
})

require("neo-tree").setup({
    close_if_last_window = true,
    enable_diagnostics = false,
    filesystem = {
        follow_current_file = true
    },
    source_selector = {
        winbar = false,
        statusline = false
    },
    default_component_configs = {
        indent = {
            with_expanders = true,
        },
    },
})


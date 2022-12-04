require("nvim-treesitter.configs").setup({
    ensure_installed = {"c", "cpp", "lua", "json", "regex", "python", "svelte", "javascript", "css", "html"},
    autopairs = {enable = true},
    highlight = {enable = true},

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    }
})

require("treesitter-context").setup({
    patterns = {
        default = {
            "class",
            "function",
            "method",
        }
    }
})

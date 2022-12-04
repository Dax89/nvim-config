require("nvim-treesitter.configs").setup({
    ensure_installed = {"c", "cpp", "lua", "json", "regex", "python", "svelte", "javascript", "css", "html", "markdown"},
    autopairs = {enable = true},
    highlight = {enable = true},

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    }
})


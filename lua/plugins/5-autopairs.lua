require("nvim-autopairs").setup({
    check_ts = true,
    disable_filetype = {"fennel", "lisp"}
})

-- Configure with TreeSitter
require("nvim-treesitter.configs").setup({
    autopairs = {enable = true}
})

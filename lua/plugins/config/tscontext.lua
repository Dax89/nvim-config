require("treesitter-context").setup({
    patterns = {
        default = {
            "class",
            "function",
            "method",
        }
    }
})

return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = "markdown",
        build = ":call mkdp#util#install()",
    },
    {
        "davidmh/mdx.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter"
    },
}

return {
    "nvim-telescope/telescope-file-browser.nvim",

    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        keys = {
            {"<C-b>", "<CMD>Telescope buffers<CR>"},
            {"<C-h>", "<CMD>Telescope oldfiles<CR>"},
            {"<C-k>", "<CMD>Telescope find_files<CR>"},
            {"<C-p>", "<CMD>Telescope git_files<CR>"},
            {"<C-g>", "<CMD>Telescope live_grep<CR>"},
            {"<C-s>", "<CMD>Telescope lsp_document_symbols<CR>"},
            {"<C-Enter>", "<CMD>Telescope lsp_references<CR>"},
            {"<C-S-s>", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>"},

            {
                "<C-f>",
                function()
                    local Path = require("plenary.path")
                    local extensions = require("telescope").extensions

                    extensions.file_browser.file_browser({
                        path = tostring(Path:new(vim.fn.expand("%:p")):parent())
                    })
                end
            }
        },

        config = function()
            require("telescope").load_extension("file_browser")
        end
    },
}
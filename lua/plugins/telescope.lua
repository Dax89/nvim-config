local function telescope_delete_buffer(promptnr)
    local ActionState = require("telescope.actions.state")
    local currentpicker = ActionState.get_current_picker(promptnr)

    currentpicker:delete_selection(function(selection)
        local force = vim.api.nvim_buf_get_option(selection.bufnr, "buftype") == "terminal"
        local ok = pcall(require("bufdelete").bufdelete, selection.bufnr, force)
        return ok
    end)
end

return {
    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        keys = {
            {"<leader>b", "<CMD>Telescope buffers<CR>"},
            {"<C-h>", "<CMD>Telescope oldfiles<CR>"},
            {"<C-k>", "<CMD>Telescope find_files<CR>"},
            {"<C-p>", "<CMD>Telescope git_files<CR>"},
            {"<C-g>", "<CMD>Telescope live_grep<CR>"},
            {"<C-s>", "<CMD>Telescope lsp_document_symbols<CR>"},
            {"<C-Enter>", "<CMD>Telescope lsp_references<CR>"},
            {"<C-S-s>", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>"},
        },

        opts = {
            pickers = {
                buffers = {
                    initial_mode = "normal",
                    show_all_buffers = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<A-d>"] = telescope_delete_buffer,
                        },
                        n = {
                            ["d"] = telescope_delete_buffer
                        }
                    },
                },
            },
        },
    },
}

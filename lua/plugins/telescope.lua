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
            { "<leader>b", "<CMD>Telescope buffers<CR>",                       desc = "Telescope - Buffers" },
            { "<C-h>",     "<CMD>Telescope oldfiles<CR>",                      desc = "Telescope - History" },
            { "<C-k>",     "<CMD>Telescope find_files<CR>",                    desc = "Telescope = Find Files" },
            { "<C-p>",     "<CMD>silent! Telescope git_files<CR>",             desc = "Telescope = Git Files" },
            { "<C-g>",     "<CMD>Telescope live_grep<CR>",                     desc = "Telescope = Grep Files" },
            { "<C-s>",     "<CMD>Telescope lsp_document_symbols<CR>",          desc = "Telescope - LSP Outline" },
            { "<C-Enter>", "<CMD>Telescope lsp_references<CR>",                desc = "Telescope - LSP References" },
            { "<C-S-s>",   "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Telescope - LSP Symbols" },
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

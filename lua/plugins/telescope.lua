local function telescope_delete_buffer(promptnr)
    local ActionState = require("telescope.actions.state")
    local currentpicker = ActionState.get_current_picker(promptnr)

    currentpicker:delete_selection(function(selection)
        local force = vim.api.nvim_buf_get_option(selection.bufnr, "buftype") == "terminal"
        local ok = pcall(require("bufdelete").bufdelete, selection.bufnr, force)
        return ok
    end)
end

local function telescope_show_buffers()
    local builtin = require("telescope.builtin")
    builtin.buffers({
        ignore_current_buffer = true,
        sort_mru = true
    })
end

local actions = require("telescope.actions")

return {
    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        keys = function()
            local builtin = require("telescope.builtin")
            local commonoptions = {
                trim_text = true,
                path_display = { "shorten" },
            }

            local res = {
                { "<leader>b", telescope_show_buffers,                 desc = "Telescope - Buffers" },
                { "<C-h>",     "<CMD>Telescope oldfiles<CR>",          desc = "Telescope - History" },
                { "<C-k>",     "<CMD>Telescope find_files<CR>",        desc = "Telescope = Find Files" },
                { "<C-p>",     "<CMD>silent! Telescope git_files<CR>", desc = "Telescope = Git Files" },
                {
                    "<C-g>",
                    function()
                        builtin.live_grep()
                    end,
                    desc = "Telescope = Grep Files"
                },
                {
                    "<C-s>",
                    function()
                        local options = { symbol_width = 60, show_preview = false }
                        builtin.lsp_document_symbols(vim.tbl_extend("force", commonoptions, options))
                    end,
                    desc = "Telescope - LSP Outline"
                },
                {
                    "<C-Enter>",
                    function()
                        local options = { fname_width = 30 }
                        builtin.lsp_references(vim.tbl_extend("force", commonoptions, options))
                    end,
                    desc = "Telescope - LSP References"
                },
                {
                    "<C-S-d>",
                    function()
                        local options = { bufnr = nil, disable_coordinates = true }
                        builtin.diagnostics(vim.tbl_extend("force", commonoptions, options))
                    end,
                    desc = "Telescope - LSP Diagnostics"
                },
                {
                    "<C-S-s>",
                    function()
                        local options = { fname_width = 40 }
                        builtin.lsp_dynamic_workspace_symbols(vim.tbl_extend("force", commonoptions, options))
                    end,
                    desc = "Telescope - LSP Symbols"
                },
            }

            return res
        end,

        opts = {
            defaults = {
                mappings = {
                    n = {
                        ["<Tab>"] = actions.move_selection_previous,
                        ["<S-Tab>"] = actions.move_selection_next,
                        ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-h>"] = "which_key",
                    },
                    i = {
                        ["<Tab>"] = actions.move_selection_previous,
                        ["<S-Tab>"] = actions.move_selection_next,
                        ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-h>"] = "which_key",
                    }
                }
            },
            pickers = {
                buffers = {
                    show_all_buffers = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<C-d>"] = telescope_delete_buffer,
                        },
                        n = {
                            ["<C-d>"] = telescope_delete_buffer
                        }
                    },
                },
            },
        },
    },
}

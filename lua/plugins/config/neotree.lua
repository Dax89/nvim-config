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

vim.api.nvim_create_autocmd("BufReadPost", {callback = function() require("neo-tree").show() end})

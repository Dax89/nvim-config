local common = require("config.common")

common.set_options("g", {
    neo_tree_remove_legacy_commands = true
})

require("neo-tree").setup({
    close_if_last_window = true,
    enable_diagnostics = false,
    filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
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

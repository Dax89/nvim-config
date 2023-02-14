local common = require("config.common")

common.set_options("g", {
    neo_tree_remove_legacy_commands = true
})

require("neo-tree").setup({
    close_if_last_window = true,
    enable_diagnostics = false,

    filesystem = {
        hijack_netrw_behavior = "open_current",
        follow_current_file = true,
        use_libuv_file_watcher = true,

        always_show = {
            ".gitignore",
        },

        window = {
            mappings = {
                ["s"] = "os_open",
            }
        },

        commands = {
            os_open = function(state)
                common.os_open(state.tree:get_node():get_id())
            end
        }
    },

    source_selector = {
        winbar = true,
        statusline = false,
    },

    default_component_configs = {
        indent = {
            with_expanders = true,
        },
    },

    window = {
        mappings = {
            ["<space>"] = false,
        }
    },
})

vim.keymap.set("n", "<F7>", function()
    vim.api.nvim_command(":Neotree show toggle")
end)

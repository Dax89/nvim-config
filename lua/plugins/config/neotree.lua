local common = require("config.common")
local wk = require("which-key")

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
            ["<space>"] = false
        }
    }
})

wk.register({
    ["<F7>"] = {
        function()
            local ok, ide = pcall(require, "ide")

            if ok then
                local p = ide:get_active_project()

                if p and p:has_state("debug") then
                    return
                end
            end

            vim.api.nvim_command(":Neotree show toggle")
        end,
        "Toggle NeoTree"
    }
})

vim.api.nvim_create_autocmd("BufReadPost", {callback = function() require("neo-tree").show() end})

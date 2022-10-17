local common = require("config.common")

common.set_options("g", {
    catppuccin_flavour = "macchiato"
})

require("catppuccin").setup({
    styles = {
        comments = { },
        functions = { },
        keywords = { },
        variables = { },
    },
    integration = {
        neotree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        dap = {
            enabled = true,
            enable_ui = true,
        }
    }
})

common.exec_commands("colorscheme catppuccin")

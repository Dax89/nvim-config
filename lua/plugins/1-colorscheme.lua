local common = require("core.common")

require("catppuccin").setup({
    styles = {
        comments = { },
        functions = { },
        keywords = { },
        variables = { },
    }
})

common.exec_commands("colorscheme catppuccin")

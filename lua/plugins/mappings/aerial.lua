local wk = require("which-key")

wk.register({
    ["<leader>"] = {
        name = "+telescope",
        ["s"] = {"<CMD>Telescope aerial<CR>", "Show Outline"}
    },

    ["<C-F7>"] = {"<CMD>AerialToggle!<CR>", "Toggle Outline"}
}, {mode = {"n", "v"}})


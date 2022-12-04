local wk = require("which-key")

wk.register({
    name = "+telescope",
    ["c"] = {"<CMD>Telescope neoclip<CR>", "Show Clipboard"}
}, {prefix = "<leader>"})

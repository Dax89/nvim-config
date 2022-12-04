local wk = require("which-key")

wk.register({
    ["w"] = {
        require("nvim-window").pick,
        "Pick Window"
    }
}, {prefix = "<leader>"})

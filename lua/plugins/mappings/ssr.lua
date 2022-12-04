local wk = require("which-key")

wk.register({
    name = "+search",
    ["r"] = {function() require("ssr").open() end, "Structural Search & Replace"}
}, {mode = {"n", "x"}, prefix = "<leader>"})

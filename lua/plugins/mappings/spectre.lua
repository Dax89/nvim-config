local wk = require("which-key")

wk.register({
    ["|"] = {function() require("spectre").open() end, "Find & Replace in files"}
})

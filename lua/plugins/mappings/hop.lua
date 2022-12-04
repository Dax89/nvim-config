local wk = require("which-key")

wk.register({
    name = "+hop",

    ["f"] = {
        function()
            require("hop").hint_words({direction = require("hop.hint").HintDirection.AFTER_CURSOR})
        end,
        "Hop After"
    },

    ["F"] = {
        function()
            require("hop").hint_words({direction = require("hop.hint").HintDirection.BEFORE_CURSOR})
        end,
        "Hop Before"
    },
}, {prefix = "<leader>"})

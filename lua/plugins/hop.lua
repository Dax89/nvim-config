return {
    {
        "phaazon/hop.nvim",
        config = true,

        keys = {
            {
                "f",
                function()
                    require("hop").hint_words({
                        direction = require("hop.hint").HintDirection.AFTER_CURSOR
                    })
                end,
                { mode = "n"}
            },
            {
                "F", function()
                    require("hop").hint_words({
                        direction = require("hop.hint").HintDirection.BEFORE_CURSOR
                    })
                end,
                { mode = "n"}
            }
        }
    }
}

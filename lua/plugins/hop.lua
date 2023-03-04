return {
    {
        "phaazon/hop.nvim",
        config = true,

        keys = {
            {
                "<leader>f",
                function()
                    require("hop").hint_words({
                        direction = require("hop.hint").HintDirection.AFTER_CURSOR
                    })
                end
            },
            {
                "<leader>F", function()
                    require("hop").hint_words({
                        direction = require("hop.hint").HintDirection.BEFORE_CURSOR
                    })
                end
            }
        }
    }
}

vim.keymap.set("n", "<leader>f", function()
    require("hop").hint_words({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR
    })
end)

vim.keymap.set("n", "<leader>F", function()
    require("hop").hint_words({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR
    })
end)

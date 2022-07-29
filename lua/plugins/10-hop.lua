local common = require("core.common")

require("hop").setup()

common.map_keys({
    {"n", ",w", "<cmd>lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>",  {noremap = true, silent = true}},
    {"n", ",W", "<cmd>lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>", {noremap = true, silent = true}},
})

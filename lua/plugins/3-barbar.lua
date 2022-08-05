local common = require("core.common")

common.set_options("g", {
    bufferline = {
        maximum_padding = 1,
        auto_hide = false,
        icons = "both",
        exclude_ft = {"qf"} -- Hide 'quickfix' windows
    }
})

common.map_keys({
    {"n", "<Leader>1", ":BufferGoto 1<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>2", ":BufferGoto 2<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>3", ":BufferGoto 3<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>4", ":BufferGoto 4<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>5", ":BufferGoto 5<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>6", ":BufferGoto 6<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>7", ":BufferGoto 7<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>8", ":BufferGoto 8<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>9", ":BufferLast<CR>",   {noremap = true, silent = true}},
    {"n", "<Leader>-", ":BufferClose!<CR>", {noremap = true, silent = true}},
    {"n", "<Leader>+", ":enew<CR>",         {noremap = true, silent = true}},
    {"n", "<Leader>p", ":BufferPick<CR>",   {noremap = true, silent = true}},
})

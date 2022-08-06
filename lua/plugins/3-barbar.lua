local common = require("core.common")

common.set_options("g", {
    bufferline = {
        maximum_padding = 1,
        auto_hide = false,
        icons = "both",
        exclude_ft = {"qf", "dap-repl"} -- Hide 'quickfix' windows
    }
})

common.map("<Leader>1", ":BufferGoto 1<CR>", "n")
common.map("<Leader>2", ":BufferGoto 2<CR>", "n")
common.map("<Leader>3", ":BufferGoto 3<CR>", "n")
common.map("<Leader>4", ":BufferGoto 4<CR>", "n")
common.map("<Leader>5", ":BufferGoto 5<CR>", "n")
common.map("<Leader>6", ":BufferGoto 6<CR>", "n")
common.map("<Leader>7", ":BufferGoto 7<CR>", "n")
common.map("<Leader>8", ":BufferGoto 8<CR>", "n")
common.map("<Leader>9", ":BufferLast<CR>", "n")
common.map("<Leader>-", ":BufferClose!<CR>", "n")
common.map("<Leader>+", ":enew<CR>", "n")
common.map("<Leader>p", ":BufferPick<CR>", "n")

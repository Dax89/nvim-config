local wk = require("which-key")

wk.register({
    name = "+bufferline",
    ["h"] = {"<CMD>BufferLineMovePrev<CR>", "Move Buffer Left"},
    ["l"] = {"<CMD>BufferLineMoveNext<CR>","Move Buffer Right"},
    ["p"] = {"<CMD>BufferLinePick<CR>", "Pick Buffer"},
    ["1"] = {"<CMD>BufferLineGoToBuffer 1<CR>", "Select Buffer 1"},
    ["2"] = {"<CMD>BufferLineGoToBuffer 2<CR>", "Select Buffer 2"},
    ["3"] = {"<CMD>BufferLineGoToBuffer 3<CR>", "Select Buffer 3"},
    ["4"] = {"<CMD>BufferLineGoToBuffer 4<CR>", "Select Buffer 4"},
    ["5"] = {"<CMD>BufferLineGoToBuffer 5<CR>", "Select Buffer 5"},
    ["6"] = {"<CMD>BufferLineGoToBuffer 6<CR>", "Select Buffer 6"},
    ["7"] = {"<CMD>BufferLineGoToBuffer 7<CR>", "Select Buffer 7"},
    ["8"] = {"<CMD>BufferLineGoToBuffer 8<CR>", "Select Buffer 8"},
    ["9"] = {"<CMD>BufferLineGoToBuffer 9<CR>", "Select Buffer 9"},
    ["+"] = {"<CMD>enew<CR>", "New Buffer"},

    ["-"] = {
        function()
            require("bufdelete").bufdelete(0, true)
        end,
        "Delete Buffer"
    },
}, {prefix = "<leader>"})

wk.register({
    name = "+bufferline",
    ["<C-Tab>"] = {"<CMD>BufferLineCycleNext<CR>",   "Select Next Buffer"},
    ["<C-S-Tab>"] = {"<CMD>BufferLineCyclePrev<CR>", "Select Previous Buffer"},
})

local wk = require("which-key")

wk.register({
    name = "+search",
    ["/"] = {"<CMD>SearchBoxMatchAll clear_matches=true<CR>", "Search"},
    ["&"] = {"<CMD>SearchBoxReplace<CR>", "Replace"},
}, { mode = "n"})

wk.register({
    name = "+search",
    ["/"] = {"<CMD>SearchBoxMatchAll clear_matches=true visual_mode=true<CR>", "Search"},
    ["&"] = {"<CMD>SearchBoxReplace<CR>", "Replace"},
}, { mode = "v"})

local p = require("ansi16.palette")

return {
    visual = {
        a = { fg = p.color0.hex, bg = p.color5.hex, gui = "bold" },
        b = { fg = p.color15.hex, bg = p.chrome.hex },
    },
    replace = {
        a = { fg = p.color0.hex, bg = p.color1.hex, gui = "bold" },
        b = { fg = p.color15.hex, bg = p.chrome.hex },
    },
    inactive = {
        c = { fg = p.color15.hex, bg = p.color0.hex },
        b = { fg = p.color15.hex, bg = p.color0.hex },
        a = { fg = p.color15.hex, bg = p.color8.hex, gui = "bold" },
    },
    normal = {
        a = { fg = p.color0.hex, bg = p.color4.hex, gui = "bold" },
        c = { fg = p.color15.hex, bg = p.chromealt.hex },
        b = { fg = p.color15.hex, bg = p.chrome.hex },
    },
    insert = {
        a = { fg = p.color0.hex, bg = p.color2.hex, gui = "bold" },
        b = { fg = p.color0.hex, bg = p.color7.hex },
    },
    command = {
        a = { fg = p.color0.hex, bg = p.color3.hex, gui = "bold" },
        b = { fg = p.color15.hex, bg = p.chrome.hex },
    },
}

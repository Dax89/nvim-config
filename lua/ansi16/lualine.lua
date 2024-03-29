local p = require("ansi16.palette")

return {
    visual = {
        a = { fg = p.color0.hex, bg = p.color5.hex, gui = "bold" },
        b = { fg = p.color15.hex, bg = p.chromealt.hex },
    },
    replace = {
        a = { fg = p.color0.hex, bg = p.color1.hex, gui = "bold" },
        b = { fg = p.color15.hex, bg = p.chromealt.hex },
    },
    inactive = {
        c = { fg = p.color15.hex, bg = p.chrome.hex },
        b = { fg = p.color15.hex, bg = p.chrome.hex },
        a = { fg = p.color15.hex, bg = p.chromealt.hex },
    },
    normal = {
        a = { fg = p.color0.hex, bg = p.color4.hex, gui = "bold" },
        c = { fg = p.color15.hex, bg = p.chrome.hex },
        b = { fg = p.color15.hex, bg = p.chromealt.hex },
    },
    insert = {
        a = { fg = p.color0.hex, bg = p.color2.hex, gui = "bold" },
        b = { fg = p.color15.hex, bg = p.chromealt.hex },
    },
    command = {
        a = { fg = p.color0.hex, bg = p.color3.hex, gui = "bold" },
        b = { fg = p.color15.hex, bg = p.color4.hex },
    },
}

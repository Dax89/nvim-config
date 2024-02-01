local lush = require("lush")
local hsl = lush.hsl

-- https://m1.material.io/style/color.html#color-color-palette

local palette = {
    color0  = hsl("#1d1d1d"),
    color1  = hsl("#C2185B"), -- Pink        700
    color2  = hsl("#4caf50"), -- Green       500
    color3  = hsl("#FFA000"), -- Amber       700
    color4  = hsl("#7986CB"), -- Indigo      300
    color5  = hsl("#BA68C8"), -- Purple      300
    color6  = hsl("#00ACC1"), -- Cyan        600
    color7  = hsl("#757575"), -- Gray        600

    color8  = hsl("#263238"), -- Blue Grey   900
    color9  = hsl("#d81b60"), -- Pink        600
    color10 = hsl("#8bc34a"), -- Light Green 500
    color11 = hsl("#ffeb3b"), -- Yellow      500
    color12 = hsl("#90caf9"), -- Blue        200
    color13 = hsl("#E1BEE7"), -- Purple      100
    color14 = hsl("#80DEEA"), -- Cyan        200
    color15 = hsl("#bdbdbd"), -- Gray        400
}

return palette

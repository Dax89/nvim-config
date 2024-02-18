local lush = require("lush")
local hsl = lush.hsl

local p = {
    -- Regular
    color0  = hsl("#202020"), -- Black
    color1  = hsl("#ff7575"), -- Red
    color2  = hsl("#67bd61"), -- Green
    color3  = hsl("#ffb22e"), -- Yellow
    color4  = hsl("#7dafff"), -- Blue
    color5  = hsl("#e28ee6"), -- Magenta
    color6  = hsl("#13c3a0"), -- Cyan
    color7  = hsl("#cacaca"), -- White

    -- Bright
    color8  = hsl("#757575"), -- Black
    color9  = hsl("#ffa3a3"), -- Red
    color10 = hsl("#96d952"), -- Green
    color11 = hsl("#ffe262"), -- Yellow
    color12 = hsl("#90caf9"), -- Blue
    color13 = hsl("#f8c7ff"), -- Magenta
    color14 = hsl("#4ce0c5"), -- Cyan
    color15 = hsl("#f4f1d6"), -- White
}

-- NeoVim's chrome is outside 16 colors palette
p.chrome = p.color0
    .mix(p.color4, 30)
    .darken(46)

p.chromealt = p.color0
    .lighten(4)

return p

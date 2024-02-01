local lush = require("lush")

local M = {
    palette = require("config.ansi16.palette")
}

function M.colorscheme()
    for i = 0, 15 do
        vim.g["terminal_color_" .. i] = M.palette["color" .. i].hex
    end

    return require("config.ansi16.theme")
end

return M

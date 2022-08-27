local palette = require("onedark.palette").dark
local selected = {bg = palette.green, fg = palette.black, bold = true, italic = false}
local hlselected = {bg = palette.green, fg = palette.purple, bold = true, italic = false}

require("bufferline").setup({
    highlights = {
        fill = {bg = palette.bg0, fg = palette.bg0},
        offset_separator = {bg = palette.bg1, fg = palette.bg1},
        error_diagnostic_selected = {bg = palette.red, fg = palette.bg0, bold = false, italic = false},
        warning_diagnostic_selected = {bg = palette.bg_yellow, fg = palette.bg0, bold = false, italic = false},
        info_diagnostic_selected = {bg = palette.bg_blue, fg = palette.bg0, bold = false, italic = false},
        indicator_selected = hlselected,
        modified_selected = hlselected,
        buffer_selected = selected,
        numbers_selected = selected,
        diagnostic_selected = selected,
        error_selected = selected,
        warning_selected = selected,
        info_selected = selected,
        close_button_selected = selected,
    },
    options = {
        theme = "onedark",
        numbers = "ordinal",
        show_close_icon = false,
        right_mouse_command = nil,
        diagnostics = "nvim_lsp",

        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,

        close_command = function(nbuf)
            require("bufdelete").bufdelete(nbuf, true)
        end,

        middle_mouse_command = function(nbuf)
            require("bufdelete").bufdelete(nbuf, true)
        end,

        custom_filter = function(nbuf)
            if not vim.tbl_contains(require("config.common").filetype_blacklist, vim.bo[nbuf].filetype) then
                return true
            end
        end,

        offsets = {
            {
                filetype = "neo-tree",
                text = " NeoTree",
                text_align = "left",
                highlight = "Directory",
                separator = true,
            }
        },
    }
})


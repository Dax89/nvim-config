local palette = require("catppuccin.palettes").get_palette("macchiato")
local selected = {bg = palette.blue, fg = palette.crust, italic = false}
local hlselected = {bg = palette.blue, fg = palette.crust, italic = false}

require("bufferline").setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = {},
        custom = {
            all = {
                fill = {bg = palette.base, fg = palette.crust},
                offset_separator = {bg = palette.base, fg = palette.mantle},
                error_diagnostic_selected = {bg = palette.red, fg = palette.base, italic = false},
                warning_diagnostic_selected = {bg = palette.yellow, fg = palette.base, italic = false},
                info_diagnostic_selected = {bg = palette.sky, fg = palette.base, italic = false},
                hint_diagnostic_selected = {bg = palette.green, fg = palette.base, italic = false},
                indicator_selected = {bg = palette.blue, fg = palette.sky},
                modified_selected = hlselected,
                buffer_selected = selected,
                duplicate_selected = selected,
                numbers_selected = selected,
                diagnostic_selected = selected,
                error_selected = selected,
                warning_selected = selected,
                info_selected = selected,
                hint_selected = selected,
                close_button_selected = selected,
            },
        },
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
                text = function()
                    local s, p = "NeoTree", require("ide"):get_active_project()

                    if p then
                        s = p:get_name()
                        local cfg = p:get_selected_config()

                        if cfg then
                            s = s .. " - " .. cfg.name
                        end
                    end

                    return " " .. s
                end,
                text_align = "left",
                highlight = "Directory",
                separator = true,
            }
        },
    }
})


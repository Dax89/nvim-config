local common = require("config.common")
local palette = require("kanagawa.colors").setup()

common.set_options("g", {
    bufferline = {
        maximum_padding = 1,
        auto_hide = false,
        icons = "both",
        exclude_ft = common.filetype_blacklist
    }
})

require("bufferline").setup({
    highlights = {
        offset_separator = {bg = palette.sumiInk1},
        modified_selected = {italic = false},
        duplicate_selected = {italic = false},
        numbers_selected = {italic = false},
        error_selected = {italic = false},
        warning_selected = {italic = false},
        info_selected = {italic = false},
        buffer_selected = {italic = false},
        diagnostic_selected = {italic = false},
        pick_selected = {italic = false},
        pick_visible = {italic = false},
        pick = {italic = false},
    },
    options = {
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
                    local ok, automaton = pcall(require, "automaton")
                    local s = "NEO-TREE"

                    if ok then
                        local ws = automaton.get_active_workspace()

                        if ws then
                            s = " " .. ws:get_name()
                            local task, launch = ws:get_default_task(), ws:get_default_launch()

                            if task then
                                s = s .. " |  " .. task.name
                            end

                            if launch then
                                s = s .. " |  " .. launch.name
                            end
                        end
                    end

                    return s
                end,
                text_align = "left",
                highlight = "Directory",
                separator = true,
            }
        },
    }
})

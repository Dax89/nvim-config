local common = require("config.common")
local palette = require("nvim-tundra.palette.arctic")

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
        offset_separator = {bg = palette.gray._900},
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
                    local ok, ide = pcall(require, "ide")
                    local s = "NEO-TREE"

                    if not ok then
                        return s
                    end

                    local p = ide:get_active_project()

                    if p then
                        s = p:get_name()
                        local cfg, runcfg = p:get_selected_config(), p:get_selected_runconfig()

                        if cfg then
                            s = s .. " |  " .. cfg.name
                        end

                        if runcfg then
                            s = s .. " |  " .. runcfg.name
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

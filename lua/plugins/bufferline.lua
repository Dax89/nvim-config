return {
    {
        "akinsho/bufferline.nvim",
        event = "VimEnter",

        keys = {
            {"<leader>h", "<CMD>BufferLineMovePrev<CR>"},
            {"<leader>l", "<CMD>BufferLineMoveNext<CR>"},
            {"<leader>,", "<CMD>BufferLinePick<CR>"},
            {"<leader>1", "<CMD>BufferLineGoToBuffer 1<CR>"},
            {"<leader>2", "<CMD>BufferLineGoToBuffer 2<CR>"},
            {"<leader>3", "<CMD>BufferLineGoToBuffer 3<CR>"},
            {"<leader>4", "<CMD>BufferLineGoToBuffer 4<CR>"},
            {"<leader>5", "<CMD>BufferLineGoToBuffer 5<CR>"},
            {"<leader>6", "<CMD>BufferLineGoToBuffer 6<CR>"},
            {"<leader>7", "<CMD>BufferLineGoToBuffer 7<CR>"},
            {"<leader>8", "<CMD>BufferLineGoToBuffer 8<CR>"},
            {"<leader>9", "<CMD>BufferLineGoToBuffer 9<CR>"},
            {"<leader>+", "<CMD>enew<CR>"},
            {"<leader>-", function() require("bufdelete").bufdelete(0, true) end},
            {"<C-Tab>", "<CMD>BufferLineCycleNext<CR>"},
            {"<C-S-Tab>", "<CMD>BufferLineCyclePrev<CR>"},
        },

        opts = function()
            local colors = require("kanagawa.colors").setup()

            return {
                highlights = {
                    offset_separator = {bg = colors.palette.sumiInk3},
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
                        local common = require("config.common")

                        local mustfilter = vim.tbl_contains(common.buftype_blacklist, vim.bo[nbuf].buftype)
                        if mustfilter then return false end

                        mustfilter = vim.tbl_contains(common.filetype_blacklist, vim.bo[nbuf].filetype)
                        if mustfilter then return false end

                        return true
                    end,

                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = function()
                                local dapok, dap = pcall(require, "dap")

                                if dapok then
                                    local session = dap.session()

                                    if session then
                                        return " " .. vim.F.if_nil(session.config.name, "DEBUG")
                                    end
                                end

                                local automatonok, automaton = pcall(require, "automaton")
                                local s = "NEO-TREE"

                                if automatonok then
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
            }
        end
    }
}

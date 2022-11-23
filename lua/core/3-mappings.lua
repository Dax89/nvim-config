local function map_keys(keytable)
    local common = require("config.common")

    for t, keys in pairs(keytable) do
        for k, act in pairs(keys) do
            common.map(k, act, t)
        end
    end
end

local KEYS = {
    n = { -- NORMAL
        ["<Up>"] = "<Nop>",
        ["<Down>"] = "<Nop>",
        ["<Left>"] = "<Nop>",
        ["<Right>"] = "<Nop>",
        ["<Space>"] = "<Nop>",
        ["&"] = require("searchbox").replace,
        ["<leader>a"] = "gg0VG",
        ["<leader>1"] = ":BufferLineGoToBuffer 1<CR>",
        ["<leader>2"] = ":BufferLineGoToBuffer 2<CR>",
        ["<leader>3"] = ":BufferLineGoToBuffer 3<CR>",
        ["<leader>4"] = ":BufferLineGoToBuffer 4<CR>",
        ["<leader>5"] = ":BufferLineGoToBuffer 5<CR>",
        ["<leader>6"] = ":BufferLineGoToBuffer 6<CR>",
        ["<leader>7"] = ":BufferLineGoToBuffer 7<CR>",
        ["<leader>8"] = ":BufferLineGoToBuffer 8<CR>",
        ["<leader>9"] = ":BufferLineGoToBuffer 9<CR>",
        ["<leader>+"] = ":enew<CR>",
        ["<leader>c"] = ":Telescope neoclip<CR>",
        ["<leader>h"] = ":BufferLineMovePrev<CR>",
        ["<leader>l"] = ":BufferLineMoveNext<CR>",
        ["<leader>p"] = ":BufferLinePick<CR>",
        ["<leader>s" ] = ":Telescope lsp_document_symbols<CR>",
        ["<leader>w" ] = require("nvim-window").pick,
        ["<A-S-Enter>"] = vim.lsp.buf.signature_help,
        ["<C-F6>"] = ":TroubleToggle<CR>",
        ["<C-F7>"] = ":SymbolsOutline<CR>",
        ["<C-n>"] = "<Nop>",
        ["<C-h>"] = ":Telescope oldfiles<CR>",
        ["<C-Tab>"] = ":BufferLineCycleNext<CR>",
        ["<C-S-Tab>"] = ":BufferLineCyclePrev<CR>",
        ["<C-S-k>"] = ":Telescope live_grep<CR>",
        ["<A-S-k>"] = ":Telescope lsp_dynamic_workspace_symbols<CR>",
        ["<S-Enter>"] = vim.lsp.buf.references,
        ["<A-Enter>"] = vim.lsp.buf.code_action,
        ["<A-p>" ] = require("config.general").show_general_settings,
        ["<F2>"] = vim.lsp.buf.rename,
        ["<F4>"] = ":ClangdSwitchSourceHeader<CR>",
        ["<F9>"] = ":DapToggleBreakpoint<CR>",
        ["<F10>"] = ":DapStepOver<CR>",
        ["<F11>"] = ":DapStepInto<CR>",

        ["<leader>m"] = function()
            if require("codewindow.window").is_minimap_open() then
                require("codewindow").close_minimap()
            else
                require("codewindow").open_minimap()
            end
        end,

        ["/"] = function()
            require("searchbox").match_all({clear_matches = true})
        end,

        ["|"] = function()
            require("spectre").open()
        end,

        ["<leader>-"] = function()
            require("bufdelete").bufdelete(0, true)
        end,

        ["<leader>r"] = function()
            require("ssr").open()
        end,

        ["<leader>g" ] = function()
            local cwd = vim.fn.expand('%:p:h')
            require("neogit").open({kind = "split"})
            vim.cmd(":lcd" .. cwd)
        end,

        ["<leader>f"] = function()
            require("hop").hint_words({direction = require"hop.hint".HintDirection.AFTER_CURSOR})
        end,

        ["<leader>F"] = function()
            require("hop").hint_words({direction = require("hop.hint").HintDirection.BEFORE_CURSOR})
        end,

        ["<C-k>"] = function()
            require("telescope.builtin").find_files()
        end,
    },

    v = { -- VISUAL
        ["&"] = require("searchbox").replace,
        ["<A-Enter>"] = vim.lsp.buf.range_code_action,


        ["/"] = function()
            require("searchbox").match_all({clear_matches = true, visual_mode = true})
        end,
    },

    i = { -- INSERT
        ["<C-n>"] = "<Nop>",
        ["<F2>"] = vim.lsp.buf.rename
    },

    x = {
        ["<leader>r"] = function()
            require("ssr").open()
        end
    },

    t = { -- TERMINAL

    }
}

map_keys(KEYS)

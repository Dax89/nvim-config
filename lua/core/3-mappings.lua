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
        ["<Leader>a"] = "gg0VG",
        ["<Leader>1"] = ":BufferLineGoToBuffer 1<CR>",
        ["<Leader>2"] = ":BufferLineGoToBuffer 2<CR>",
        ["<Leader>3"] = ":BufferLineGoToBuffer 3<CR>",
        ["<Leader>4"] = ":BufferLineGoToBuffer 4<CR>",
        ["<Leader>5"] = ":BufferLineGoToBuffer 5<CR>",
        ["<Leader>6"] = ":BufferLineGoToBuffer 6<CR>",
        ["<Leader>7"] = ":BufferLineGoToBuffer 7<CR>",
        ["<Leader>8"] = ":BufferLineGoToBuffer 8<CR>",
        ["<Leader>9"] = ":BufferLineGoToBuffer 9<CR>",
        ["<Leader>+"] = ":enew<CR>",
        ["<leader>c"] = ":Telescope neoclip<CR>",
        ["<Leader>h"] = ":BufferLineMovePrev<CR>",
        ["<Leader>l"] = ":BufferLineMoveNext<CR>",
        ["<Leader>p"] = ":BufferLinePick<CR>",
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

        ["/"] = function()
            require("searchbox").match_all({clear_matches = true})
        end,

        ["<Leader>-"] = function()
            require("bufdelete").bufdelete(0, true)
        end,

        ["<Leader>g" ] = function()
            local cwd = vim.fn.expand('%:p:h')
            require("neogit").open({kind = "split"})
            vim.cmd(":lcd" .. cwd)
        end,

        ["<Leader>f"] = function()
            require("hop").hint_words({direction = require"hop.hint".HintDirection.AFTER_CURSOR})
        end,

        ["<Leader>F"] = function()
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

    t = { -- TERMINAL

    }
}

map_keys(KEYS)

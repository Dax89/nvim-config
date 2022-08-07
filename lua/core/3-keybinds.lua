local function map_keys(keytable)
    local common = require("core.common")

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
        ["<Leader>1"] = ":BufferGoto 1<CR>",
        ["<Leader>2"] = ":BufferGoto 2<CR>",
        ["<Leader>3"] = ":BufferGoto 3<CR>",
        ["<Leader>4"] = ":BufferGoto 4<CR>",
        ["<Leader>5"] = ":BufferGoto 5<CR>",
        ["<Leader>6"] = ":BufferGoto 6<CR>",
        ["<Leader>7"] = ":BufferGoto 7<CR>",
        ["<Leader>8"] = ":BufferGoto 8<CR>",
        ["<Leader>9"] = ":BufferLast<CR>",
        ["<Leader>-"] = ":BufferClose!<CR>",
        ["<Leader>+"] = ":enew<CR>",
        ["<Leader>p"] = ":BufferPick<CR>",
        ["<C-F7>"] = ":SymbolsOutline<CR>",
        ["<C-n>"] = "<Nop>",
        ["<C-h>"] = ":Telescope oldfiles<CR>",
        ["<C-k>"] = ":Telescope find_files<CR>",
        ["<C-Tab>"] = ":bn<CR>",
        ["<C-S-Tab>"] = ":bp<CR>",
        ["<C-S-k>"] = ":Telescope live_grep<CR>",
        ["<S-Enter>"] = ":Lspsaga lsp_finder<CR>",
        ["<A-Enter>"] = ":Lspsaga code_action<CR>",
        ["<A-g>" ] = require("config.git").show_git_commands,
        ["<A-p>" ] = require("config.general").show_general_settings,
        ["<F2>"] = require("renamer").rename,
        ["<F6>"] = ":FloatermToggle<CR>",
        ["<F9>"] = ":DapToggleBreakpoint<CR>",
        ["<F10>"] = ":DapStepOver<CR>",
        ["<F11>"] = ":DapStepInto<CR>",

        ["/"] = function()
            require("searchbox").match_all({clear_matches = true})
        end,

        [",f"] = function()
            require("hop").hint_words({direction = require"hop.hint".HintDirection.AFTER_CURSOR})
        end,

        [",F"] = function()
            require("hop").hint_words({direction = require("hop.hint").HintDirection.BEFORE_CURSOR})
        end,

        ["<F7>"] = function()
            local dap = require("dap")

            if #dap.status() == 0 then
                vim.api.nvim_command(":NvimTreeToggle")
            else
                dap.step_into()
            end
        end
    },

    v = { -- VISUAL
        ["<F2>"] = require("renamer").rename,
        ["&"] = require("searchbox").replace,

        ["/"] = function()
            require("searchbox").match_all({clear_matches = true, visual_mode = true})
        end,
    },

    i = { -- INSERT
        ["<C-n>"] = "<Nop>",
        ["<F2>"] = require("renamer").rename,
    },

    t = { -- TERMINAL
        ["<F6>"] = "<C-\\><C-n>:FloatermToggle<CR>"
    }
}

map_keys(KEYS)

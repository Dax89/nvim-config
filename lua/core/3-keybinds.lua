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
        ["<leader>c"] = ":Telescope neoclip<CR>",
        ["<Leader>h"] = ":BufferMovePrevious<CR>",
        ["<Leader>l"] = ":BufferMoveNext<CR>",
        ["<Leader>p"] = ":BufferPick<CR>",
        ["<leader>s" ] = ":Telescope lsp_document_symbols<CR>",
        ["<leader>w" ] = require("nvim-window").pick,
        ["<A-S-Enter>"] = ":Lspsaga signature_help<CR>",
        ["<C-F5>"] = require("config.project").run,
        ["<C-F6>"] = ":TroubleToggle<CR>",
        ["<C-F7>"] = ":SymbolsOutline<CR>",
        ["<C-F8>"] = require("config.project").settings,
        ["<C-n>"] = "<Nop>",
        ["<C-h>"] = ":Telescope oldfiles<CR>",
        ["<C-Tab>"] = ":bn<CR>",
        ["<C-S-Tab>"] = ":bp<CR>",
        ["<C-S-k>"] = ":Telescope live_grep<CR>",
        ["<A-S-k>"] = ":Telescope lsp_dynamic_workspace_symbols<CR>",
        ["<S-Enter>"] = ":Lspsaga lsp_finder<CR>",
        ["<A-Enter>"] = ":Lspsaga code_action<CR>",
        ["<A-BS>"] = require("config.project").cancel,
        ["<A-p>" ] = require("config.general").show_general_settings,
        ["<F2>"] = ":Lspsaga rename<CR>",
        ["<F4>"] = ":ClangdSwitchSourceHeader<CR>",
        ["<F9>"] = ":DapToggleBreakpoint<CR>",
        ["<F10>"] = ":DapStepOver<CR>",
        ["<F11>"] = ":DapStepInto<CR>",

        ["/"] = function()
            require("searchbox").match_all({clear_matches = true})
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
            if require("plenary.path"):new(vim.fn.getcwd(), ".git"):is_dir() then
                require("telescope.builtin").git_files({recurse_submodules = true})
            else
                require("telescope.builtin").find_files()
            end
        end,

        ["<A-F5>"] = function()
            local dap = require("dap")

            if #dap.status() > 0 then
                dap.disconnect()
            end
        end,

        ["<F5>"] = function()
            local dap = require("dap")

            if #dap.status() > 0 then
                dap.continue()
            else
                require("config.project").debug()
            end
        end,

        ["<F7>"] = function()
            local dap = require("dap")

            if #dap.status() == 0 then
                vim.api.nvim_command(":NeoTreeShowToggle")
            else
                dap.step_into()
            end
        end,

        ["<F8>"] = function()
            local dap = require("dap")

            if #dap.status() > 0 then
                dap.step_over()
            else
                require("config.project").build()
            end
        end
    },

    v = { -- VISUAL
        ["&"] = require("searchbox").replace,

        ["/"] = function()
            require("searchbox").match_all({clear_matches = true, visual_mode = true})
        end,
    },

    i = { -- INSERT
        ["<C-n>"] = "<Nop>",
        ["<F2>"] =  ":Lspsaga rename<CR>",
    },

    t = { -- TERMINAL

    }
}

map_keys(KEYS)

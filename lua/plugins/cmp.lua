local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function keymap_cinkeys(expr)
    local keymap = require("cmp.utils.keymap")
    return string.format(keymap.t("<Cmd>set cinkeys=%s<CR>"), expr and vim.fn.escape(expr, "| \t\\") or "")
end

-- https://github.com/hrsh7th/nvim-cmp/issues/1035
local function confirm(fallback)
    local cmp = require("cmp")
    local feedkeys = require("cmp.utils.feedkeys")

    if cmp.visible() then
        feedkeys.call(keymap_cinkeys(), "n")
        cmp.confirm({ select = true })
        feedkeys.call(keymap_cinkeys(vim.bo.cinkeys), "n")
    else
        fallback()
    end
end

return {
    "L3MON4D3/LuaSnip",

    {
        "rafamadriz/friendly-snippets",

        config = function()
            require("luasnip/loaders/from_vscode").lazy_load({
                paths = {
                    vim.fn.stdpath("data") .. "/lazy/friendly_snippets",
                    vim.fn.stdpath("config") .. "/snippet",
                }
            })
        end
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "HiPhish/nvim-cmp-vlime",
        },
        opts = function()
            local cmp, luasnip = require("cmp"), require("luasnip")

            return {
                preselect = cmp.PreselectMode.Item,
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                formatting = {
                    fields = { "icon", "abbr", "menu" },
                    format = require("lspkind").cmp_format({
                        maxwidth = 100,

                        before = function(entry, item)
                            local shortname = {
                                nvim_lsp = "LSP",
                                nvim_lua = "nvim"
                            }

                            local mnuname = shortname[entry.source.name] or entry.source.name
                            item.menu = string.format("[%s]", mnuname)
                            return item
                        end
                    })
                },
                mapping = {
                    ["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-e>"]     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
                    ["<CR>"]      = cmp.mapping(confirm),

                    ["<TAB>"]     = cmp.mapping(function(fallback)
                        if cmp.visible then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback({ "i", "s" })
                        end
                    end),

                    ["<S-TAB>"]   = cmp.mapping(function(fallback)
                        if cmp.visible then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback({ "i", "s" })
                        end
                    end)
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "luasnip" },
                    { name = "vlime" },
                }),

                sorting = {
                    priority_weight = 1.0,
                },
            }
        end,

        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)

            local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

            if ok then
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end

            -- Enhance highlighting
            vim.api.nvim_set_hl(0, "CmpItemKindIcon", { link = "Type" })
            vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "Keyword" })
        end
    }
}

local cmp, luasnip  = require("cmp"), require("luasnip")

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("luasnip/loaders/from_vscode").lazy_load({
    paths = {
        vim.fn.stdpath("data") .. "/site/pack/packer/start/friendly-snippets",
        vim.fn.stdpath("config") .. "/snippet",
    }
})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    formatting = {
        format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 100,

            before = function (_, vim_item)
                return vim_item
            end
        })
    },
    mapping = {
        ["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<C-e>"]     = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
        ["<CR>"]      = cmp.mapping(cmp.mapping.confirm({select = true})),

        ["<TAB>"]     = cmp.mapping(function(fallback)
            if cmp.visible then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            elseif has_words_before() then cmp.complete()
            else fallback({"i", "s"})
            end
        end),

        ["<S-TAB>"]   = cmp.mapping(function(fallback)
            if cmp.visible then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.expand_or_jump()
            elseif has_words_before() then cmp.complete()
            else fallback({"i", "s"})
            end
        end)
    },

    sources           = cmp.config.sources({
        {name = "nvim_lsp"},
        {name = "nvim_lua"},
        {name = "luasnip"},
        {name = "path"},
        {name = "orgmode"}
    }),

    sorting           = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

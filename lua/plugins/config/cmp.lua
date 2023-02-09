local cmp = require("cmp")

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function get_comparators()
    local comparators = {
        cmp.config.compare.locality,
        cmp.config.compare.recently_used,
        cmp.config.compare.score,
        cmp.config.compare.offset,
        cmp.config.compare.order,
        -- cmp.config.compare.sort_text,
        -- cmp.config.compare.exact,
        -- cmp.config.compare.kind,
        -- cmp.config.compare.length,
    }

    return comparators
end

cmp.setup({
    preselect = cmp.PreselectMode.Item,
    completion = {
      completeopt = "menu,menuone,noinsert"
    },
    window = {
        documentation = vim.tbl_extend("force", cmp.config.window.bordered(), {
            max_height = 15,
            max_width = 60,
        })
    },
    formatting = {
        fields = { "kind", "abbr", "menu"},
        format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 100,

            before = function (entry, item)
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
        ["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<C-e>"]     = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
        ["<CR>"]      = cmp.mapping(cmp.mapping.confirm({select = true})),

        ["<TAB>"]     = cmp.mapping(function(fallback)
            if cmp.visible then cmp.select_next_item()
            elseif has_words_before() then cmp.complete()
            else fallback({"i", "s"})
            end
        end),

        ["<S-TAB>"]   = cmp.mapping(function(fallback)
            if cmp.visible then cmp.select_prev_item()
            elseif has_words_before() then cmp.complete()
            else fallback({"i", "s"})
            end
        end)
    },

    sources           = cmp.config.sources({
        {name = "nvim_lsp", group_index = 1},
        {name = "nvim_lua", groupindex = 2},
        {name = "path", group_index = 2},
        {name = "orgmode"}
    }),

    sorting           = {
        priority_weight = 1.0,
        comparators = get_comparators()
    },
})


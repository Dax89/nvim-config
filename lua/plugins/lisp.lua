return {
    {
        "monkoose/nvlime",
        cmp_enabled = true,

        enabled = function()
            return vim.fn.executable("sbcl") == 1
        end,

        init = function()
            vim.g.nvlime_config = {
                implementation = "sbcl",
                cmp = { enabled = true },
                main_window = { position = "right" }
            }
        end,

        config = function()
            local ok, cmp = pcall(require, "cmp")

            if ok then
                cmp.setup.filetype({ "lisp" }, {
                    sources = {
                        { name = "nvlime" }
                    }
                })
            end
        end,

        dependencies = {
            "monkoose/parsley",
            "kovisoft/paredit",
            "hrsh7th/nvim-cmp",
        },

        ft = "lisp"
    }
}

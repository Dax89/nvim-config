local wk = require("which-key")

wk.register({
    name = "+git",
    ["g"] = {
        function()
            local cwd = vim.fn.expand('%:p:h')
            require("neogit").open({kind = "split"})
            vim.cmd(":lcd" .. cwd)
        end,
        "Show Git"
    }
}, {prefix = "<leader>"})

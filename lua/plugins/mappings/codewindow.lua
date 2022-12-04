local wk = require("which-key")

wk.register({
    ["m"] = {
        function()
            if require("codewindow.window").is_minimap_open() then
                require("codewindow").close_minimap()
            else
                require("codewindow").open_minimap()
            end
        end,
        "Toggle MiniMap"
    }
}, {prefix = "<leader>"})


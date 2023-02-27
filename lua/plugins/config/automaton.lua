require("automaton").setup({
    debug = true,

    events = {
        workspacechanged = function(ws)
            if ws then
                require("neo-tree").show()
            end
        end
    }
})

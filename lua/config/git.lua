local common = require("core.common")

local function push_to_branch()
    vim.ui.input({
        prompt = "[PUSH] Insert branch name:"
    },
    function(branch)
        if #branch > 0 then
            vim.api.nvim_command(":Git push origin " .. branch)
        end
    end)
end

local function pull_from_branch()
    vim.ui.input({
        prompt = "[PULL] Insert branch name:"
    },
    function(branch)
        if #branch > 0 then
            vim.api.nvim_command(":Git pull origin " .. branch)
        end
    end)
end

return {
    show_git_commands = function()
        common.show_select("Git", {
            {"Show", ":Git"},
            {"Diff", ":Git diff"},
            {"Log", ":Git log"},
            {"Commit...", ":Git commit"},
            {"Amend Last Commit", ":Git commit amend"},
            {"Push to master", ":Git push origin master"},
            {"Pull from master", ":Git pull origin master"},
            {"Push to...", push_to_branch},
            {"Pull from ...", pull_from_branch},
            {"Reset", ":Git reset"},
        })
    end
}

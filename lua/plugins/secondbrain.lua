local function obsidian_sync()
    local obok, obsidian = pcall(require, "obsidian")
    if not obok then return end

    local client = obsidian.get_client()
    if not client then return end

    local vaultpath = client.current_workspace.path.filename
    local currpath = vim.api.nvim_buf_get_name(0)
    if not vim.startswith(currpath, vaultpath) then return end

    local oldcwd = vim.fn.getcwd()
    vim.api.nvim_set_current_dir(vaultpath)

    local now = require("os").date("%Y-%m-%d %H:%M:%S")
    local commitmsg = "vault backup: " .. now

    local COMMANDS = {
        { "git", "add",    "." },
        { "git", "commit", "-m", commitmsg },
        { "git", "push" },
    }

    local code = -1

    for _, cmd in ipairs(COMMANDS) do
        local s = vim.system(cmd):wait()
        code = s.code
        if code ~= 0 then break end
    end

    if code == 0 then
        vim.notify("Vault synced successfully")
    else
        vim.notify("Vault sync failed", "error")
    end

    vim.api.nvim_set_current_dir(oldcwd)
end

return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- Use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        config = true,

        dependencies = {
            "nvim-lua/plenary.nvim", -- Required.
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter"
        },

        keys = {
            { "<leader>on", "<CMD>ObsidianNew<CR>",         desc = "Obsidian - New" },
            { "<leader>oo", "<CMD>ObsidianQuickSwitch<CR>", desc = "Obsidian - Quick Switch" },
            { "<leader>ol", "<CMD>ObsidianFollowLink<CR>",  desc = "Obsidian - Follow Link" },
            { "<leader>ot", "<CMD>ObsidianTags<CR>",        desc = "Obsidian - Tags" },
            { "<leader>od", "<CMD>ObsidianToday<CR>",       desc = "Obsidian - Today" },
            { "<leader>of", "<CMD>ObsidianSearch<CR>",      desc = "Obsidian - Search Word" },
            { "<leader>ow", "<CMD>ObsidianWorkspace<CR>",   desc = "Obsidian - Workspace" },
            { "<leader>oS", obsidian_sync,                  desc = "Obsidian - Sync" },
        },

        opts = {
            follow_url_func = vim.ui.open,

            ui = {
                enable = true,
                checkboxes = {
                    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                    ["~"] = { char = "", hl_group = "ObsidianTilde" },
                    ["!"] = { char = "", hl_group = "ObsidianImportant" },
                },
            },

            workspaces = {
                { name = "Notes", path = vim.fn.expand("~") .. "/Documents/Notes" }
            },

            completion = {
                nvim_cmp = true,
                min_chars = 1,
            },

            daily_notes = {
                folder = "Daily Notes",
                date_format = "%Y-%m-%d",
                alias_format = "%B %-d, %Y",
                default_tags = { "notes", "daily" },
            },

            templates = {
                folder = "Templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
            },

            mappings = {
                ["<F1>"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true }
                },
                ["<F2>"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true }
                }
            },
        }
    }
}

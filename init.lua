local function check_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
            lazypath })
    end

    vim.opt.rtp:prepend(lazypath)
end

local function disable_builtins()
    local PLUGINS = {
        "gzip",
        "zip",
        "zipPlugin",
        "fzf",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "spellfile_plugin",
        "rrhelper",
        "matchit",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
    }

    for _, plugin in ipairs(PLUGINS) do
        vim.g["loaded_" .. plugin] = 1
    end
end

check_lazy()
disable_builtins()

-- Use "q" to close special buffer types.
-- "" catches a lot of transient plugin windows.
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
        local TYPES = {
            "help", "fugitive", "checkhealth", "vim", "qf", ""
        }

        if vim.tbl_contains(TYPES, vim.bo[args.buf].filetype) then
            vim.api.nvim_buf_set_keymap(args.buf, "n", "q", "", {
                callback = function()
                    vim.api.nvim_command("close")
                end
            })
        end
    end
})

require("config.options")
require("config.commands")
require("config.diagnostic")
require("config.mappings")
require("config.bookmarks")
require("config.secondbrain")

require("lazy").setup("plugins", {
    ui = {
        backdrop = 100,
        border = "rounded"
    }
})

require("lang.cpp")
require("lang.json")

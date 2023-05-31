local function check_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
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
        "spellfile_plugin";
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

require("config.options")
require("config.commands")
require("config.diagnostic")
require("config.mappings")
require("config.secondbrain")

require("lazy").setup("plugins")

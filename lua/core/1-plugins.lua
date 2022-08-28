local PACKER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local function disable_builtins()
    for _, plugin in pairs(require("config.plugins").disabledbuiltins) do
        vim.g["loaded_" .. plugin] = 1
    end
end

local function is_packer_installed()
    return vim.fn.empty(vim.fn.glob(PACKER_PATH)) == 0
end

local function packer_startup(plugins)
    local packer = require("packer")

    packer.init({
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",

        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end
        }
    })

    packer.reset()

    packer.startup(function(use)
        for _, plugin in ipairs(plugins) do
            use(plugin)
        end
    end)
end

local WAS_INSTALLED = is_packer_installed()

if not is_packer_installed() then
    print("Could not find packer.nvim, cloning new copy to", PACKER_PATH)
    vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", PACKER_PATH})
    vim.api.nvim_command("packadd packer.nvim")
end

disable_builtins()
packer_startup(require("config.plugins").plugins)

if not WAS_INSTALLED then
    require("packer").sync()
end

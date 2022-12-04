local PACKER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local function disable_builtins()
    for _, plugin in pairs(require("config.plugins").disabledbuiltins) do
        vim.g["loaded_" .. plugin] = 1
    end
end

local function is_packer_installed()
    return vim.fn.empty(vim.fn.glob(PACKER_PATH)) == 0
end

local function get_plugin_name(plugin)
    if type(plugin.as) == "string" then
        return plugin.as
    end

    local parts = vim.split(plugin[1], "/")

    if vim.tbl_isempty(parts) then
        error("Cannot get plugin name for '" .. plugin[1] .. "'")
    end

    return parts[#parts]
end

-- HACK: https://github.com/wbthomason/packer.nvim/discussions/443
local function get_plugin_config(plugin)
    local name = get_plugin_name(plugin)

    return ([[
    local ok, res = pcall(require, "plugins.config.%s")

    if not ok and not res:match("^module '.+' not found") then
        error(res) -- Propagate error
    end

    local ok, res = pcall(require, "plugins.mappings.%s")

    if not ok and not res:match("^module '.+' not found") then
        error(res) -- Propagate error
    end
    ]]):format(name, name)
end

-- HACK: https://github.com/wbthomason/packer.nvim/discussions/443
local function get_plugin_run(plugin)
    local name = get_plugin_name(plugin)

    return ([[
    local ok, res = pcall(require, "plugins.run.%s")

    if not ok and not res:match("^module '.+' not found") then
        error(res) -- Propagate error
    end
    ]]):format(name, name)
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
            if type(plugin) ~= "table" then
                plugin = {plugin}
            end

            if not plugin.noconfig and not plugin.config then
                plugin.config = get_plugin_config(plugin)
            end

            if plugin.run == true then
                plugin.run = get_plugin_run(plugin)
            end

            use(plugin)
        end
    end)
end

local WAS_INSTALLED = is_packer_installed()

if not is_packer_installed() then
    print("Could not find packer.nvim, cloning new copy to", PACKER_PATH)
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. PACKER_PATH)
    vim.api.nvim_command("packadd packer.nvim")
end

disable_builtins()
packer_startup(require("config.plugins").plugins)

if not WAS_INSTALLED then
    require("packer").sync()
end


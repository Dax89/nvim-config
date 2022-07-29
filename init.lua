local function load_modules(p)
    for _, mod in ipairs(vim.fn.glob(p, nil, true)) do
        require(string.gsub(mod:match(".+/lua/(.+).lua$"), "/", "."))
    end
end

local function get_config_path(p)
    return vim.fn.stdpath("config") .. p
end

local function load_config(p)
    load_modules(get_config_path("/lua/" .. p .. "/*-*.lua"))
end

_G.nvcfg = { }       -- Initialize config namespace

pcall(require, "impatient")       -- Preload impatient (if installed)
pcall(require, "packer_compiled") -- Load & Cache "packer_compiled.lua" (if exists)

local instplugins, configs  = _G["packer_plugins"], { }

if type(instplugins) == "table" and #vim.tbl_keys(instplugins) > 0 then
    configs = {"core", "plugins"}
else
    configs = {"core"}
end

for _, c in pairs(configs) do
    load_config(c)
end

local hotpotpath = vim.fn.stdpath("data").."/site/pack/packer/start/hotpot.nvim"

if vim.fn.empty(vim.fn.glob(hotpotpath)) > 0 then
    print("Could not find hotpot.nvim, cloning new copy to", hotpotpath)
    vim.fn.system({"git", "clone", "https://github.com/rktjmp/hotpot.nvim", hotpotpath})
end

_G.nvcfg = { }       -- Initialize config namespace
require("impatient") -- Preload impatient

local packercompiled = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"

if vim.fn.filereadable(packercompiled) == 1 then
    require("packer_compiled") -- Load & Cache "packer_compiled.lua"
end

require("hotpot") -- Bootstrap .fnl support
require("config") -- Load Configuration

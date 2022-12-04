pcall(require, "impatient")       -- Preload impatient (if installed)
require("config.options")
require("config.commands")
require("config.lsp")

pcall(require, "packer_compiled") -- Load & Cache "packer_compiled.lua" (if exists)
require("plugins")

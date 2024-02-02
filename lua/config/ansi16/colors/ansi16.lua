if vim.g.colors_name then
    vim.cmd("hi clear")
    vim.cmd("syntax reset")
end

vim.opt.background = "dark"
vim.g.colors_name = "ansi16"

package.loaded["config.ansi16"] = nil
require("lush")(require("config.ansi16"))

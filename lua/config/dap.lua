function on_exit()
    local ok, virtualtext = pcall(require, "nvim-dap-virtual-text/virtual_text")

    if ok then
        virtualtext.clear_virtual_text()
        virtualtext.clear_last_frames()
    end

    local dap = require("dap")
    dap.repl.close()

    vim.cmd("silent! bd! \\[dap-terminal]")
end

return {
    on_exit = on_exit
}

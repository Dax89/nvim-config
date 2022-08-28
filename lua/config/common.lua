local M = {}

M.filetype_blacklist = {
    "alpha",
    "NeogitStatus",
    "NeogitPopup",
    "NeogitCommitMessage",
    "neo-tree",
    "dap-repl",
    "qf"
}

M.if_installed = function(module, cb)
    local ok, m = pcall(require, module)

    if ok then
        cb(m)
    end
end

M.show_select = function(prompt, choices, mode)
    local m = nil

    if mode == "cursor" then
        m = require("telescope.themes").get_cursor()
    end

    vim.ui.select(choices, {
        prompt = prompt,
        telescope = m,
        format_item = function(item)
            return item[1]
        end
    },
    function(choice)
        if choice then
            if type(choice[2]) == "function" then
                choice[2]()
            else
                vim.api.nvim_command(choice[2])
            end
        end
    end)
end

M.wrap_fn = function(mod, fn)
    return string.format(":lua require('%s')['%s']()<CR>", mod, fn)
end

M.map = function(key, cmd, mode, options)
    local opts = {silent = true}

    if options then
        opts = vim.tbl_extend("force", opts, options)
    end

    vim.keymap.set(mode, key, cmd, opts)
end

M.map_keys = function(keys)
    for _, key in ipairs(keys) do
        vim.api.nvim_set_keymap(unpack(key))
    end
end

M.set_options = function(t, options)
    for k, v in pairs(options) do
        vim[t][k] = v
    end
end

M.exec_commands = function(commands)
    if type(commands) == "string" then
        vim.api.nvim_command(commands)
        return
    end

    for _, command in pairs(commands) do
        vim.api.nvim_command(command)
    end
end

M.open_folder = function(path)
    local Job = require("plenary.job")

    local job = Job:new({
        command = vim.fn.has("unix") and "xdg-open" or "start",
        args = {path}
    })

    job:start()
end

return M

local common = {
    filetype_blacklist = {
        "help",
        "dashboard",
        "toggleterm",
        "NeogitStatus",
        "NeogitPopup",
        "NeogitCommitMessage",
        "neo-tree",
        "dap-repl",
        "qf"
    }
}

function common.highlight(items, ns)
    for _, item in ipairs(items) do
        vim.api.nvim_set_hl(ns or 0, item[1], item[2])
    end
end

function common.show_select(prompt, choices, mode)
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

function common.wrap_fn(mod, fn)
    return string.format(":lua require('%s')['%s']()<CR>", mod, fn)
end

function common.map(key, cmd, mode, options)
    local opts = {silent = true}

    if options then
        opts = vim.tbl_extend("force", opts, options)
    end

    vim.keymap.set(mode, key, cmd, opts)
end

function common.map_keys(keys)
    for _, key in ipairs(keys) do
        vim.api.nvim_set_keymap(unpack(key))
    end
end

function common.set_options(t, options)
    for k, v in pairs(options) do
        vim[t][k] = v
    end
end

function common.exec_commands(commands)
    if type(commands) == "string" then
        vim.api.nvim_command(commands)
        return
    end

    for _, command in pairs(commands) do
        vim.api.nvim_command(command)
    end
end

function common.open_folder(path)
    local Job = require("plenary.job")

    local job = Job:new({
        command = vim.fn.has("unix") and "xdg-open" or "start",
        args = {path}
    })

    job:start()
end

return common

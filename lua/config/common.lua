local Common = {
    buftype_blacklist = {
        -- "terminal",
        "gitcommit",
        "qf",
    },

    filetype_blacklist = {
        "help",
        "dashboard",
        "toggleterm",
        -- "NeogitStatus",
        "NeogitPopup",
        "NeogitCommitMessage",
        "gitcommit",
        -- "dap-repl",
        "qf"
    }
}

function Common.highlight(items, ns)
    for _, item in ipairs(items) do
        vim.api.nvim_set_hl(ns or 0, item[1], item[2])
    end
end

function Common.show_select(prompt, choices, mode)
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

function Common.wrap_fn(mod, fn)
    return string.format(":lua require('%s')['%s']()<CR>", mod, fn)
end

function Common.set_options(t, options)
    for k, v in pairs(options) do
        vim[t][k] = v
    end
end

function Common.exec_commands(commands)
    if type(commands) == "string" then
        vim.api.nvim_command(commands)
        return
    end

    for _, command in pairs(commands) do
        vim.api.nvim_command(command)
    end
end

function Common.open_folder(path)
    local Job = require("plenary.job")

    local job = Job:new({
        command = vim.fn.has("unix") and "xdg-open" or "start",
        args = { path }
    })

    job:start()
end

function Common.os_open(arg)
    arg = tostring(arg)

    local uname = vim.loop.os_uname().sysname
    local cmd = nil

    if uname == "Windows" then
        cmd = { command = "cmd", args = { "/c", "start", arg } }
    elseif uname == "Darwin" then
        cmd = { command = "open", args = { arg } }
    elseif uname == "Linux" then
        cmd = { command = "xdg-open", args = { arg } }
    else
        vim.notify("Unsupported Platform '" .. uname .. "'", "warn", { title = "OS Open" })
        return
    end

    require("plenary.job"):new({
        command = cmd.command,
        args = cmd.args,
    }):start()
end

function Common.is_layout_en()
    return vim.fn.trim(vim.fn.system("setxkbmap -query | grep layout | awk '{print $NF}'")) == "us"
end

function Common.get_filename(p)
    return vim.fn.fnamemodify(tostring(p), ":t")
end

function Common.get_pathname(p)
    local Path = require("plenary.path")
    local r = Path:new(p)

    if not r:is_dir() then
        return Common.get_filename(r:parent())
    end

    return Common.get_filename(r)
end

return Common

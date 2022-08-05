local function show_select(prompt, choices, mode)
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

local function wrap_fn(mod, fn)
    return string.format(":lua require('%s')['%s']()<CR>", mod, fn)
end

local function map(key, cmd, mode, options)
    local opts = {silent = true}

    if options then
        opts = vim.tbl_extend("force", opts, options)
    end

    vim.keymap.set(mode, key, cmd, opts)
end

local function map_fn(key, fn, options)
    map(key, wrap_fn(fn[1], fn[2]), options)
end

local function map_keys(keys)
    for _, key in ipairs(keys) do
        vim.api.nvim_set_keymap(unpack(key))
    end
end

local function set_options(t, options)
    for k, v in pairs(options) do
        vim[t][k] = v
    end
end

local function exec_commands(commands)
    if type(commands) == "string" then
        vim.api.nvim_command(commands)
        return
    end

    for _, command in pairs(commands) do
        vim.api.nvim_command(command)
    end
end

return {
    map = map,
    map_fn = map_fn,
    map_keys = map_keys,
    set_options = set_options,
    exec_commands = exec_commands,
    wrap_fn = wrap_fn,
    show_select = show_select
}

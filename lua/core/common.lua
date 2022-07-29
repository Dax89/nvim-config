local function merge_tables(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end

    return t1
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

local function wrap_fn(mod, name)
    return string.format(":lua require('%s')['%s']()<CR>", mod, name)
end

return {
    merge_tables = merge_tables,
    map_keys = map_keys,
    set_options = set_options,
    exec_commands = exec_commands,
    wrap_fn = wrap_fn
}

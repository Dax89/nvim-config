local Bookmarks = {
    FNV_OFFSET_BASIS = 2166136261,
    FNV_PRIME = 16777619,

    DISABLED_KEYS = {
        "a", "A", "c", "C", "D",
        "o", "O",
        "s", "S",
        "u", "U", "x",
        "v", "V",
    },

    bmfile = nil,
    selwinid = nil,
    selbufid = nil,
    bufid = nil,
    winid = nil,
    cwd = nil,
    items = {},
}

Bookmarks.fnv1a = function(str)
    local bit = require("bit")
    local hash = Bookmarks.FNV_OFFSET_BASIS

    for i = 1, #str do
        hash = hash * Bookmarks.FNV_PRIME
        hash = bit.bxor(hash, str:byte(i))
    end

    return hash
end

Bookmarks.load_current = function()
    local rootpath = vim.fn.stdpath("cache") .. "/bookmarks"

    if vim.fn.isdirectory(rootpath) == 0 then
        vim.fn.mkdir(rootpath, "p")
    end

    Bookmarks.cwd = vim.loop.cwd()
    Bookmarks.bmfile = rootpath .. "/" .. Bookmarks.fnv1a(Bookmarks.cwd)

    if vim.fn.filereadable(Bookmarks.bmfile) == 1 then
        local f = io.open(Bookmarks.bmfile)
        assert(f)
        local data = f:read("*a")
        f:close()

        Bookmarks.items = vim.json.decode(data)
    else
        Bookmarks.items = {}
    end
end

Bookmarks.get_lines = function()
    assert(Bookmarks.bufid)
    return vim.api.nvim_buf_get_lines(Bookmarks.bufid, 0, -1, false)
end

Bookmarks.set_lines = function(lines)
    assert(Bookmarks.bufid)
    vim.api.nvim_buf_set_lines(Bookmarks.bufid, 0, -1, false, lines)
end

Bookmarks.insert_line = function(index, line)
    local lines = Bookmarks.get_lines()
    table.insert(lines, index, line)
    Bookmarks.set_lines(lines)
end

Bookmarks.close_window = function(update)
    if update ~= false then
        local lines = vim.tbl_filter(function(x)
            return x ~= "" -- Filter empty lines
        end, Bookmarks.get_lines())

        lines = vim.tbl_map(function(x)
            return Bookmarks.absolute_path(x)
        end, lines)

        local done, newitems = {}, {}

        for _, l in ipairs(lines) do
            if vim.fn.filereadable(l) == 1 and not vim.tbl_contains(done, l) then
                for _, bi in ipairs(Bookmarks.items) do
                    if bi.file == l then
                        table.insert(newitems, bi)
                        table.insert(done, 1, bi.file)
                        break
                    end
                end
            end
        end

        if vim.tbl_isempty(Bookmarks.items) then
            os.remove(Bookmarks.bmfile)
        else
            local f = io.open(Bookmarks.bmfile, "w")
            assert(f)
            f:write(vim.json.encode(newitems))
            f:close()
        end
    end

    vim.api.nvim_win_close(Bookmarks.winid, { force = true })
    Bookmarks.winid = nil
end

Bookmarks.save_current = function()
    local name = vim.api.nvim_buf_get_name(Bookmarks.selbufid)

    if vim.fn.filereadable(name) ~= 0 then
        local row, col = unpack(vim.api.nvim_win_get_cursor(Bookmarks.selwinid))

        table.insert(Bookmarks.items, 1, {
            file = name,
            row = row,
            col = col,
        })

        Bookmarks.insert_line(1, Bookmarks.relative_path(name))
    end

    Bookmarks.close_window()
end

Bookmarks.relative_path = function(p)
    -- Ignore different paths
    if not vim.startswith(p, Bookmarks.cwd) then
        return p
    end

    local l = #Bookmarks.cwd
    p = p:sub(l + 1)

    while p:sub(1, 1) == "/" do
        p = p:sub(2)
    end

    return p
end

Bookmarks.absolute_path = function(p)
    local a = Bookmarks.cwd .. "/" .. p

    if vim.fn.filereadable(a) == 1 then
        return a
    end

    return p
end

Bookmarks.open_selected = function(r)
    if r == nil then
        local row, _ = unpack(vim.api.nvim_win_get_cursor(Bookmarks.winid))
        r = row
    end

    local lines = Bookmarks.get_lines()
    local selline = Bookmarks.absolute_path(lines[r])

    if vim.fn.filereadable(selline) then
        for _, bi in ipairs(Bookmarks.items) do
            if bi.file == selline then
                Bookmarks.close_window(false)
                vim.cmd(":edit " .. bi.file)
                vim.api.nvim_win_set_cursor(0, { bi.row, bi.col })
            end
        end
    end
end

Bookmarks.show = function()
    Bookmarks.selwinid = vim.api.nvim_get_current_win()
    Bookmarks.selbufid = vim.api.nvim_get_current_buf()

    if Bookmarks.bufid == nil then
        Bookmarks.bufid = vim.api.nvim_create_buf(false, true)

        local options = {
            buffer = Bookmarks.bufid,
            noremap = true,
            silent = true
        }

        -- Disable some keybinds
        for _, key in ipairs(Bookmarks.DISABLED_KEYS) do
            vim.keymap.set("n", key, "<NOP>", options)
        end

        vim.keymap.set("n", "<ESC>", Bookmarks.close_window, options)
        vim.keymap.set("n", "q", Bookmarks.close_window, options)
        vim.keymap.set("n", ";", Bookmarks.save_current, options)

        vim.keymap.set("n", "<CR>", function()
            Bookmarks.open_selected()
        end, options)

        for i = 1, 10 do
            vim.keymap.set("n", tostring(math.fmod(i, 10)), function()
                Bookmarks.open_selected(i)
            end, options)
        end

        vim.api.nvim_create_autocmd("BufLeave", {
            buffer = Bookmarks.bufid,
            desc = "Bookmarks - Save on leave",
            callback = Bookmarks.close_window
        })
    end

    Bookmarks.load_current()

    local lines = vim.tbl_map(function(x)
        return Bookmarks.relative_path(x.file)
    end, Bookmarks.items)

    Bookmarks.set_lines(lines)

    local width = math.min(80, vim.fn.winwidth(0) - 4)
    local height = math.min(20, #lines + 2)
    local row = math.ceil((vim.o.lines - height) / 2)
    local col = math.ceil((vim.o.columns - width) / 2)
    local Common = require("config.common")

    Bookmarks.winid = vim.api.nvim_open_win(Bookmarks.bufid, true, {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        focusable = true,
        border = "rounded",
        title = string.format("   %s ", Common.get_filename(Bookmarks.cwd))
    })

    vim.api.nvim_win_set_option(Bookmarks.winid, "number", true)
end

vim.keymap.set("n", ";", Bookmarks.show, {
    noremap = true,
    silent = true,
    desc = "Bookmarks - Show",
})

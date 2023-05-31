local datetime = require("utils.datetime")

local function generate_calendar_month(bufid)
    local now = datetime.now()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = vim.api.nvim_buf_get_lines(bufid, 0, -1, true)
    local calendar = { }

    datetime.iterate(datetime.new(now.year, now.month), function(date)
        if date.month ~= now.month then return false end

        table.insert(calendar, string.format("- %s %04d-%02d-%02d %s",
                                             date.weekname,
                                             date.year,
                                             date.month,
                                             date.day,
                                             datetime.is_weekend(date) and ":weekend: " or " "))
        return true
    end)

    local newlines = vim.list_slice(lines, 0, row)
    vim.list_extend(newlines, calendar)
    vim.list_extend(newlines, lines, row + 1)
    vim.api.nvim_buf_set_lines(bufid, 0, -1, true, newlines)
end

vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "vimwiki",
    callback = function(arg)
        local map = function(k, cb)
            vim.keymap.set("n", k, cb, {buffer = arg.buf, silent = true})
        end

        map("<leader>Wcm", function() generate_calendar_month(arg.buf) end)
    end
})

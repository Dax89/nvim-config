local jq = setmetatable({
    editors = {}, -- One jq-editor for every json-buffer
    lastbuf = nil,
    outputbuf = nil,
    editorwin = nil,
}, {
    __call = function(self, buf, q, options)
        q = vim.trim(q)
        if q == "" then return "" end

        options = vim.F.if_nil(options, {})
        local json = self.read_buffer(buf)
        local out, err, code = {}, {}, -1

        local joboptions = {
            stdin = "pipe",
            on_exit = function(_, c, _) code = c end,
            on_stdout = function(_, data, _) vim.list_extend(out, data) end,
            on_stderr = function(_, data, _) vim.list_extend(err, data) end
        }

        local jobid = vim.fn.jobstart({ "jq", "-C", q }, joboptions)
        vim.fn.chansend(jobid, json)
        vim.fn.chanclose(jobid, "stdin")
        vim.fn.jobwait({ jobid })

        local res = code ~= 0 and err or out

        if options.join == true then
            return table.concat(res, "\r\n")
        end

        return res
    end
})

function jq.read_buffer(id, lines)
    local buflines = vim.api.nvim_buf_get_lines(id, 0, -1, false)

    if lines ~= true then
        buflines = table.concat(buflines, '\n')
    end

    return buflines
end

function jq.create_buffer(name, filetype)
    local id = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(id, name)

    if filetype then
        vim.api.nvim_buf_set_option(id, "filetype", filetype)
    end

    return id
end

function jq.open_output(text)
    if text == "" then return end

    if jq.outputbuf then
        vim.api.nvim_buf_delete(jq.outputbuf, { force = true })
    end

    -- NOTE: Always discard the old terminal-buffer
    jq.outputbuf = jq.create_buffer("JQ Output")
    local chanid = vim.api.nvim_open_term(jq.outputbuf, {})
    vim.api.nvim_command("botright vsplit")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(win, "relativenumber", false)
    vim.api.nvim_win_set_option(win, "number", false)
    vim.api.nvim_command("wincmd p")
    vim.api.nvim_win_set_buf(win, jq.outputbuf)
    vim.api.nvim_chan_send(chanid, text)
end

function jq.open_editor(buf)
    if jq.lastbuf ~= nil and buf ~= jq.lastbuf and jq.editors[jq.lastbuf] then
        vim.api.nvim_buf_set_option(jq.editors[jq.lastbuf], "bufhidden", "hide")
    end

    jq.lastbuf = buf

    if not jq.editors[buf] then
        local editorname = "JQ Editor"
        local name = vim.api.nvim_buf_get_name(buf)
        if name ~= "" then editorname = editorname .. " — " .. name end

        jq.editors[buf] = jq.create_buffer(editorname, "jq")

        vim.api.nvim_buf_create_user_command(jq.editors[buf], "JqRun", function()
            local query = jq.read_buffer(jq.editors[buf])
            jq.open_output(jq(buf, query, { join = true }))
        end, { desc = "JSON = Run Query" })

        vim.keymap.set("n", "<F12>", function() vim.cmd("JqRun") end,
            { buffer = jq.editors[buf], desc = "JSON - RunQuery" })
    end

    if vim.fn.getbufinfo(jq.editors[buf])[1].hidden == 1 then
        if jq.editorwin ~= nil and vim.api.nvim_win_is_valid(jq.editorwin) then
            pcall(vim.api.nvim_win_close, jq.editorwin, true)
            jq.editorwin = nil
        end

        vim.api.nvim_command("belowright split")
        jq.editorwin = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(jq.editorwin, jq.editors[buf])
    end
end

if vim.fn.executable("jq") then
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "json",
        callback = function(arg)
            -- Make sure to clean up associated windows
            vim.api.nvim_create_autocmd("BufHidden", {
                buffer = arg.buf,
                callback = function()
                    if not jq.editors[arg.buf] then return end

                    vim.api.nvim_buf_delete(jq.editors[arg.buf], { force = true })
                    jq.editors[arg.buf] = nil
                    jq.editorwin = nil

                    if vim.tbl_isempty(jq.editors) and jq.outputbuf ~= nil then
                        vim.api.nvim_buf_delete(jq.outputbuf, { force = true })
                        jq.outputbuf = nil
                    end
                end
            })

            vim.api.nvim_buf_create_user_command(arg.buf, "JqFormat", function()
                vim.api.nvim_command(":%!jq")
            end, { desc = "JSON - Format" })

            vim.api.nvim_buf_create_user_command(arg.buf, "JqQuery", function()
                jq.open_editor(arg.buf)
            end, { desc = "JSON - Query" })

            vim.keymap.set("n", "<F10>", function() vim.cmd("JqFormat") end,
                { buffer = arg.buf, desc = "JSON - Format" })
            vim.keymap.set("n", "<F11>", function() vim.api.nvim_command("JqQuery") end,
                { buffer = arg.buf, desc = "JSON - Query" })
        end
    })
end

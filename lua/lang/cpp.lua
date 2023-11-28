-- https://neovim.io/doc/user/lsp.html#vim.lsp.client
-- https://neovim.io/doc/user/treesitter.html#TSNode

local parsers = {}
local snippets = {}
local treesitter = vim.treesitter

local function find_named_child(tsnode, names)
    if type(names) ~= "table" then
        names = { names }
    end

    local c = tsnode:named_child_count()
    local res = {}

    for i = 0, c - 1 do
        local n = tsnode:named_child(i)
        if vim.tbl_contains(names, n:type()) then
            table.insert(res, n)
        end
    end

    return res
end

local function get_identifier(tsnode)
    if vim.tbl_contains({ "class_specifier", "struct_specifier" }, tsnode:type()) then
        return get_identifier(tsnode:field("name")[1])
    elseif tsnode:type() == "function_declarator" then
        return get_identifier(tsnode:field("declarator")[1])
    elseif vim.endswith(tsnode:type(), "parameter_declaration") then
        local t = get_identifier(tsnode:field("type")[1])
        local n = get_identifier(tsnode:field("declarator")[1])
        local q = find_named_child(tsnode, "type_qualifier")

        if vim.tbl_isempty(q) then
            return string.format("%s %s", t, n)
        else
            return string.format("%s %s %s", get_identifier(q[1]), t, n)
        end
    end

    return treesitter.get_node_text(tsnode, 0)
end

local function insert_function(tsnode, bufnr, owner)
    local line = tsnode:start() + 1

    if not parsers[bufnr].nodes[line] then
        parsers[bufnr].nodes[line] = {}
    end

    table.insert(parsers[bufnr].nodes[line], {
        node = tsnode,
        owner = owner
    })
end

local function parse(tsnode, bufnr, parent)
    if tsnode:type() == "namespace_definition" then
        local body = tsnode:field("body")
        if not vim.tbl_isempty(body) then
            for n in body[1]:iter_children() do
                parse(n, bufnr, tsnode)
            end
        end
    elseif vim.tbl_contains({ "class_specifier", "struct_specifier" }, tsnode:type()) then
        local body = tsnode:field("body")
        if not vim.tbl_isempty(body) then
            for n in body[1]:iter_children() do
                parse(n, bufnr, tsnode)
            end
        end
    elseif vim.tbl_contains({ "declaration", "function_declaration", "function_definition", "field_declaration" }, tsnode:type()) then
        local decl = tsnode:field("declarator")

        if not vim.tbl_isempty(decl) and decl[1]:type() == "pointer_declarator" then
            decl = decl[1]:field("declarator")
        end

        if not vim.tbl_isempty(decl) and decl[1]:type() == "function_declarator" then
            insert_function(tsnode, bufnr, parent)
        end
    end
end

local function parse_buffer()
    local bufnr = vim.api.nvim_get_current_buf()

    if not parsers[bufnr] then
        local ok, p = pcall(treesitter.get_parser, bufnr)
        if not ok then return end
        parsers[bufnr] = { parser = p }
    end

    parsers[bufnr].nodes = {}

    local tree = parsers[bufnr].parser:parse()[1]
    local root = tree:root()

    for tsnode in root:iter_children() do
        parse(tsnode, bufnr)
    end

    return parsers[bufnr].nodes
end

local function find_function(functions, line, col)
    local items = functions[line]
    if not items or vim.tbl_isempty(items) then return nil end

    local found = items[1]

    for _, item in ipairs(items) do
        local _, c, _ = item.node:start()
        if c > col then
            break
        end

        found = item
    end

    return found
end

local function generate_prototype(tsnode, owner)
    if tsnode:type() == "pointer_declarator" then
        return "* " .. generate_prototype(tsnode:field("declarator")[1], owner)
    elseif tsnode:type() == "function_declarator" then
        local name

        if tsnode:parent() and tsnode:parent():type() == "function_definition" and not owner then
            local decl = tsnode:field("declarator")[1]

            if decl:type() == "qualified_identifier" then
                name = get_identifier(decl:field("name")[1])
            else
                name = get_identifier(decl)
            end
        else
            name = get_identifier(tsnode)
        end

        local params = {}

        for p in tsnode:field("parameters")[1]:iter_children() do
            if vim.endswith(p:type(), "parameter_declaration") then
                table.insert(params, get_identifier(p))
            end
        end

        local proto = string.format("%s(%s)", name, table.concat(params, ", "))

        if tsnode:parent():type() ~= "function_definition" and owner and owner:type() ~= "namespace_definition" then
            local ownername = get_identifier(owner)
            proto = string.format("%s::%s", ownername, proto)
        end

        local q = find_named_child(tsnode, "type_qualifier")

        if not vim.tbl_isempty(q) then
            proto = string.format("%s %s", proto, get_identifier(q[1]))
        end

        return proto
    elseif tsnode:type() == "function_definition" or vim.endswith(tsnode:type(), "declaration") then
        local t = tsnode:field("type")

        if vim.tbl_isempty(t) then
            return generate_prototype(tsnode:field("declarator")[1], owner)
        else
            local ret = get_identifier(t[1])
            local proto = generate_prototype(tsnode:field("declarator")[1], owner)

            if vim.startswith(proto, "*") then
                return ret .. proto
            end

            return string.format("%s %s", ret, proto)
        end
    end

    error("Unhandled node type '" .. tsnode:type() .. "'")
end

local function extract_function()
    local functions = parse_buffer()
    local selstart = vim.fn.getpos("v")
    local selend = vim.fn.getpos(".")
    local nlines = math.abs(selend[2] - selstart[2]) + 1
    local newsnippets = {}

    for i = 1, nlines do
        local f = find_function(functions, selstart[2] + i - 1, (i == 1 and selstart[3] or selend[3]) - 1)

        if f then
            local snip = generate_prototype(f.node, f.owner)

            if vim.endswith(f.node:type(), "declaration") then
                snip = string.format("%s {\r}\r", snip)
            else
                snip = snip .. ";"
            end

            table.insert(newsnippets, snip)
        end
    end

    if vim.api.nvim_get_mode().mode ~= "n" then
        vim.api.nvim_input("<esc>") -- Return to normal mode
    end

    if not vim.tbl_isempty(newsnippets) then
        vim.notify(string.format("Generated %d function(s)", #newsnippets))
    end

    snippets = newsnippets
end

local function insert_snippet()
    if vim.tbl_isempty(snippets) then
        return
    end

    local lines = {}

    for _, snip in ipairs(snippets) do
        vim.list_extend(lines, vim.split(snip, "\r"))
    end

    vim.api.nvim_put(lines, "l", true, false)
    snippets = {}
end

vim.keymap.set({ "n", "v" }, "<leader>tc", function()
        if vim.bo.filetype == "cpp" then
            extract_function()
        end
    end,
    { desc = "TreeSitter - Generate C++ Code" })

vim.keymap.set({ "n", "v" }, "<leader>tC", function()
        if vim.bo.filetype == "cpp" then
            insert_snippet()
        end
    end,
    { desc = "TreeSitter - Apply Generated C++ Code" })

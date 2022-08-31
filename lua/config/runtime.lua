local M = {}

function M.init()
    if not _G.cfgrt then
        _G.cfgrt = { }
    end
end

function M.get(k)
    return _G.cfgrt[k]
end

function M.set(k, v)
    _G.cfgrt[k] = v
end

function M.del(k)
    _G.cfgrt[k] = nil
end

return M

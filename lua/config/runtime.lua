local M = {}

M.init = function()
    if not _G.cfgrt then
        _G.cfgrt = { }
    end
end

M.get = function(k)
    return _G.cfgrt[k]
end

M.set = function(k, v)
    _G.cfgrt[k] = v
end

M.del = function(k)
    _G.cfgrt[k] = nil
end

return M

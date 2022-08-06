return {
    init = function()
        if not _G.cfgrt then
            _G.cfgrt = { }
        end
    end,
    get = function(k)
        return _G.cfgrt[k]
    end,
    set = function(k, v)
        _G.cfgrt[k] = v
    end,
    del = function(k)
        _G.cfgrt[k] = nil
    end
}

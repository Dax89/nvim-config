local common = require("config.common")

local function check_project_action(option, cb)
    local ok, ft = pcall(require, "config.filetype." .. vim.bo.filetype)

    if ok and ft then
        if option and not ft[option] then
            return
        end

        cb(ft)
    end
end

local M = {}

M.select_language = function()
    common.show_select("Language", {
        {"C/C++", ":CMake create_project"}
    })
end

M.settings = function()
    check_project_action("settings", function(ft)
        common.show_select("Project Settings", ft.settings)
    end)
end

M.cancel = function()
    check_project_action("cancel", function(ft)
        ft.cancel()
    end)
end

M.build = function()
    check_project_action("build", function(ft)
        ft.build()
    end)
end

M.run = function()
    check_project_action("run", function(ft)
        ft.run()
    end)
end

M.debug = function()
    local dap = require("dap")

    if #dap.status() > 0 then
        dap.continue()
    else
        check_project_action("debug", function(ft)
            ft.debug()
        end)
    end
end

return M

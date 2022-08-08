local common = require("core.common")

local function check_project_action(option, cb)
    local ok, ft = pcall(require, "config.filetype." .. vim.bo.filetype)

    if ok and ft then
        if option and not ft[option] then
            return
        end

        cb(ft)
    end
end

return {
    select_language = function()
        common.show_select("Language", {
            {"C/C++", ":CMake create_project"}
        })
    end,

    settings = function()
        check_project_action("settings", function(ft)
            common.show_select("Project Settings", ft.settings)
        end)
    end,

    build = function()
        check_project_action("build", function(ft)
            ft.build()
        end)
    end,

    run = function()
        check_project_action("run", function(ft)
            ft.run()
        end)
    end,

    debug = function()
        local dap = require("dap")

        if #dap.status() > 0 then
            dap.continue()
        else
            check_project_action("debug", function(ft)
                ft.debug()
            end)
        end
    end
}

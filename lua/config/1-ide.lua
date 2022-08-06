local common = require("core.common")
local ideproject = require("config.ide.project")

local function debug_project()
    local dap = require("dap")

    if #dap.status() > 0 then
        dap.continue()
    else
        ideproject.debug()
    end
end

local function step_into()
    local dap = require("dap")

    if #dap.status() > 0 then
        dap.step_into()
    end
end

local function run_or_stepover()
    local dap = require("dap")

    if #dap.status() > 0 then
        dap.step_over()
    else
        ideproject.run()
    end
end

local function stop_debug()
    local dap = require("dap")

    if #dap.status() > 0 then
        dap.disconnect()
    end
end

common.map("<F5>", debug_project, "n")
common.map("<F7>", step_into, "n")
common.map("<F8>", run_or_stepover, "n")
common.map("<A-F5>", stop_debug, "n")
common.map("<C-F5>", ideproject.run, "n")
common.map("<C-F8>", ideproject.settings, "n")

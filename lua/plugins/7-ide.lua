local Path = require("plenary.path")

local DAP_BASEPATH = Path:new(vim.fn.stdpath("data"), "/mason/bin")

require("ide").setup({
    debug = true,

    mappings = {
        ["<F5>"] = function(project)
            if project:is_busy() and not project:has_state("debug") then
                return
            end

            project:debug()
        end,

        ["<F7>"] = function(project)
            if project:has_state("debug") then
                project:debug({type = "stepinto"})
            else
                vim.api.nvim_command(":NeoTreeShowToggle")
            end
        end,

        ["<F8>"] = function(project)
            if project:has_state("debug") then
                project:debug({type = "stepover"})
            else
                project:build()
            end
        end,

        ["<C-F5>"] = function(project)
            if not project:has_state("run") then
                project:run()
            end
        end,

        ["<C-F8>"] = function(project)
            project:settings()
        end,

        ["<A-F5>"] = function(project)
            if project:has_state("debug") then
                project:debug({type = "stop"})
            end
        end,

        ["<A-BS>"] = function(project)
            if project:is_busy() and not project:has_state("debug") then
                project:stop()
            end
        end
    },

    integrations = {
        dap = {
            enable = true,

            config = {
                adapters = {
                    codelldb = {
                        type = "server",
                        port = 8990,

                        executable = {
                            command = tostring(Path:new(DAP_BASEPATH, "codelldb")),
                            args = {"--port", "8990"}
                        }
                    }
                }
            }
        },

        dapui = { enable = true },
        git = { enable = true }
    }
})

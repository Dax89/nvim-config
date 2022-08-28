local Path = require("plenary.path")

require("cmake").setup({
    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), "Programmazione", "Progetti")),
    build_dir = tostring(Path:new("{cwd}", "build", "{build_type}")),
    dap_configuration = { type = "codelldb" },
})

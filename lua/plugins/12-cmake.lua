local Path = require("plenary.path")

require("cmake").setup({
    build_dir = tostring(Path:new("{cwd}", "build", "{build_type}"))
})

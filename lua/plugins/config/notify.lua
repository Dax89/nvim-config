local notify = require("notify")

notify.setup({
    stages = "static",
    top_down = false,
    timeout = 2000,
    fps = 60,
})

vim.notify = notify

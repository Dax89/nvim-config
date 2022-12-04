local filebrowser = require("telescope").load_extension("file_browser")
require("telescope.builtin").file_browser = filebrowser.file_browser -- FIXME: File browser workaround


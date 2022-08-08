local common = require("core.common")

local function show_general_settings()
    common.show_select("Quick Actions", {
        {" Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k"},
        {" Sync Plugins", ":PackerSync"},
        {"↺ Restart LSP", ":LspRestart"},
        {"! Mason", ":Mason"},
        {"⚙ Commands", function() require("telescope.builtin").commands() end}
    })
end

return {
    show_general_settings = show_general_settings
}

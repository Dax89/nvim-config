local common = require("core.common")

local function show_general_settings()
    common.show_select("Quick Actions", {
        {" Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd"},
        {" Sync Plugins", ":PackerSync"},
        {"! Mason", ":Mason"},
        {"⚙ Commands", function() require("telescope.builtin").commands() end}
    })
end

common.map("<A-p>", show_general_settings, "n")

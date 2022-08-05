local common = require("core.common")

local function show_packer()
    local COMMANDS = {
        {" Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd"},
        {" Sync Plugins", ":PackerSync"},
        {"! Mason", ":Mason"},
        {"⚙ Commands", ":lua require('telescope.builtin').commands()"},
    }

    common.show_select("Quick Actions", COMMANDS)
end

common.map("<A-p>", show_packer, "n")

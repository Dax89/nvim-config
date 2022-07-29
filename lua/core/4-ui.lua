local common = require("core.common")

local function show_packer()
    vim.ui.select(
    {"⚙ Commands", " Settings", " Sync Plugins", "✘ Clean Plugins", "♥ NVIM", "ǃ LSP Servers"},
    { prompt = "Manage Packer" },
    function(_, idx)
        local act = ({
            [1] = function() vim.api.nvim_command(":lua require('telescope.builtin').commands()") end,
            [2] = function() vim.api.nvim_command(":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd") end,
            [3] = function() vim.api.nvim_command(":PackerSync") end,
            [4] = function() vim.api.nvim_command(":PackerClean") end,
            [5] = function() vim.api.nvim_command(":checkhealth") end,
            [6] = function() vim.api.nvim_command(":LspInstallInfo") end,
        })[idx]

        if act then
            act()
        end
    end)
end

common.map_keys({
    {"n", "<A-p>", common.wrap_fn("core.4-ui", "show_packer"), {noremap = true}}
})

return {show_packer = show_packer}

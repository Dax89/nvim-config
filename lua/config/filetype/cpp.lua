local function get_number_of_cores()
    return #vim.tbl_keys(vim.loop.cpu_info())
end

local M = {}

M.settings = {
    {"Configure", ":CMake configure"},
    {"Select Target", ":CMake select_target"},
    {"Select Build Type", ":CMake select_build_type"},
    {"Set Target Arguments", ":CMake set_target_args"},
    {"Open Build Dir", ":CMake open_build_dir"},
    {"Clean", ":CMake clean"},
}

M.debug = function()
    vim.api.nvim_command(string.format(":CMake build_and_debug -j %d", get_number_of_cores()))
end

M.cancel = function()
    vim.api.nvim_command(":CMake cancel")
end

M.build = function()
    vim.api.nvim_command(string.format(":CMake build_all -j %d", get_number_of_cores()))
end

M.run = function()
    vim.api.nvim_command(string.format(":CMake build_and_run -j %d", get_number_of_cores()))
end

return M

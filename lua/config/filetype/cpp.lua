return {
    settings = {
        {"Configure", ":CMake configure"},
        {"Select Target", ":CMake select_target"},
        {"Select Build Type", ":CMake select_build_type"},
        {"Open Build Dir", ":CMake open_build_dir"},
    },
    debug = function()
        vim.api.nvim_command(":CMake build_and_debug")
    end,
    build = function()
        vim.api.nvim_command(":CMake build_all")
    end,
    run = function()
        vim.api.nvim_command(":CMake build_and_run")
    end
}

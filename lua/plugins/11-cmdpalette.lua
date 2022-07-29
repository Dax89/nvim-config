require("telescope").setup({
    extensions = {
        command_palette = {
            {"C++",
                {"CMake - Debug", ":CMake debug"},
                {"CMake - Run", ":CMake run"},
                {"CMake - Build", ":CMake build_all"},
                {"CMake - Configure", ":CMake configure"},
                {"CMake - Select Target", ":CMake select_target"},
                {"CMake - Select Build Type", ":CMake select_build_type"},
            }
        }
    }
})

require("telescope").load_extension("command_palette")

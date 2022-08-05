local common = require("core.common")

common.map_fn("<F5>", {"config.ide.project", "debug"}, "n")
common.map_fn("<F8>", {"config.ide.project", "build"}, "n")
common.map_fn("<C-F5>", {"config.ide.project", "run"}, "n")
common.map_fn("<C-F8>", {"config.ide.project", "settings"}, "n")

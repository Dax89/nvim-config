local common = require("core.common")

require("searchbox").setup()

-- Find
common.map("/", function()
    require("searchbox").match_all({clear_matches = true})
end, "n")

common.map("/", function()
    require("searchbox").match_all({clear_matches = true, visual_mode = true})
end, "v")

-- Replace
common.map("&", function()
    require("searchbox").replace()
end, "n")

common.map("&", function()
    require("searchbox").replace()
end, "v")

local common = require("core.common")

require("hop").setup()

common.map(",f", function()
    require("hop").hint_words({direction = require"hop.hint".HintDirection.AFTER_CURSOR})
end, "n")

common.map(",F", function()
    require("hop").hint_words({direction = require("hop.hint").HintDirection.BEFORE_CURSOR})
end, "n")

(import-macros {: plugin-setup : nv-keys} "macros")

(plugin-setup hop setup)

(nv-keys 
  ("n" ",w" "<cmd>lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>" {:noremap true :silent true})
  ("n" ",W" "<cmd>lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>" {:noremap true :silent true})
  ;("n" "<Leader>f" "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = true})<cr>" {:noremap true :silent true}) 
  ;("n" "<Leader>F" "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = true})<cr>" {:noremap true :silent true})
  ;("n" "<Leader>t" "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = false})<cr>" {:noremap true :silent true}) 
  ;("n" "<Leader>T" "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = false})<cr>" {:noremap true :silent true})
)

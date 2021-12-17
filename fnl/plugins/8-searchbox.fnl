(import-macros {: plugin-setup : with-require : wrap-fn : nv-cmd : nv-keys} "macros")

(plugin-setup searchbox setup)

(nv-keys 
  ; Find
  ("n" "/" "<CMD>lua require('searchbox').match_all({clear_matches = true})<CR>"                           {:noremap true})
  ("v" "/" "y<ESC><CMD>lua require('searchbox').match_all({clear_matches = true, visual_mode = true})<CR>" {:noremap true})  
  
  ; Replace
  ("n" "&" "<CMD>lua require('searchbox').replace()<CR>" {:noremap true})
  ("v" "&" "<CMD>lua require('searchbox').replace()<CR>" {:noremap true}))

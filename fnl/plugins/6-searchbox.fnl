(import-macros {: plugin-setup : with-require : wrap-fn : nv-cmd : nv-keys} "macros")

(plugin-setup searchbox setup)

(nv-keys 
  ; Find
  ("n" "<C-f>"   "<CMD>lua require('searchbox').match_all({clear_matches = true})<CR>"                           {:noremap true})
  ("v" "<C-f>"   "y<ESC><CMD>lua require('searchbox').match_all({clear_matches = true, visual_mode = true})<CR>" {:noremap true})  
  
  ; Replace
  ("n" "<C-A-f>"   "<CMD>lua require('searchbox').replace()<CR>"                           {:noremap true}) 
  ("v" "<C-A-f>"   "y<ESC><CMD>lua require('searchbox').replace({visual_mode = true})<CR>" {:noremap true}))

(import-macros {: plugin-setup : with-require : wrap-fn : nv-cmd : nv-keys} "macros")

(plugin-setup searchbox setup)

(fn show-searchbox []
  (with-require ui 
                (ui.show-menu "SearchBox" [ "Find" "Replace"]
                              (lambda [item]
                                (match item._index
                                  1 (nv-cmd ":lua require('searchbox').match_all({clear_matches = true, visual_mode = true})")
                                  2 (nv-cmd ":lua require('searchbox').replace({visual_mode = true})"))))))

(nv-keys ("n" "<C-f>" (wrap-fn :plugins.6-searchbox show-searchbox) { :noremap true}))
(nv-keys ("v" "<C-f>" (wrap-fn :plugins.6-searchbox show-searchbox) { :noremap true}))

{: show-searchbox}

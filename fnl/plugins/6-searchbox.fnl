(import-macros {: plugin-setup : with-require : wrap-fn : nv-cmd : nv-keys} "macros")

(plugin-setup searchbox setup)

(fn show-searchbox [visual? reverse?]
  ;(var options { })

  ;(when (= visual? true)
    ;(set options.visual_mode true))

  ;(when (= reverse? true)
    ;(set options.reverse true))

  (with-require ui 
                (ui.show-menu "SearchBox" ["Find" "Replace"]
                              (lambda [item]
                                (match item._index
                                  1 (nv-cmd ":lua require('searchbox').match_all({clear_matches = true})")
                                  2 (nv-cmd ":lua require('searchbox').replace()"))))))
 
;(fn show-searchbox-v []
  ;(show-searchbox true))

;(fn show-searchbox-r []
  ;(show-searchbox false true))

;(fn show-searchbox-rv []
  ;(show-searchbox true true))

(nv-keys ("n" "<C-f>"   (wrap-fn :plugins.6-searchbox show-searchbox)    {:noremap true}))
;(nv-keys ("n" "<C-S-f>" (wrap-fn :plugins.6-searchbox show-searchbox-r)  {:noremap true}))
(nv-keys ("v" "<C-f>"   (wrap-fn :plugins.6-searchbox show-searchbox-v)  {:noremap true}))
;(nv-keys ("n" "<C-S-f>" (wrap-fn :plugins.6-searchbox show-searchbox-rv) {:noremap true}))

{: show-searchbox}

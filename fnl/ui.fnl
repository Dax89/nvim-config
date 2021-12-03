(import-macros {: with-require-as} "macros")

(fn create [type title options]
  (type {:border {:style "single"
                  :highlight "FloatBorder"
                  :text {:top title :top_align "left"}}
         :position "50%" } options))

(fn show-menu [title items ?onsubmit]
  (with-require-as m "nui.menu"
                   (local menu (create m title
                                       {:on_submit (or ?onsubmit nil)
                                        :lines (icollect [_ v (ipairs items)]
                                                         (if (= v "-") ; Check for separator
                                                           (values (m.separator))
                                                           (values (m.item v))))}))
                   (menu:mount)))

{: create
 : show-menu}

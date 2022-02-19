(import-macros {: nv-keys} "macros")

(nv-keys
  ; General
  ("n" "<Up>"      "<Nop>"     {:noremap true})
  ("n" "<Down>"    "<Nop>"     {:noremap true})
  ("n" "<Left>"    "<Nop>"     {:noremap true})
  ("n" "<Right>"   "<Nop>"     {:noremap true})
  ("n" "<Space>"   "<Nop>"     {:noremap true})
  ("n" "<F10>"     "zA"        {:noremap true})
  ("i" "<F10>"     "zA"        {:noremap true})
  ("o" "<F10>"     "zA"        {:noremap true})
  ("v" "<F10>"     "zA"        {:noremap true})
  ("n" "<Leader>a" "gg0VG"     {:noremap true})
  ("n" "<C-Tab>"   ":bn<CR>"   {:noremap true})
  ("n" "<C-S-Tab>" ":bp<CR>"   {:noremap true})
  
  ; Plugins
  ("n" "<A-Enter>" ":CodeActionMenu<CR>"       {:noremap true})
  ("n" "<F5>"      ":NvimTreeRefresh<CR>"      {:noremap true})
  ("n" "<F6>"      ":FloatermToggle<CR>"       {:noremap true})
  ("n" "<F7>"      ":NvimTreeToggle<CR>"       {:noremap true})
  ("n" "<F8>"      ":AerialToggle!<CR>"        {:noremap true})
  ("n" "<F9>"      ":LspTroubleToggle<CR>"     {:noremap true})
  ("n" "<C-p>"     ":Telescope find_files<CR>" {:noremap true})
  ("n" "<C-S-r>"   ":Telescope oldfiles<CR>"   {:noremap true}) 
  ("n" "<C-S-p>"   ":Telescope aerial<CR>"     {:noremap true})
  ("n" "<C-A-p>"   ":Telescope live_grep<CR>"  {:noremap true})

  ; Renamer
  ("i" "<F2>" "<CMD>lua require('renamer').rename()<CR>" {:noremap true :silent true}) 
  ("n" "<F2>" "<CMD>lua require('renamer').rename()<CR>" {:noremap true :silent true}) 
  ("v" "<F2>" "<CMD>lua require('renamer').rename()<CR>" {:noremap true :silent true}) 

  ; Terminal Commands
  ("t" "<F6>" "<C-\\><C-n>:FloatermToggle<CR>" {:noremap true}))

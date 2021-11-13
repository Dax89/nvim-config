(import-macros {: nv-keys } "macros")

(tset vim.g :bufferline {
  :animation true
  :auto_hide false
  :clickable true
  :closable true
  :icons true
  :icon_close_tab ""
  :icon_close_tab_modified "●"
  :icon_separator_active "▎"
  :icon_separator_inactive "▎"
  :letters "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP"
  :maximum_padding 1
  :semantic_letters true
  :tabpages true
})

(nv-keys
  ("n" "<Leader>1" ":BufferGoto 1<CR>" { :noremap true :silent true })
  ("n" "<Leader>2" ":BufferGoto 2<CR>" { :noremap true :silent true })
  ("n" "<Leader>3" ":BufferGoto 3<CR>" { :noremap true :silent true })
  ("n" "<Leader>4" ":BufferGoto 4<CR>" { :noremap true :silent true })
  ("n" "<Leader>5" ":BufferGoto 5<CR>" { :noremap true :silent true })
  ("n" "<Leader>6" ":BufferGoto 6<CR>" { :noremap true :silent true })
  ("n" "<Leader>7" ":BufferGoto 7<CR>" { :noremap true :silent true })
  ("n" "<Leader>8" ":BufferGoto 8<CR>" { :noremap true :silent true })
  ("n" "<Leader>9" ":BufferLast<CR>"   { :noremap true :silent true })
  ("n" "<Leader>-" ":BufferClose!<CR>" { :noremap true :silent true })
  ("n" "<Leader>+" ":enew<CR>"         { :noremap true :silent true })
  ("n" "<Leader>p" ":BufferPick<CR>"   { :noremap true :silent true }))


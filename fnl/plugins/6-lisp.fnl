(import-macros {: nv-opt : nv-cmd} "macros")

(nv-opt g
  :vlime_cl_use_terminal true
  :vlime_window_settings { :repl { :pos "botright" :vertical true }
                           :server { :pos "belowright" :size 5 }}
  nil)

(nv-cmd "autocmd BufNewFile,BufRead *.asd setfiletype lisp")

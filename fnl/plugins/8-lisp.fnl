(import-macros {: nv-opt : nv-cmd} "macros")

(nv-opt g
  ;:conjure#filetype#fennel "conjure.client.fennel.stdio" 
  ;:conjure#client#fennel#stdio#command "ls"

  :vlime_cl_use_terminal true
  :vlime_window_settings {:repl { :pos "botright" :vertical true}
                           :server { :pos "belowright" :size 5}}
  nil)

(nv-cmd "autocmd BufNewFile,BufRead *.asd setfiletype lisp")

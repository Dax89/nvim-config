(fn use-pkg [name options?]
  (if options?
    (do ; Workaround Fennel not liking mixed associative and sequential tables
      (table.insert options? name)
      `(use ,options?))
    `(use [,name])))

(fn nv-cmd [...]
  `(each [_# cmd# (ipairs [,...])]
     (vim.api.nvim_command cmd#)))

(fn nv-fn [name ...]
  `((. vim.fn ,(tostring name)) ,...))

(fn nv-api [name ...]
  `((. vim.api ,(tostring name)) ,...))

(fn nv-keys [...]
  (let [keys [...]]
    (icollect [i v (pairs keys)]
              (nv-api :nvim_set_keymap (unpack v)))))

(fn nv-opt [opt ...]
  `(let [options# [,...]]
     (for [i# 1 (length options#) 2]
       (let [k# (. options# i#) v# (. options# (+ i# 1))]
         (tset (. vim ,(tostring opt)) k# v#)))))

(fn with-require [name ...]
  `(let [,name (require ,(tostring name))]
     (do ,...)))

(fn with-require-as [altname name ...]
  `(let [,altname (require ,(tostring name))]
     (do ,...)))

(fn plugin-setup [name func ...]
  `(let [p# (require ,(tostring name))]
     ((. p# ,(tostring func)) ,...)))

(fn wrap-fn [mod name]
  (.. ":lua require('" mod "')['" (tostring name) "']()<CR>"))

{: use-pkg
 : nv-cmd
 : nv-keys
 : nv-fn
 : nv-opt
 : with-require
 : with-require-as
 : plugin-setup
 : wrap-fn}

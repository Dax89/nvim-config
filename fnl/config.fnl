(fn load-modules [p]
  (each [_ mod (ipairs (vim.fn.glob p nil true))]
    (require (string.gsub (mod:match ".+/fnl/(.+).fnl$") "/" "."))))

(macro get-config-path [p]
  `(.. (vim.fn.stdpath "config") ,p))

(macro load-config [p]
  `(load-modules (get-config-path ,p)))

(load-config "/fnl/*-*.fnl")
(load-config "/fnl/plugins/*-*.fnl")

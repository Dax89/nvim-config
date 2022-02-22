(import-macros {: nv-opt : nv-keys : with-require : nv-fn : plugin-setup} "macros")

(nv-opt g
        :completion_matching_strategy_list ["exact" "fuzzy"]
        :completion_matching_smart_case true
        nil)

; Custom LSP Callbacks
(fn setup-lsp-sumneko_lua [server]
  {
   :settings {
              :Lua {
                    :diagnostics {
                                  :globals ["vim"] ; Get the language server to recognize the `vim` global
                                  }
                    }
              }
   })

(fn lsp-onattach [client]
  (let [aerial (require "aerial") illuminate (require "illuminate")]
    (aerial.on_attach client)
    (illiminate.on_attach client)))

(fn setup-lspconfig-servers []
  (local customservers ["nimls"])
  (local lspconfig (require "lspconfig"))

  (each [_ name (ipairs customservers)]
    (let [server (. lspconfig name)]
      (server.setup {:on_attach lsp-onattach
                     :capabilities ((. (require :cmp_nvim_lsp) :update_capabilities) (vim.lsp.protocol.make_client_capabilities))}))))

(fn setup-lspinstaller-servers []
  (var servers ["pyright" "tsserver" "svelte" "sumneko_lua" "cmake" "clangd" "rust_analyzer" "zls"])

  (local lspinstaller (require :nvim-lsp-installer))
  (local utils (require "utils"))
  (var installedcount 0)

  (each [_ name (ipairs servers)]
    (do
      (local (ok server) (lspinstaller.get_server name))
      (when (and (= ok true) (= (server:is_installed) false))
        (do
          (print (.. "[nvim-lsp-installer]: Installing " name "..."))
          (server:install)
          (set installedcount (+ installedcount 1))))))

  (lspinstaller.on_server_ready (fn [server]
                                  (var opts {:on_attach lsp-onattach })

                                  (with-require lspconfig
                                                (local capabilities ((. (require :cmp_nvim_lsp) :update_capabilities) (vim.lsp.protocol.make_client_capabilities)))
                                                ((. (. lspconfig server.name) :setup) {: capabilities}))

                                  (match server.name
                                    "sumneko_lua" (set opts (utils.merge-tables opts (setup-lsp-sumneko_lua))))

                                  (server:setup opts)

                                  (when (> installedcount 0) ; Show LSP Installation Dialog
                                    (vim.api.nvim_command ":LspInstallInfo")))))

(setup-lspinstaller-servers)
(setup-lspconfig-servers)

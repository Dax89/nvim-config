(local gl (require :galaxyline))
(local gls gl.section)

(tset gl :short_line_list [:LuaTree :vista :dbui])

(local colors {
  :bg       "#282c34"
  :yellow   "#fabd2f"
  :cyan     "#008080"
  :darkblue "#081633"
  :green    "#afd700"
  :orange   "#FF8800"
  :purple   "#5d4d7a"
  :magenta  "#d16d9e"
  :grey     "#c0c0c0"
  :blue     "#0087d7"
  :red      "#ec5f67"
})

(fn buffer-not-empty []
  (if (not= (vim.fn.empty (vim.fn.expand "%:t")) 1)))

(tset gls.left 1 {
  :FirstElement {
    :provider (fn [] "▋")
    :highlight [colors.blue colors.yellow]
  }
})

(tset gls.left 2 {
  :ViMode {
      :provider (fn []
          (local alias {:n "NORMAL" :i "INSERT" :c "COMMAND" :V "VISUAL" "" "VISUAL"})
          (. alias (vim.fn.mode)))
      :separator ""
      :separator_highlight {
          colors.yellow
          (fn [] (if (buffer-not-empty) colors.purple colors.darkblue))
      }
      :highlight [colors.magenta colors.yellow "bold"]
    }
})

(local glpfi (require :galaxyline.provider_fileinfo))

(tset gls.left 3 {
  :FileIcon {
    :provider "FileIcon"
    :condition buffer-not-empty
    :highlight [glpfi.get_file_icon_color colors.darkblue]
  }
})

(tset gls.left 4 {
  :FileName {
      :provider ["FileName" "FileSize"]
      :condition buffer-not-empty
      :separator ""
      :separator_highlight [colors.purple colors.darkblue]
      :highlight [colors.magenta colors.darkblue]
  }
})

(tset gls.left 5 {
  :GitIcon {
    :provider (fn [] ("  "))
    :condition buffer-not-empty
    :highlight [colors.orange colors.purple]
  }
})

(tset gls.left 6 {
  :GitBranch {
    :provider "GitBranch"
    :condition buffer-not-empty
    :highlight [colors.grey colors.purple]
  }
})

(fn check-width [ ]
  (local squeeze_width (/ (vim.fn.winwidth 0) 2))
  (> squeeze_width 40))

(tset gls.left 7 {
  :DiffAdd {
    :provider "DiffAdd"
    :condition check-width
    :icon " "
    :highlight [colors.green colors.purple]
  }
})

(tset gls.left 8 {
  :DiffModified {
    :provider "DiffModified"
    :condition check-width
    :icon " "
    :highlight [colors.orange colors.purple]
  }
})

(tset gls.left 9 {
  :DiffRemove {
      :provider "DiffRemove"
      :condition check-width
      :icon " "
      :highlight [colors.red colors.purple]
  }
})

(tset gls.left 10 {
  :LeftEnd {
    :provider (fn [] "")
    :separator ""
    :separator_highlight [colors.purple colors.bg]
    :highlight [colors.purple colors.purple]
  }
})

(tset gls.left 11 {
  :DiagnosticError {
      :provider "DiagnosticError"
      :icon "  "
      :highlight [colors.red colors.bg]
  }
})

(tset gls.left 12 {
  :Space {
    :provider (fn [] " ")
  }
})

(tset gls.left 13 {
  :DiagnosticWarn {
      :provider "DiagnosticWarn"
      :icon "  "
      :highlight [colors.blue colors.bg]
  }
})

(tset gls.right 1 {
  :FileFormat {
    :provider "FileFormat"
    :separator ""
    :separator_highlight [colors.bg colors.purple]
    :highlight [colors.grey colors.purple]
  }
})

(tset gls.right 2 {
  :LineInfo {
    :provider "LineColumn"
    :separator " | "
    :separator_highlight [colors.darkblue colors.purple]
    :highlight [colors.grey colors.purple]
  }
})

(tset gls.right 3 {
  :PerCent {
    :provider "LinePercent"
    :separator ""
    :separator_highlight [colors.darkblue colors.purple]
    :highlight [colors.grey colors.darkblue]
  }
})

(tset gls.right 4 {
  :ScrollBar {
    :provider "ScrollBar"
    :highlight [colors.yellow colors.purple]
  }
})

(tset gls.short_line_left 1 {
  :BufferType {
    :provider "FileTypeName"
    :separator ""
    :separator_highlight [colors.purple colors.bg]
    :highlight [colors.grey colors.purple]
  }
})


(tset gls.short_line_right 1 {
  :BufferIcon {
    :provider "BufferIcon"
    :separator ""
    :separator_highlight [colors.purple colors.bg]
    :highlight [colors.grey colors.purple]
  }
})

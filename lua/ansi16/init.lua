local lush = require("lush")
local p = require("ansi16.palette")

-- Setup terminal colors
for i = 0, 15 do
    vim.g["terminal_color_" .. i] = p["color" .. i].hex
end

---@diagnostic disable: undefined-global
local colorscheme = lush(function(f)
    local sym = f.sym

    return {
        -- UI
        Normal { fg = p.color15, bg = p.color0 },
        EndOfBuffer { fg = p.color0 },
        Visual { fg = Normal.bg, bg = p.color15 },
        VisualNC { fg = Normal.bg, bg = p.color8 },
        Comment { fg = p.color8, italic = true },
        Title { fg = p.color2 },
        CursorLine { bg = p.chromealt },
        CursorColumn { CursorLine },
        LineNr { Normal },
        SignColumn { Normal },
        Cursor { fg = p.color0, bg = p.color15 },
        CursorLineNr { fg = p.color11, bg = CursorLine.bg, bold = true },
        StatusLine { fg = p.color15, bg = p.chrome },
        StatusLineNC { fg = p.color8, bg = p.chrome },
        Conceal { StatusLine },
        Folded { bg = p.chrome },
        TabLine { fg = p.color7, bg = p.chromealt },
        TabLineFill { bg = p.chrome },
        TabLineSel { fg = p.color0, bg = p.color2, bold = true },
        Pmenu { Normal },
        PmenuSel { fg = Normal.bg, bg = p.color4, bold = true },
        PmenuSbar { fg = Normal.fg, bg = p.chromealt },
        PmenuThumb { fg = Normal.fg, bg = p.color8 },
        ModeMsg { fg = p.color4 },
        MoreMsg { fg = p.color12 },
        NormalFloat { Normal },
        FloatBorder { NormalFloat },

        -- Overlay
        NonText { fg = p.color8 },
        Search { fg = Normal.bg, bg = p.color11 },
        IncSearch { fg = Normal.bg, bg = p.color3 },
        Substitute { IncSearch },
        Question { fg = p.color12 },
        Todo { fg = Normal.bg, bg = p.color2, bold = true },
        Underlined { fg = p.color5, underline = true },
        DiffAdd { fg = p.color2 },
        DiffChange { fg = p.color3 },
        DiffDelete { fg = p.color1 },
        DiffText { fg = p.color4 },
        SpellBad { sp = p.color1, undercurl = true },
        SpellCap { sp = p.color3, undercurl = true },
        SpellLocal { sp = p.color2, undercurl = true },
        SpellRare { sp = p.color4, undercurl = true },
        Error { fg = p.color1 },
        ErrorMsg { Error },
        WarningMsg { fg = p.color11 },

        -- Generic Syntax
        PreProc { fg = p.color9 },
        Statement { fg = p.color10 },
        Identifier { fg = p.color15 },
        Constant { fg = p.color3 },
        Keyword { Statement, bold = true },
        Special { fg = p.color7 },
        Operator { fg = p.color7 },
        Type { fg = p.color12 },
        String { fg = p.color2 },
        Number { fg = p.color3 },
        Character { String },
        MatchParen { fg = p.color11, bold = true },
        Function { fg = p.color6 },
        Directory { fg = p.color12 },
        QuickFixLine { CursorLine },
        qfLineNr { fg = p.color10 },
        gitCommitSummary { fg = Normal.fg },

        -- Diagnostic
        DiagnosticDeprecated { fg = Comment.fg, strikethrough = true },
        DiagnosticHint { fg = p.color14, italic = true },
        DiagnosticInfo { fg = p.color12, italic = true },
        DiagnosticOk { fg = p.color10, italic = true },
        DiagnosticWarn { WarningMsg, italic = true },
        DiagnosticError { ErrorMsg, italic = true },
        DiagnosticUnderlineHint { sp = DiagnosticHint.fg, underline = true },
        DiagnosticUnderlineInfo { sp = DiagnosticInfo.fg, underline = true },
        DiagnosticUnderlineOk { sp = DiagnosticOk.fg, underline = true },
        DiagnosticUnderlineWarn { sp = DiagnosticWarn.fg, underline = true },
        DiagnosticUnderlineError { sp = DiagnosticWarn.fg, underline = true },

        -- TreeSitter
        sym("@function.builtin") { Function, bold = true },
        sym("@function.call") { italic = true },
        sym("@type.builtin") { Keyword },
        sym("@constant.builtin") { Constant, bold = true },
        sym("@variable") { fg = p.color13 },
        sym("@variable.builtin") { fg = p.color1, bold = true },
        sym("@variable.parameter") { fg = p.color5, italic = true },
        sym("@module") { fg = p.color4 },
        sym("@string") { String },
        sym("@keyword.storage") { fg = p.color10, bold = false },
        sym("@type.qualifier") { sym("@keyword.storage") },
        sym("@property") { sym("@variable") },

        -- TreeSitter `json`
        sym("@property.json") { PreProc },

        -- TreeSitter `css`
        sym("@property.css") { PreProc },

        -- TreeSitter `Forth`
        sym("forthColonDef") { Function },
        sym("forthAdrArith") { sym("@variable") },
        sym("forthStack") { Type },

        -- TreeSitter `CMake`
        sym("cmakeVariable") { sym("@variable") },
        sym("cmakeGeneratorExpression") { sym("@variable") },
        sym("cmakeGeneratorExpressions") { Constant },
        sym("cmakeKWExternalProject") { Constant },
        sym("cmakeKWinstall_programs") { Constant },
        sym("cmakeKWtarget_include_directories") { Constant },
        sym("cmakeKWtarget_link_libraries") { Constant },
        sym("cmakeKWget_filename_component") { Constant },
        sym("cmakeKWcmake_language") { Constant },
        sym("cmakeKWwrite_basic_package_version_file") { Constant },
        sym("cmakeKWset_tests_properties") { Constant },
        sym("cmakeKWget_cmake_property") { Constant },
        sym("cmakeKWctest_configure") { Constant },
        sym("cmakeKWadd_custom_target") { Constant },
        sym("cmakeKWqt_wrap_cpp") { Constant },
        sym("cmakeKWvariable_watch") { Constant },
        sym("cmakeKWtarget_sources") { Constant },
        sym("cmakeKWadd_library") { Constant },
        sym("cmakeKWsource_group") { Constant },
        sym("cmakeKWconfigure_file") { Constant },
        sym("cmakeKWtry_compile") { Constant },
        sym("cmakeKWtry_run") { Constant },
        sym("cmakeKWset_property") { Constant },
        sym("cmakeKWfind_program") { Constant },
        sym("cmakeKWfind_package") { Constant },
        sym("cmakeKWFetchContent") { Constant },
        sym("cmakeKWwrite_file") { Constant },
        sym("cmakeKWadd_test") { Constant },
        sym("cmakeKWproject") { Constant },
        sym("cmakeKWmessage") { Constant },
        sym("cmakeKWinstall") { Constant },
        sym("cmakeKWstring") { Constant },
        sym("cmakeKWunset") { Constant },
        sym("cmakeKWfile") { Constant },
        sym("cmakeKWif") { Constant },
        sym("cmakeKWset") { String },

        -- TreeSitter `Lisp`
        sym("lispKey") { Constant },
        sym("lispSymbol") { sym("@variable") },
        sym("lispFunc") { Function },
        sym("lispEscapeSpecial") { PreProc },

        -- TreeSitter `TCL`
        sym("tclVarRef") { sym("@variable") },

        -- LSP
        LspSignatureActiveParameter { sp = p.color15, bold = true, underline = true },
        sym("@lsp.type.variable") {},
        sym("@lsp.type.property") {},
        sym("@lsp.type.parameter") { sym("@variable.parameter") },
        sym("@lsp.type.namespace") {},
        sym("@lsp.type.module") {},
        sym("@lsp.typemod.function.defaultLibrary") { sym("@function.builtin") },
        sym("@lsp.typemod.variable.usedAsMutableReference") { fg = p.color5, italic = true, },
        sym("@lsp.typemod.variable.injected") { sym("@variable") },
        sym("@lsp.typemod.string.injected") { sym("@string") },
        sym("@lsp.typemod.parameter.readonly") { Constant },
        sym("@lsp.typemod.variable.readonly") { Constant },
        sym("@lsp.type.modifier") { Keyword },
        sym("@lsp.type.macro") { PreProc },

        -- LSP `Lua`
        sym("@lsp.type.property.lua") { sym("@variable") },

        -- nvim-telescope/telescope.nvim
        TelescopeSelection { CursorLine },

        -- nvimdev/dashboard-nvim
        DashboardHeader { fg = p.color2 },
        DashboardFooter { fg = p.color12 },

        -- NeogitOrg/neogit
        NeogitChangeAdded { DiffAdd, bold = true, italic = true },
        NeogitChangeBothModified { DiffChange, bold = true, italic = true },
        NeogitChangeCopied { fg = groups.git_untracked, bold = true, italic = true },
        NeogitChangeDeleted { DiffDelete, bold = true, italic = true },
        NeogitChangeModified { DiffChange, bold = true, italic = true },
        NeogitChangeNewFile { DiffAdd, bold = true, italic = true },
        NeogitChangeRenamed { fg = p.color12, bold = true, italic = true },
        NeogitChangeUpdated { DiffChange, bold = true, italic = true },
        NeogitSectionHeader { fg = p.color10, bold = true },
        NeogitFilePath { fg = p.color1 },
        NeogitObjectId { fg = p.color5 },
        NeogitBranch { fg = p.color4, bold = true },
        NeogitRemote { fg = p.color2, bold = true },
        NeogitHunkHeaderHighlight { fg = Normal.bg, bg = p.color4 },
        NeogitDiffAddHighlight { DiffAdd },
        NeogitDiffContextHighlight { bg = p.chrome },
        NeogitDiffDeleteHighlight { DiffDelete },
        NeogitDiffAdd { DiffAdd },
        NeogitDiffDelete { DiffDelete },

        -- HiPhish/rainbow-delimiters.nvim
        RainbowDelimiterRed { fg = p.color1 },
        RainbowDelimiterYellow { fg = p.color11 },
        RainbowDelimiterBlue { fg = p.color4 },
        RainbowDelimiterOrange { fg = p.color3 },
        RainbowDelimiterGreen { fg = p.color2 },
        RainbowDelimiterViolet { fg = p.color5 },
        RainbowDelimiterCyan { fg = p.color6 },

        -- rcarriga/nvim-notify
        NotifyDEBUGBorder { fg = p.color15 },
        NotifyDEBUGIcon { fg = p.color7 },
        NotifyDEBUGTitle { NotifyDEBUGIcon },
        NotifyTRACEBorder { fg = p.color13 },
        NotifyTRACEIcon { fg = p.color5 },
        NotifyTRACETitle { NotifyTRACEIcon },
        NotifyINFOBorder { fg = p.color10 },
        NotifyINFOIcon { fg = p.color2 },
        NotifyINFOTitle { NotifyINFOIcon },
        NotifyWARNBorder { fg = p.color11 },
        NotifyWARNIcon { fg = p.color3 },
        NotifyWARNTitle { NotifyWARNIcon },
        NotifyERRORBorder { fg = p.color9 },
        NotifyERRORIcon { fg = p.color1 },
        NotifyERRORTitle { NotifyERRORIcon },
    }
end)

return colorscheme

local lush = require("lush")
local hsl = lush.hsl

-- https://m1.material.io/style/color.html#color-color-palette

local p = {
    color0  = hsl("#1d1d1d"),
    color1  = hsl("#c2185b"), -- Pink        700
    color2  = hsl("#4caf50"), -- Green       500
    color3  = hsl("#ffa000"), -- Amber       700
    color4  = hsl("#7986cb"), -- Indigo      300
    color5  = hsl("#ba68c8"), -- Purple      300
    color6  = hsl("#00acc1"), -- Cyan        600
    color7  = hsl("#757575"), -- Gray        600

    color8  = hsl("#263238"), -- Blue Grey   900
    color9  = hsl("#d81b60"), -- Pink        600
    color10 = hsl("#8bc34a"), -- Light Green 500
    color11 = hsl("#ffeb3b"), -- Yellow      500
    color12 = hsl("#90caf9"), -- Blue        200
    color13 = hsl("#e1bee7"), -- Purple      100
    color14 = hsl("#80deea"), -- Cyan        200
    color15 = hsl("#bdbdbd"), -- Gray        400
}

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
        VisualNC { fg = Normal.bg, bg = p.color7 },
        Comment { fg = p.color7 },
        Conceal { Comment },
        Title { fg = p.color2 },
        CursorLine { bg = p.color8 },
        CursorColumn { CursorLine },
        LineNr { Normal },
        SignColumn { Normal },
        Cursor { Normal, reverse = true },
        CursorLineNr { fg = p.color11, bold = true },
        StatusLine { fg = p.color15, bg = p.color0 },
        StatusLineNC { fg = p.color7, bg = p.color0 },
        Pmenu { Normal },
        PmenuSel { fg = Normal.bg, bg = p.color4 },
        PmenuSbar { fg = Normal.fg, bg = p.color8 },
        PmenuThumb { fg = Normal.bg, bg = p.color7 },
        ModeMsg { fg = p.color4 },
        MoreMsg { fg = p.color4 },

        -- Overlay
        NonText { fg = p.color7 },
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
        WarningMsg { fg = p.color3 },

        -- Generic Syntax
        PreProc { fg = p.color5 },
        Statement { fg = p.color10 },
        Identifier { fg = p.color15 },
        Constant { fg = p.color3 },
        Keyword { Statement, bold = true },
        Special { fg = p.color7 },
        Operator { fg = p.color7 },
        Type { fg = p.color12, bold = true },
        String { fg = p.color2 },
        Number { fg = p.color3 },
        Character { String },
        MatchParen { fg = p.color11, bold = true },
        Function { fg = p.color6 },

        -- TreeSitter
        sym("@function.builtin") {},
        sym("@function.call") { italic = true },
        sym("@type.builtin") { Keyword },
        sym("@constant.builtin") { fg = p.color1, bold = true },
        sym("@variable") { fg = p.color13 },
        sym("@variable.builtin") { fg = p.color13, bold = true },
        sym("@variable.parameter") { fg = p.color5, italic = true },
        sym("@module") { fg = p.color4 },
        sym("@string") { String },

        -- LSP
        sym("@lsp.type.variable") {},
        sym("@lsp.type.parameter") { sym("@variable.parameter") },
        sym("@lsp.type.namespace") {},
        sym("@lsp.type.module") {},
        sym("@lsp.typemod.function.defaultLibrary") { sym("@function.builtin") },
        sym("@lsp.typemod.string.injected") { sym("@string") },
        sym("@lsp.typemod.variable.defaultLibrary") { sym("@variable.builtin") },
        sym("@lsp.typemod.variable.injected") { sym("@variable") },

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

        -- Telescope
        TelescopeSelection { CursorLine },

        -- Dashboard
        DashboardHeader { fg = p.color2 },
        DashboardFooter { fg = p.color12 },

        -- NeoGit
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
        NeogitDiffContextHighlight { bg = p.color8 },
        NeogitDiffDeleteHighlight { DiffDelete },
        NeogitDiffAdd { DiffAdd },
        NeogitDiffDelete { DiffDelete },
    }
end)

return colorscheme

vim.g.colors_name = "a"

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

local c = {
  bg = "#282828",
  bg2 = "#32302f",
  bg4 = "#45403d",
  bg5 = "#5a524c",
  fg = "#d4be98",
  fg1 = "#ddc7a1",
  red = "#ea6962",
  grey1 = "#928374",
  grey2 = "#a89984",
  green = "#a9b665",
  yellow = "#d8a657",
  orange = "#e78a4e",
  blue = "#7daea3",
  purple = "#d3869b",
}

local function hi(group, opts)
  opts.default = false
  vim.api.nvim_set_hl(0, group, opts)
end

local groups = {
  Normal = { fg = c.fg, bg = c.bg },
  NormalFloat = { fg = c.fg, bg = c.bg4 },
  SignColumn = { fg = c.fg, bg = c.bg },
  EndOfBuffer = { fg = c.bg, bg = c.bg },
  CursorLine = { bg = c.bg2 },
  LineNr = { fg = c.bg5, bg = c.bg },
  CursorLineNr = { fg = c.fg, bg = c.bg },
  ColorColumn = { bg = c.bg2 },
  Directory = { fg = c.blue },
  Whitespace = { fg = c.bg4 },

  Visual = { bg = c.bg4 },
  Search = { fg = c.bg, bg = c.yellow },
  IncSearch = { fg = c.bg, bg = c.red },
  CurSearch = { fg = c.bg, bg = c.red },
  MatchParen = { fg = c.fg, bg = c.bg4 },
  StatusLine = { fg = c.fg, bg = c.bg2 },
  StatusLineNC = { fg = c.fg, bg = c.bg2 },
  QuickFixLine = { fg = c.yellow, bg = c.bg2 },

  Pmenu = { fg = c.fg1, bg = c.bg4 },
  PmenuSel = { fg = c.bg4, bg = c.grey2 },
  PmenuKind = { fg = c.green, bg = c.bg4 },
  PmenuKindSel = { fg = c.bg4, bg = c.grey2 },
  PmenuExtra = { fg = c.grey2, bg = c.bg4 },
  PmenuExtraSel = { fg = c.bg4, bg = c.grey2 },
  PmenuMatch = { bold = true },
  PmenuMatchSel = { bold = true },

  Comment = { fg = c.grey1 },
  Constant = { fg = c.fg },
  String = { fg = c.green },
  Character = { fg = c.green },
  Number = { fg = c.fg },
  Identifier = { fg = c.fg },
  Function = { fg = c.fg },
  Statement = { fg = c.red },
  Keyword = { fg = c.red },
  Conditional = { fg = c.red },
  Repeat = { fg = c.red },
  Operator = { fg = c.fg },
  Type = { fg = c.fg },
  PreProc = { fg = c.grey1 },
  Special = { fg = c.fg },
  Delimiter = { fg = c.fg },
  Title = { fg = c.red },
  Todo = { fg = c.orange, bg = c.bg },

  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.blue },
  DiagnosticHint = { fg = c.purple },
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.yellow },
  ModeMsg = { fg = c.yellow },
  Question = { fg = c.yellow },

  diffAdded = { fg = c.green },
  diffRemoved = { fg = c.red },
  diffChanged = { fg = c.yellow },

  ["@keyword"] = { fg = c.red },
  ["@keyword.function"] = { fg = c.red },
  ["@keyword.coroutine"] = { fg = c.red },
  ["@conditional"] = { fg = c.red },
  ["@repeat"] = { fg = c.red },
  ["@operator"] = { fg = c.fg },
  ["@lsp.type.operator"] = { fg = c.fg },
  ["@lsp.typemod.operator.injected"] = { fg = c.fg },
  ["@function"] = { fg = c.fg },
  ["@function.call"] = { fg = c.fg },
  ["@type"] = { fg = c.fg },
  ["@variable"] = { fg = c.fg },
  ["@string"] = { fg = c.green },
  ["@character"] = { fg = c.green },
  ["@comment"] = { fg = c.grey1 },

  RustDeriveTrait = { fg = c.grey1 },
}

for group, opts in pairs(groups) do
  hi(group, opts)
end

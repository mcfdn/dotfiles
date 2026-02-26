vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true

vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true
vim.o.rnu = true
vim.o.signcolumn = "yes"

vim.o.scrolloff = 10

vim.o.clipboard = "unnamedplus"
vim.o.undofile = true

vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
}

-- Wider column for airblade/vim-gitgutter, diagnostics, dap
vim.o.signcolumn = "yes:3"

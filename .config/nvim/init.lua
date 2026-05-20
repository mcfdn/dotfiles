local undodir = vim.fn.stdpath("data") .. "/undo"
vim.fn.mkdir(undodir, "p")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.rnu = true
vim.o.scrolloff = 10
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.undodir = undodir
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.termguicolors = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.signcolumn = "yes:1"
vim.o.list = true
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.listchars = { tab = "→ ", trail = "·" }
vim.o.grepprg = "rg --vimgrep --smart-case"
vim.opt.path:append("**")

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/stevearc/oil.nvim",
})

vim.lsp.enable({
  "gopls", -- go install golang.org/x/tools/gopls@latest
  "rust_analyzer", -- rustup component add rust-analyzer
})

local augroup = vim.api.nvim_create_augroup("mcfdn.init", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "go" },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "80"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "rust" },
  callback = function()
    vim.opt_local.textwidth = 100
    vim.opt_local.colorcolumn = "100"
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      if client.name == "rust_analyzer" then
        client.server_capabilities.inlayHintProvider = nil
        vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
      end
      if client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
    end
    local opts = { silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>l", vim.lsp.buf.format, opts)
  end,
})

vim.keymap.set("n", "<leader>f", ":find ")
vim.keymap.set("n", "<leader>g", ":copen | :silent grep ")
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { silent = true })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { silent = true })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { silent = true })

vim.cmd.colorscheme("a")

require("oil").setup({ view_options = { show_hidden = true } })

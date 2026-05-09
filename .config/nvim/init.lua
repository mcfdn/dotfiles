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
vim.o.signcolumn = "yes:2" -- vim-gitgutter, diagnostics
vim.o.list = true
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.listchars = { tab = "→ ", trail = "·" }
vim.opt.path:append("**")

vim.pack.add({
  "https://github.com/sainnhe/gruvbox-material",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/airblade/vim-gitgutter",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-treesitter/nvim-treesitter", -- cargo install tree-sitter-cli
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/ray-x/go.nvim",
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

local keymap_opts = { silent = true }
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", keymap_opts)
vim.keymap.set("n", "<c-d>", "<c-d>zz", keymap_opts)
vim.keymap.set("n", "<c-u>", "<c-u>zz", keymap_opts)
vim.keymap.set("n", "n", "nzz", keymap_opts)
vim.keymap.set("n", "N", "Nzz", keymap_opts)
vim.keymap.set("v", "<", "<gv", keymap_opts)
vim.keymap.set("v", ">", ">gv", keymap_opts)
vim.keymap.set("v", "y", "ygv<esc>", keymap_opts)
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>", keymap_opts)
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>", keymap_opts)
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>", keymap_opts)
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>", keymap_opts)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, keymap_opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, keymap_opts)
vim.keymap.set("n", "<leader>a", "<cmd>Git blame<cr>", keymap_opts)
vim.keymap.set("n", "-", "<cmd>Oil<cr>", keymap_opts)

vim.g.gruvbox_material_background = "medium"
vim.cmd.colorscheme("gruvbox-material")

require("nvim-autopairs").setup()
require("fidget").setup()
require("go").setup()
require("oil").setup({
    view_options = {
        show_hidden = true,
    },
})

vim.api.nvim_create_user_command("TSInstallMine", function()
  require("nvim-treesitter").install({ "go", "rust" })
end, {})

vim.api.nvim_create_autocmd("PackChanged", {
  group = augroup,
  callback = function(ev)
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
      return
    end
    if ev.data.spec.name == "nvim-treesitter" then
      require("nvim-treesitter").update()
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "go", "rust" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

require("fzf-lua").setup({
  defaults = {
    file_icons = false,
    git_icons = false,
  },
  fzf_opts = { ["--cycle"] = true },
})
vim.keymap.set("n", "<leader>sf", function() require("fzf-lua").files() end, keymap_opts)
vim.keymap.set("n", "<leader>f", function() require("fzf-lua").live_grep() end, keymap_opts)
vim.keymap.set("n", "<leader><space>", function() require("fzf-lua").buffers() end, keymap_opts)

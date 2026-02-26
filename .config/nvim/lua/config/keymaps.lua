vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("v", "y", "may`a")

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Pane navigation
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Telescope
vim.keymap.set("n", "<leader>sf", function() require("fzf-lua").files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>f",  function() require("fzf-lua").live_grep() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader><space>", function() require("fzf-lua").buffers() end, { desc = "Buffers" })

-- Neo-tree
vim.keymap.set("n", "<leader>t", ":Neotree position=left toggle=true<CR>")

-- Git
vim.keymap.set("n", "<leader>a", ":Git blame<CR>")

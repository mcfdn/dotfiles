vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.opt.textwidth = 80
        vim.opt.colorcolumn = "80"
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = event.buf })

        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = event.buf })

        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = event.buf })
        vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { buffer = event.buf })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf })

        vim.keymap.set("n", "<leader>l", vim.lsp.buf.format, { buffer = event.buf })
    end,
})

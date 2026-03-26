vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "go" },
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.colorcolumn = "80"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust" },
    callback = function()
        vim.opt_local.textwidth = 100
        vim.opt_local.colorcolumn = "100"
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)

        -- No inlay hints ever.
        vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client then
          client.server_capabilities.inlayHintProvider = nil
        end

        local opts = { buffer = event.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>l", vim.lsp.buf.format, opts)
    end,
})

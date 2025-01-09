vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.opt.textwidth = 80
        vim.opt.colorcolumn = "80"
    end,
})

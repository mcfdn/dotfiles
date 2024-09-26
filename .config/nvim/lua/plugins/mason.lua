local on_attach = function(_, bufnr)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = bufnr })

    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = bufnr })

    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { buffer = bufnr })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })

    vim.keymap.set("n", "<leader>l", vim.lsp.buf.format, { buffer = bufnr })
end

local servers = {
    gopls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    rust_analyzer = {},
    ts_ls = {},
    volar = {},
}

local config = function()
    local mason_lspconfig = require("mason-lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
            }
        end,
    }
end

return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {
            cmd = "Mason",
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        dependencies = "williamboman/mason.nvim",
        config = config,
    },
}

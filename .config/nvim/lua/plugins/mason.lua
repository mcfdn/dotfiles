local servers = {
    gopls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    rust_analyzer = {},
}

local config = function()
    local mason_lspconfig = require("mason-lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
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

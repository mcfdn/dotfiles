return {
    "ray-x/go.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup()
    end,
    ft = { "go", "gomod" },
}

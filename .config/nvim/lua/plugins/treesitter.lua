local config = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "go",
            "lua",
            "rust",
            "typescript",
            "vim",
            "vimdoc",
            "luadoc",
            "markdown",
        },
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = config,
}

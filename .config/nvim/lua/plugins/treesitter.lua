local config = function()
    require("nvim-treesitter.configs").setup({
        build = ":TSUpdate",
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
    config = config,
}

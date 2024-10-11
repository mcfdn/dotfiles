local config = function()
    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<M-j>"] = "move_selection_next",
                    ["<M-k>"] = "move_selection_previous",
                },
            },
        },
        pickers = {
            find_files = {
                file_ignore_patterns = {
                    "node_modules",
                    ".git",
                },
                disable_devicons = true,
                hidden = true,
            },
        },
        extensions = {
            "fzf",
        },
    })
    telescope.load_extension("fzf")
end

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = config,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = false,
    },
}

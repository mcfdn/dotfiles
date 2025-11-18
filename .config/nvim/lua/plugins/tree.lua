return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            enable_git_status = false,
            enable_diagnostics = false,
            default_component_configs = {
                icon = {
                    folder_closed = "+",
                    folder_open = "-",
                    folder_empty = "0",
                },
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                },
                follow_current_file = {
                    enabled = true,
                },
                hijack_netrw_behavior = "disabled",
            },
        })
    end
}

local config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
        defaults = {
            file_icons = false,
            git_icons = false,
        },
    })
end

return {
    {
        "ibhagwan/fzf-lua",
        lazy = false,
        config = config,
    },
}

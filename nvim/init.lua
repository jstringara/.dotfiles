-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").intelephense.setup({
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000, -- Increase file size limit if needed
            },
        },
    },
})

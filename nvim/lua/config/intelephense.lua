-- Ensure 'intelephense' is properly set up for PHP
require("lspconfig").intelephense.setup({
    -- Optional: Customize Intelephense settings
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000, -- Increase file size limit (optional)
            },
        },
    },
    -- Ensure PHP files are associated with Intelephense
    on_attach = function(client, bufnr)
        -- Additional setup if needed, like keybindings
    end,
})

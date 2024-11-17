-- Ensure that 'phpactor' is deactivated

return {
    -- Ensure 'phpactor' is properly set up for PHP
    require("lspconfig").phpactor.setup({
        -- Optional: Customize PHPactor settings
        settings = {
            phpactor = {
                -- files = {
                --     maxSize = 5000000, -- Increase file size limit (optional)
                -- },
            },
        },
        -- Ensure PHP files are associated with PHPactor
        on_attach = function(client, bufnr)
            -- Additional setup if needed, like keybindings
        end,
    }),
}

-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- comment this line to enable the plugin
-- if true then return {} end

local transparent = false -- Track the transparency state

-- Define the function to toggle transparency
function ToggleTransparency()
    transparent = not transparent
    require("onedarkpro").setup({
        options = {
            transparency = transparent,
        },
    })
    vim.cmd("colorscheme onedark") -- Apply the theme after changing the transparency
end

-- Plugin setup
return {
    {
        "olimorris/onedarkpro.nvim",
        enabled = true,
        priority = 1000,
        config = function()
            -- Set up the theme with the initial transparency setting
            require("onedarkpro").setup({
                options = {
                    transparency = transparent,
                },
                styles = {
                    types = "NONE",
                    methods = "NONE",
                    numbers = "NONE",
                    strings = "NONE",
                    comments = "italic", -- Set comments to italic
                    keywords = "italic", -- Set keywords to italic
                    constants = "NONE",
                    functions = "italic",
                    operators = "NONE",
                    variables = "NONE",
                    parameters = "NONE",
                    conditionals = "italic",
                    virtual_text = "NONE",
                },
            })
        end,
        keys = {
            {
                "<leader>tt", -- Toggle transparency with this keymap
                function()
                    ToggleTransparency()
                end,
                desc = "Toggle Transparency",
            },
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "onedark",
        },
    },
}

-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins

-- comment this line to enable the plugin
if true then return {} end

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
    -- add tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "night",
        },
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
    },
}

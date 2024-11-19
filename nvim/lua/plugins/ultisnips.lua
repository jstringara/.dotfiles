-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins

-- comment this line to enable the plugin
-- if true then return {} end

-- Plugin setup
return {
    -- load the ultisnips plugin
    {
        "sirver/ultisnips",
        config = function()
      vim.g.UltiSnipsExpandTrigger = "<C-l>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
      vim.g.UltiSnipsListSnippets = "<C-tab>"
        end,
    },
    {
        "quangnguyen30192/cmp-nvim-ultisnips",
    },
}

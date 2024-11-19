-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

return {
    "lervag/vimtex",
    init = function()
        vim.g.vimtex_compiler_latexmk = {
            options = {
                "-xelatex",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-shell-escape",
            },
        }
        -- vim.g.vimtex_view_method = "sumatrapdf"
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_fold_enabled = 0
        vim.g.vimtex_fold_enabled = 0
        vim.g.vimtex_compiler_progname = "nvr"
        vim.g.vimtex_compiler_progname = "nvr"
    end,
}

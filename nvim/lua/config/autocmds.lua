-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- set wrap on .md and .txt files
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.md", "*.txt" },
    group = group,
    command = "setlocal wrap",
})

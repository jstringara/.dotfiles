-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable LazyVim's default <C-/> mapping globally
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<C-_>")
vim.keymap.del("n", "<C-/>")

-- remap <C-/> to open ToggleTerm
vim.keymap.set("n", "<C-_>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("n", "<C-/>", "<cmd>ToggleTerm<CR>")

-- save with <leader>w
-- vim.keymap.set("n", "<leader>w", "<cmd>write<CR>")

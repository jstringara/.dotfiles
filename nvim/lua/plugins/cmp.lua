-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- cmp.lua configuration file
return {
    {
        "onsails/lspkind-nvim",
        config = function()
            require("lspkind").init() -- Initialize lspkind for symbol formatting
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            -- Ensure lspkind is loaded
            local lspkind = require("lspkind")

            require("cmp").setup({
                -- Other setup for nvim-cmp
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol", -- Format as symbols (default: 'text')
                        max_width = 50, -- Max width for the display
                        symbol_map = { Copilot = "" }, -- Custom icon for Copilot
                    }),
                    fields = { "abbr", "kind", "menu" }, -- Order of fields in the completion menu
                    expandable_indicator = true, -- Indicator for expandable items
                },
                sources = {
                    { name = "ultisnips" }, -- For ultisnips users.
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "symbol" },
                    -- Other sources
                },
                mapping = {
                    ["<C-Space>"] = require("cmp").mapping.complete(), -- Trigger completion
                    ["<CR>"] = require("cmp").mapping.confirm({ select = true }), -- Accept suggestion
                    ["<Tab>"] = require("cmp").mapping.select_next_item(), -- Select next item
                    ["<S-Tab>"] = require("cmp").mapping.select_prev_item(), -- Select previous item
                    -- Other mappings
                },
                snippet = {
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
            })
        end,
    },
}

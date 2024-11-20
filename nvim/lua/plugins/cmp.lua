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
            require("lspkind").init()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "quangnguyen30192/cmp-nvim-ultisnips",
            requires = { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "copilot" }, -- Copilot
                    { name = "ultisnips" }, -- UltiSnips
                    { name = "nvim_lsp" }, -- LSP
                    -- { name = "luasnip" }, -- LuaSnip (if needed)
                    { name = "symbol" }, -- Symbol source
                }),
                mapping = {
                    ["<Tab>"] = function(fallback)
                        if cmp.visible() then
                            if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                                -- Only expand the snippet when it can be expanded
                                vim.fn["UltiSnips#JumpForwards"]()
                            else
                                cmp.select_next_item()
                            end
                        else
                            fallback()
                        end
                    end,
                    ["<S-Tab>"] = function(fallback)
                        if cmp.visible() then
                            if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                                vim.fn["UltiSnips#JumpBackwards"]()
                            else
                                cmp.select_prev_item()
                            end
                        else
                            fallback()
                        end
                    end,
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        max_width = 50,
                        symbol_map = { Copilot = "" },
                    }),
                    fields = { "abbr", "kind", "menu" },
                    expandable_indicator = true,
                },
            })
        end,
    },
}

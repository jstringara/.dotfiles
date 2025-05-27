-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignored
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
    {
        "snacks.nvim",
        enbaled = true,
        opts = {
            dashboard = {
                preset = {
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰒲 ",
                            key = "l",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    header = [[
	   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆         
	    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦      
	          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄    
	           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄   
	          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀  
	   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄ 
	  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄  
	 ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄ 
	 ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄
	      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆    
	       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃   
      ___          ___          ___         ___                     ___     
     /\__\        /\  \        /\  \       /\__\         ___       /\__\    
    /::|  |      /::\  \      /::\  \     /:/  /        /\  \     /::|  |   
   /:|:|  |     /:/\:\  \    /:/\:\  \   /:/  /         \:\  \   /:|:|  |   
  /:/|:|  |__  /::\~\:\  \  /:/  \:\  \ /:/__/  ___     /::\__\ /:/|:|__|__ 
 /:/ |:| /\__\/:/\:\ \:\__\/:/__/ \:\__\|:|  | /\__\ __/:/\/__//:/ |::::\__\
 \/__|:|/:/  /\:\~\:\ \/__/\:\  \ /:/  /|:|  |/:/  //\/:/  /   \/__/~~/:/  /
     |:/:/  /  \:\ \:\__\   \:\  /:/  / |:|__/:/  / \::/__/          /:/  / 
     |::/  /    \:\ \/__/    \:\/:/  /   \::::/__/   \:\__\         /:/  /  
     /:/  /      \:\__\       \::/  /     ~~~~        \/__/        /:/  /   
     \/__/        \/__/        \/__/                               \/__/    ]],
                },
                sections = {
                    -- first pane
                    -- header
                    { section = "header" },
                    -- quick actions
                    { section = "keys", gap = 1, padding = 1 },
                    -- github cli
                    function()
                        local in_git = Snacks.git.get_root() ~= nil
                        local cmds = {
                            -- open prs
                            --                         {
                            --                             icon = " ",
                            --                             title = "Open PRs",
                            --                             cmd = [[
                            --   gh pr list -L 3 --json number,title,headRefName,createdAt | ConvertFrom-Json | ForEach-Object { "#$($_.number) $($_.title) $($_.headRefName) $($_.createdAt)" }
                            -- ]],
                            --                             key = "p",
                            --                             action = function()
                            --                                 vim.fn.jobstart("gh pr list --web", { detach = true })
                            --                             end,
                            --                             height = 2,
                            --                         },
                            -- diff
                            {
                                icon = " ",
                                title = "Git Status",
                                cmd = "hub --no-pager diff --stat -B -M -C",
                                height = 5,
                            },
                        }
                        return vim.tbl_map(function(cmd)
                            return vim.tbl_extend("force", {
                                section = "terminal",
                                enabled = in_git,
                                padding = 1,
                                ttl = 5 * 60,
                                indent = 3,
                            }, cmd)
                        end, cmds)
                    end,
                    -- projects
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    -- startup
                    { section = "startup" },
                },
            },
        },
    },
    {
        "nvimdev/dashboard-nvim",
        enabled = false,
    },
}

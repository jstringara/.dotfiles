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
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
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
                ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
                ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
                ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
                ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
                ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
                ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        sections = {
          -- first pane
          -- header
          { section = "header" },
          -- quick actions
          { section = "keys", gap = 1, padding = 1 },
          -- projects
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          -- startup
          { section = "startup" },
          -- second pane
          -- pokemon art
          {
            pane = 2,
            section = "terminal",
            cmd = "krabby random --info;",
            height = 25,
            padding = 2,
            ttl = 0,
          },
          -- browse repo
          -- {
          --     pane = 2,
          --     icon = " ",
          --     desc = "Browse Repo",
          --     padding = 1,
          --     key = "b",
          --     action = function()
          --         Snacks.gitbrowse()
          --     end,
          -- },
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
                pane = 2,
                section = "terminal",
                enabled = in_git,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,
        },
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
}

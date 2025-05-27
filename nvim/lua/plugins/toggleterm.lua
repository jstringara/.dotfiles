local uname = vim.loop.os_uname()
local is_windows = uname.sysname == "Windows_NT"

if is_windows then
    vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.opt.shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
else
    -- Prefer zsh, fallback to bash or sh
    if vim.fn.executable("zsh") == 1 then
        vim.opt.shell = "zsh"
    elseif vim.fn.executable("bash") == 1 then
        vim.opt.shell = "bash"
    else
        vim.opt.shell = "sh"
    end

    vim.opt.shellcmdflag = "-c"
    vim.opt.shellredir = ">%s 2>&1"
    vim.opt.shellpipe = "2>&1 | tee %s"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

return {
    {
        "akinsho/toggleterm.nvim",
        lazy = true,
        cmd = { "ToggleTerm" },
        keys = {
            {
                "<C-_>",
                function()
                    local count = vim.v.count1
                    require("toggleterm").toggle(count, 0, LazyVim.root.get(), "float")
                end,
                desc = "ToggleTerm (float)",
            },
            {
                "<leader>tf",
                function()
                    local count = vim.v.count1
                    require("toggleterm").toggle(count, 0, LazyVim.root.get(), "float")
                end,
                desc = "ToggleTerm (float root_dir)",
            },
            {
                "<leader>th",
                function()
                    local count = vim.v.count1
                    require("toggleterm").toggle(count, 15, LazyVim.root.get(), "horizontal")
                end,
                desc = "ToggleTerm (horizontal root_dir)",
            },
            {
                "<leader>tv",
                function()
                    local count = vim.v.count1
                    require("toggleterm").toggle(count, vim.o.columns * 0.4, LazyVim.root.get(), "vertical")
                end,
                desc = "ToggleTerm (vertical root_dir)",
            },
            {
                "<leader>tn",
                "<cmd>ToggleTermSetName<cr>",
                desc = "Set term name",
            },
            {
                "<leader>ts",
                "<cmd>TermSelect<cr>",
                desc = "Select term",
            },
        },
        opts = {
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<C-/>]],
            -- on_open = fun(t: Terminal), -- function to run when the terminal opens
            -- on_close = fun(t: Terminal), -- function to run when the terminal closes
            -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
            -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
            -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
            persist_size = true,
            -- direction = "horizontal" or "vertical" or "window" or "float",
            direction = "float",
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            -- This field is only relevant if direction is set to 'float'
            float_opts = {
                -- The border key is *almost* the same as 'nvim_open_win'
                -- see :h nvim_open_win for details on borders however
                -- the 'curved' border is a custom border type
                -- not natively supported but implemented in this plugin.
                -- border = "single" or "double" or "shadow" or "curved",
                border = "curved",
                width = math.ceil(vim.o.columns * 0.8),
                height = math.ceil(vim.o.columns * 0.2),
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        },
    },
}

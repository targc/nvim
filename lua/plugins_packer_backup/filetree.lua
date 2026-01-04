return function(use)
    -------
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        }
    }
    require("nvim-tree").setup({
        -- open_on_setup = false,
        git = {
            enable = true,
            ignore = false,
            show_on_dirs = true,
            show_on_open_dirs = true,
            timeout = 400,
        },
        modified = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        view = {
            width = function()
                local winwidth = vim.fn.winwidth(0)

                -- if winwidth <= 50 then
                --     return winwidth
                -- end

                return winwidth
                -- if winwidth <= 100 then
                --     return 30
                -- elseif winwidth <= 200 then
                --     return 40
                -- else
                --     return 50
                -- end
            end,
            float = {
                enable = true,
                quit_on_focus_loss = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 50,
                    height = 30,
                    row = 1,
                    col = 1,
                },
            },
        },
    })
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
end

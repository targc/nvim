-- All plugins in lazy.nvim format
return {
    -- Quickfix
    { 'kevinhwang91/nvim-bqf', ft = 'qf' },
    { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },

    -- Statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'moonfly',
                    component_separators = "",
                    section_separators = "",
                    always_divide_middle = false,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = {
                        { 'filename', path = 4 },
                        { function()
                            local count = 0
                            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                                if vim.bo[buf].modified then count = count + 1 end
                            end
                            return count > 0 and "!" .. count or ''
                        end },
                    },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                },
            }
        end
    },

    -- Comment
    { 'numToStr/Comment.nvim', config = true },

    -- File tree
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = { { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle file tree' } },
        config = function()
            require('nvim-tree').setup {
                git = { enable = true, ignore = false },
                modified = { enable = true, show_on_dirs = true },
                update_cwd = true,
                update_focused_file = { enable = true, update_cwd = true },
                view = {
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
            }
        end
    },

    -- Git
    {
        'tpope/vim-fugitive',
        keys = { { '<leader>g', ':Git<CR>', desc = 'Git status' } },
    },
    { 'rbong/vim-flog' },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = { text = '|' },
                    change       = { text = '|' },
                    delete       = { text = '_' },
                    topdelete    = { text = '-' },
                    changedelete = { text = '~' },
                    untracked    = { text = ':' },
                },
                current_line_blame = true,
                current_line_blame_opts = { delay = 500 },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            }
        end
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>p', ':Telescope find_files<CR>', desc = 'Find files' },
            { '<leader>s', ':Telescope live_grep<CR>', desc = 'Live grep' },
            { '<leader>d', ':Telescope diagnostics<CR>', desc = 'Diagnostics' },
            { '<leader><Tab>', ':Telescope buffers<CR>', desc = 'Buffers' },
        },
        config = function()
            local actions = require('telescope.actions')
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-h>'] = 'which_key',
                            ['<C-d>'] = actions.delete_buffer,
                        }
                    },
                },
                pickers = {
                    find_files = {
                        theme = 'dropdown',
                        previewer = false,
                        layout_config = { width = 0.9 },
                    }
                },
            }
        end
    },

    -- Theme
    {
        'nyoom-engineering/oxocarbon.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = 'dark'
            vim.cmd('colorscheme oxocarbon')
        end
    },

    -- Treesitter (just for parser installation, highlighting is built-in)
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/nvim-treesitter-context' },

    -- LSP
    { 'editorconfig/editorconfig-vim' },
    { 'williamboman/mason.nvim', config = true },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = { 'rust_analyzer', 'lua_ls', 'yamlls' },
            }
        end
    },

    -- Completion
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-n>'] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
            }
        end
    },

    -- Claude Code
    {
        'greggh/claude-code.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
    },

    -- CodeCompanion (uncomment and add your token if needed)
    -- {
    --     'olimorris/codecompanion.nvim',
    --     config = function()
    --         require('codecompanion').setup {}
    --     end
    -- },
}

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
                    theme = 'material',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { { 'mode', icon = '' } },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = {
                        { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' ', unnamed = '[No Name]' } },
                    },
                    lualine_x = { 'filetype' },
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
            local previewers = require('telescope.previewers')

            require('telescope').setup {
                defaults = {
                    file_previewer = previewers.vim_buffer_cat.new,
                    grep_previewer = previewers.vim_buffer_vimgrep.new,
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

    -- Theme (Material Design)
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.material_style = 'deep ocean' -- oceanic, deep ocean, palenight, lighter, darker

            local colors = require('material.colors')
            require('material').setup {
                contrast = {
                    terminal = true,
                    sidebars = true,
                    floating_windows = true,
                },
                styles = {
                    comments = { italic = true },
                    keywords = { bold = true },
                    functions = { bold = true },
                },
                plugins = {
                    'gitsigns',
                    'indent-blankline',
                    'nvim-cmp',
                    'nvim-tree',
                    'telescope',
                },
                custom_highlights = {
                    -- Make keywords pop (purple)
                    ['@keyword'] = { fg = colors.main.purple, bold = true },
                    ['@keyword.function'] = { fg = colors.main.purple, bold = true },
                    ['@keyword.return'] = { fg = colors.main.purple, bold = true },
                    ['@conditional'] = { fg = colors.main.purple, bold = true },

                    -- Functions stand out (blue)
                    ['@function'] = { fg = colors.main.blue, bold = true },
                    ['@function.call'] = { fg = colors.main.blue },
                    ['@method'] = { fg = colors.main.blue },
                    ['@method.call'] = { fg = colors.main.blue },

                    -- Types prominent (yellow)
                    ['@type'] = { fg = colors.main.yellow, bold = true },
                    ['@type.builtin'] = { fg = colors.main.yellow },

                    -- Strings subdued (green, no italic)
                    ['@string'] = { fg = colors.main.green },

                    -- Struct tags less prominent (dimmed)
                    ['@string.special'] = { fg = colors.editor.disabled },
                    ['@attribute'] = { fg = colors.editor.disabled },

                    -- Variables normal
                    ['@variable'] = { fg = colors.editor.fg },
                    ['@parameter'] = { fg = colors.main.orange },
                },
            }
            vim.cmd('colorscheme material')
        end
    },

    -- Indent guides
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            indent = { char = '│' },
            scope = { enabled = true, show_start = false, show_end = false },
        },
    },

    -- Better UI for inputs/selects
    {
        'stevearc/dressing.nvim',
        opts = {
            input = { border = 'rounded' },
            select = { backend = { 'telescope', 'builtin' } },
        },
    },

    -- Smooth scrolling
    {
        'karb94/neoscroll.nvim',
        opts = { easing_function = 'cubic' },
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local ok, configs = pcall(require, 'nvim-treesitter.configs')
            if ok and configs.setup then
                configs.setup {
                    ensure_installed = { 'lua', 'vim', 'vimdoc', 'rust', 'go', 'yaml', 'json', 'markdown', 'typescript', 'javascript', 'python' },
                    auto_install = true,
                    highlight = { enable = true, additional_vim_regex_highlighting = false },
                }
            else
                vim.api.nvim_create_autocmd('VimEnter', {
                    once = true,
                    callback = function()
                        local parsers = { 'lua', 'vim', 'vimdoc', 'rust', 'go', 'yaml', 'json', 'markdown', 'typescript', 'javascript', 'python' }
                        for _, lang in ipairs(parsers) do
                            pcall(vim.cmd, 'TSInstall ' .. lang)
                        end
                    end,
                })
            end
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-context' },

    -- Rainbow brackets
    {
        'HiPhish/rainbow-delimiters.nvim',
        config = function()
            local rainbow = require('rainbow-delimiters')
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow.strategy['global'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
    },

    -- Highlight color codes
    {
        'NvChad/nvim-colorizer.lua',
        opts = {
            user_default_options = {
                names = false,
                css = true,
                tailwind = true,
            },
        },
    },

    -- LSP
    { 'editorconfig/editorconfig-vim' },
    { 'williamboman/mason.nvim', config = true },
    { 'neovim/nvim-lspconfig' },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('mason-lspconfig').setup {
                ensure_installed = { 'rust_analyzer', 'lua_ls', 'yamlls', 'gopls', 'ts_ls', 'pyright' },
                automatic_installation = true,
                handlers = {
                    -- Default handler
                    function(server_name)
                        lspconfig[server_name].setup { capabilities = capabilities }
                    end,
                    -- Custom configs
                    ['lua_ls'] = function()
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = { diagnostics = { globals = { 'vim' } } }
                            }
                        }
                    end,
                    ['yamlls'] = function()
                        lspconfig.yamlls.setup {
                            capabilities = capabilities,
                            settings = {
                                yaml = { keyOrdering = false }
                            }
                        }
                    end,
                }
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

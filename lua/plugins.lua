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

    -- Theme (Custom purple/red/darkblue palette)
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.material_style = 'deep ocean'

            -- Custom palette: purple, red, dark blue
            local purple = '#c792ea'
            local light_purple = '#d6acff'
            local red = '#ff5370'
            local dark_red = '#f07178'
            local dark_blue = '#5c7ab5'
            local blue = '#82aaff'
            local gray = '#676e95'
            local white = '#c3d0eb'

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
                    -- Keywords: purple, bold
                    ['@keyword'] = { fg = purple, bold = true },
                    ['@keyword.function'] = { fg = purple, bold = true },
                    ['@keyword.return'] = { fg = purple, bold = true },
                    ['@conditional'] = { fg = purple, bold = true },
                    ['@repeat'] = { fg = purple, bold = true },
                    ['@include'] = { fg = purple },

                    -- Functions: blue
                    ['@function'] = { fg = blue, bold = true },
                    ['@function.call'] = { fg = blue },
                    ['@method'] = { fg = blue },
                    ['@method.call'] = { fg = blue },
                    ['@function.builtin'] = { fg = blue },

                    -- Types: light purple (NO YELLOW)
                    ['@type'] = { fg = light_purple },
                    ['@type.builtin'] = { fg = light_purple },
                    ['@type.definition'] = { fg = light_purple },
                    ['@type.qualifier'] = { fg = purple },
                    ['@storageclass'] = { fg = purple },
                    Type = { fg = light_purple },
                    Typedef = { fg = light_purple },
                    Structure = { fg = light_purple },

                    -- Strings: red
                    ['@string'] = { fg = dark_red },
                    ['@character'] = { fg = dark_red },
                    String = { fg = dark_red },

                    -- Constants/numbers: red (NO YELLOW)
                    ['@constant'] = { fg = red },
                    ['@constant.builtin'] = { fg = red },
                    ['@number'] = { fg = red },
                    ['@number.float'] = { fg = red },
                    ['@boolean'] = { fg = red },
                    Constant = { fg = red },
                    Number = { fg = red },
                    Float = { fg = red },
                    Boolean = { fg = red },

                    -- Struct tags/labels dimmed
                    ['@string.special'] = { fg = gray },
                    ['@attribute'] = { fg = gray },
                    ['@tag.attribute'] = { fg = gray },
                    ['@label'] = { fg = gray },

                    -- Fields/properties: white (NO YELLOW)
                    ['@field'] = { fg = white },
                    ['@property'] = { fg = white },
                    ['@lsp.type.property'] = { fg = white },
                    ['@variable.member'] = { fg = white },

                    -- Variables: white/normal
                    ['@variable'] = { fg = white },
                    ['@variable.builtin'] = { fg = dark_blue },
                    ['@parameter'] = { fg = dark_blue },
                    Identifier = { fg = white },

                    -- Operators/punctuation
                    ['@operator'] = { fg = red },
                    ['@punctuation.bracket'] = { fg = white },
                    ['@punctuation.delimiter'] = { fg = white },
                    Operator = { fg = red },

                    -- Comments: gray italic
                    ['@comment'] = { fg = gray, italic = true },
                    Comment = { fg = gray, italic = true },

                    -- Special (NO YELLOW)
                    Special = { fg = dark_blue },
                    SpecialChar = { fg = dark_red },
                    Tag = { fg = purple },
                    Delimiter = { fg = white },
                    SpecialComment = { fg = gray },
                    Debug = { fg = red },

                    -- Warnings/search - purple instead of yellow
                    DiagnosticWarn = { fg = light_purple },
                    DiagnosticVirtualTextWarn = { fg = light_purple },
                    WarningMsg = { fg = light_purple },
                    Search = { bg = '#3d3d5c', fg = white },
                    IncSearch = { bg = purple, fg = '#0f111a' },
                    CurSearch = { bg = purple, fg = '#0f111a' },

                    -- UI elements - no yellow
                    Title = { fg = purple, bold = true },
                    Directory = { fg = blue },
                    MatchParen = { fg = red, bold = true },
                    Question = { fg = blue },
                    MoreMsg = { fg = blue },

                    -- Git signs - no yellow
                    GitSignsChange = { fg = blue },
                    DiffChange = { fg = blue },
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

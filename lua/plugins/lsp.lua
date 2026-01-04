return function(use)
    use { 'editorconfig/editorconfig-vim' }
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }

    -- Autocompletion
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lua' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }

    -- Mason setup
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { 'rust_analyzer', 'lua_ls', 'yamlls' },
    })

    -- LSP keymaps on attach
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local opts = { buffer = args.buf }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = 'single' }) end, opts)
            vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, opts)
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts)
            vim.keymap.set("i", "<C-a>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end, opts)
        end,
    })

    -- LSP server configs using vim.lsp.config (Neovim 0.11+)
    vim.lsp.config('lua_ls', {
        settings = {
            Lua = {
                diagnostics = { globals = { 'vim' } }
            }
        }
    })

    vim.lsp.config('yamlls', {
        settings = {
            yaml = { keyOrdering = false }
        }
    })

    -- Enable servers
    vim.lsp.enable({ 'rust_analyzer', 'lua_ls', 'yamlls' })

    -- Completion setup
    local cmp = require('cmp')
    cmp.setup({
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
    })

    -- Diagnostic config
    vim.diagnostic.config({
        virtual_text = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = 'E',
                [vim.diagnostic.severity.WARN] = 'W',
                [vim.diagnostic.severity.HINT] = 'H',
                [vim.diagnostic.severity.INFO] = 'I',
            }
        }
    })
end

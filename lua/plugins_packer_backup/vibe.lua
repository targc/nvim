return function(use)
    -- -- Required plugins
    -- use 'nvim-lua/plenary.nvim'
    -- use 'MunifTanjim/nui.nvim'
    -- use 'MeanderingProgrammer/render-markdown.nvim'
    --
    -- -- Optional dependencies
    -- use 'hrsh7th/nvim-cmp'
    -- use 'nvim-tree/nvim-web-devicons' -- or use 'echasnovski/mini.icons'
    -- use 'HakonHarnes/img-clip.nvim'
    -- use 'zbirenbaum/copilot.lua'
    -- use 'stevearc/dressing.nvim' -- for enhanced input UI
    -- use 'folke/snacks.nvim'      -- for modern input UI
    --
    -- -- Avante.nvim with build process
    -- use {
    --     'targc/avante.nvim',
    --     branch = 'main',
    --     run = 'make',
    --     config = function()
    --     end
    -- }
    --
    -- vim.fn.setenv('OPENROUTER_API_KEY', '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')
    --
    -- require('avante').setup {
    --     -- provider = "ollama",
    --     -- providers = {
    --     --     ollama = {
    --     --         endpoint = "http://localhost:11434",
    --     --         model = "gemma3n:e2b",
    --     --     },
    --     -- }
    --     provider = "openrouter",
    --     providers = {
    --         openrouter = {
    --             __inherited_from = 'openai',
    --             endpoint = 'https://openrouter.ai/api/v1',
    --             api_key_name = 'OPENROUTER_API_KEY',
    --             -- model = 'qwen/qwq-32b:free',
    --             model = 'qwen/qwen3-8b:free',
    --         },
    --     },
    -- }

    local token =
    "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"

    use({
        "olimorris/codecompanion.nvim",
        config = function()
            require("codecompanion").setup({
                adapters = {
                    acp = {
                        claude_code = function()
                            return require("codecompanion.adapters").extend("claude_code", {
                                env = {
                                    CLAUDE_CODE_OAUTH_TOKEN = token,
                                },
                            })
                        end,
                    },
                },
            })
        end
    })
end

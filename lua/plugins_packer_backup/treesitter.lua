return function(use)
    -------
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -------
    use("nvim-treesitter/nvim-treesitter-context");

    require 'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true
        },
        -- refactor = {
        --     highlight_definitions = {
        --         enable = true
        --     },
        --     highlight_current_scope = {
        --         enable = true
        --     },
        --     smart_rename = {
        --         enable = true,
        --         keymaps = {
        --             smart_rename = "grr"
        --         }
        --     },
        --     navigation = {
        --         enable = true,
        --         keymaps = {
        --             goto_definition = "gnd",
        --             list_definitions = "gnD"
        --         }
        --     }
        -- },
        textobjects = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aC"] = "@class.outer",
                ["iC"] = "@class.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["ae"] = "@block.outer",
                ["ie"] = "@block.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["is"] = "@statement.inner",
                ["as"] = "@statement.outer",
                ["ad"] = "@comment.outer",
                ["am"] = "@call.outer",
                ["im"] = "@call.inner"
            }
        },
        -- ensure_installed = "all"
    }
end

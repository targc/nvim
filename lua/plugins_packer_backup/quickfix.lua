return function(use)
    -------
    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

    use {
        'junegunn/fzf',
        run = function()
            vim.fn['fzf#install']()
        end
    }
end

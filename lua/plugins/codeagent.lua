return function(use)
    -------
    use {
      'greggh/claude-code.nvim',
      requires = {
        'nvim-lua/plenary.nvim', -- Required for git operations
      },
      config = function()
        require('claude-code').setup()
      end
    }
end

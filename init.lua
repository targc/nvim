------------- GENERAL -------------

vim.opt.guicursor = ""

vim.opt.nu = true

vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup//"
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo//"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.encoding = "UTF-8"

------------- RE-MAPPINGS - 1 -------------

vim.g.mapleader = " "

-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "Z", function()
    print "test"
end)

vim.keymap.set("n", "r", "\"_r")
vim.keymap.set("n", "c", "\"_c")
vim.keymap.set("n", "d", "\"_d")
vim.keymap.set("n", "D", "\"_D")
vim.keymap.set("n", "s", "\"_s")
vim.keymap.set("n", "S", "\"_S")
vim.keymap.set("v", "r", "\"_r")
vim.keymap.set("v", "c", "\"_c")
vim.keymap.set("v", "d", "\"_d")
vim.keymap.set("v", "D", "\"_D")
vim.keymap.set("v", "s", "\"_s")
vim.keymap.set("v", "S", "\"_S")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])


-- vim.keymap.set("x", "<leader>p", [["_dP]])
-- vim.keymap.set("x", "<leader>p", [["_dP]])
--

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-c>", "<Esc>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("v", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<C-q>", ":q<CR>")
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

local opts = { noremap = true, silent = true }

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', '<leader>qf', quickfix, opts)

vim.cmd [[hi DiffAdd      gui=none    guifg=NONE          guibg=#bada9f]]
vim.cmd [[hi DiffChange   gui=none    guifg=NONE          guibg=#e5d5ac]]
vim.cmd [[hi DiffDelete   gui=bold    guifg=#ff8080       guibg=#ffb0b0]]
vim.cmd [[hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2]]
vim.cmd [[hi TreesitterContextBottom gui=none guibg=purple]]

-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white ]]

vim.api.nvim_create_user_command('Xbe', function()
  vim.cmd("'<,'>pyfile ~/Documents/alpha/nvimer/base64_encode.py")
end, { range = true })

vim.api.nvim_create_user_command('Xbd', function()
  vim.cmd("'<,'>pyfile ~/Documents/alpha/nvimer/base64_decode.py")
end, { range = true })

vim.api.nvim_create_user_command('Xbye', function()
  vim.cmd("pyfile ~/Documents/alpha/nvimer/base64_encode_yaml.py")
end, { range = true })

vim.api.nvim_create_user_command('Xbyd', function()
  vim.cmd("pyfile ~/Documents/alpha/nvimer/base64_decode_yaml.py")
end, { range = true })

vim.api.nvim_create_user_command('Xbyv', function()
  vim.cmd("pyfile ~/Documents/alpha/nvimer/base64_view_yaml.py")
end, { range = true })

vim.keymap.set("v", "<leader>be", ":Xbe<CR>")
vim.keymap.set("v", "<leader>bd", ":Xbd<CR>")
vim.keymap.set("v", "<leader>bye", ":Xbye<CR>")
vim.keymap.set("v", "<leader>byd", ":Xbyd<CR>")
vim.keymap.set("v", "<leader>byv", ":Xbyv<CR>")
vim.keymap.set("n", "<leader>c", ":noh<CR>")

vim.keymap.set("n", "<leader>cn", ":cn<CR>")
vim.keymap.set("n", "<leader>cp", ":cp<CR>")

------------- PLUGINS (lazy.nvim) -------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = { notify = false },
})

------------- LSP (native vim.lsp.config) -------------

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

vim.lsp.config('lua_ls', {
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
})
vim.lsp.config('yamlls', {
    settings = { yaml = { keyOrdering = false } }
})
vim.lsp.enable({ 'rust_analyzer', 'lua_ls', 'yamlls' })

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

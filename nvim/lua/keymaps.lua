local builtin = require('telescope.builtin')

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})
-- vim.api.nvim_set_keymap('v', 'jk', '<Esc>', {})

-- telescope
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- mini-tree
vim.keymap.set('n', '<C-n>', ':lua MiniFiles.open()<Enter>', {})

-- date
vim.keymap.set('n', '<leader>dt', ":put =strftime('%Y-%m-%d')<CR>I<BS><ESC>")

--spider
vim.keymap.set(
    { "n", "o", "x" },
    "w",
    "<cmd>lua require('spider').motion('w')<CR>",
    { desc = "Spider-w" }
)
vim.keymap.set(
    { "n", "o", "x" },
    "e",
    "<cmd>lua require('spider').motion('e')<CR>",
    { desc = "Spider-e" }
)
vim.keymap.set(
    { "n", "o", "x" },
    "b",
    "<cmd>lua require('spider').motion('b')<CR>",
    { desc = "Spider-b" }
)


-- windows and tabs
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>')

vim.keymap.set('n', '<leader>n', ':vsplit<CR>')
vim.keymap.set('n', '<leader>N', ':split<CR>')

vim.keymap.set('n', '<leader>w', ':wincmd w<CR>')
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>')
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>')
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>')
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>=', ':vertical resize +5<CR>')
vim.keymap.set('n', '<leader>-', ':vertical resize -5<CR>')

vim.keymap.set('n', '<leader>+', ':horizontal resize +5<CR>')
vim.keymap.set('n', '<leader>_', ':horizontal resize -5<CR>')

vim.keymap.set('n', '<leader>q', ':close<CR>')

vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')

vim.keymap.set('n', '<leader>tc', ':tabclose<CR>')

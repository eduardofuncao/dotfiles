return {
    "ggandor/leap.nvim",
	config = function()
        require("leap")
        vim.keymap.set({'n', 'x'}, '<CR>', '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x'}, '<S-CR>', '<Plug>(leap-backward)')
        vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
	end,
}

---------
-- lsp --
---------
vim.lsp.enable({ "lua_ls", "gopls", "pyright" })

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})

-- blink
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  fuzzy = { implementation = "lua" },
  signature = { enabled = true },
  completion = {
    trigger = {
      show_on_insert_on_trigger_character = false,
      show_on_keyword = false,
      show_on_trigger_character = false,
    },
  },
})

-- disable lsp warning for missing vim
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

return {
	{
		"williamboman/mason.nvim",
		config = function(_, opts)
			local conf = vim.tbl_deep_extend("keep", opts, {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			-- ^^^^^ Here we are basically merge you configuration with OPTS
			-- OPTS contains configurations defined elsewhere like nvim-java

			require("mason").setup(conf)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pylsp", "html", "ts_ls", "csharp_ls", "biome" }, --"eslint", 
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local util = require("lspconfig.util")
			require("java").setup()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			-- lspconfig.eslint.setup({
			-- 	capabilities = capabilities,
			-- })
			lspconfig.biome.setup({
				capabilities = capabilities,
            root_dir = function(fname)
                return util.root_pattern("biome.json", "biome.jsonc")(fname)
                  or util.find_package_json_ancestor(fname)
                  or util.find_node_modules_ancestor(fname)
                  or util.find_git_ancestor(fname)
              end,
			})
			lspconfig.jdtls.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})
			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}

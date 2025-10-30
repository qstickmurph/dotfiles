return {
	"stevearc/conform.nvim",
	enabled = false,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			angular = { "prettierd" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}

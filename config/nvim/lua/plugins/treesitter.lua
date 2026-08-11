return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "master",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

		vim.treesitter.language.register("dockerfile", { "Containerfile", "Dockerfile" })

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"python",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"dockerfile",
				"yaml",
				"c",
				"cpp",
				"c_sharp",
				"java",
				"rust",
				"go",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = false },
			autotag = { enable = true },
		})
	end,
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = {
			enabled = true,
			replace_netrw = true,
			trash = true,
		},
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			-- timeout = 3000
		},
		picker = {
			enabled = true,
			hidden = true,
			ignored = true,
			sources = {
				explorer = {
					win = {
						list = {
							keys = {
								["O"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	},
}

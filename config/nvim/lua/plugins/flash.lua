return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		label = {
			uppercase = true,
			after = true,
			before = true,
		},
		modes = {
			char = {
				jump_labels = true,
				label = {
					uppercase = true,
					after = true,
					before = true,
				},
			},
		},
	},
}

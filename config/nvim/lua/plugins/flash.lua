return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		label = {
			uppercase = false,
			after = true,
			before = true,
		},
		modes = {
			char = {
				jump_labels = true,
				label = {
					uppercase = false,
					after = true,
					before = true,
				},
			},
		},
	},
}

return {
	"nvim-neorg/neorg",
	cmd = "Neorg",
	ft = "norg",
	version = "*",
	dependencies = {
		"L3MON4D3/LuaSnip",
	},
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.journal"] = {
					config = {
						strategy = "flat",
					},
				},
				["core.concealer"] = {
					config = {
						icons = {
							code_block = { conceal = true },
							todo = {
								undone = { icon = " " },
							},
						},
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							personal = "~/Documents/notes/personal",
							work = "~/Documents/notes/work",
						},
						default_workspace = "work",
					},
				},
			},
		})
		-- Neorg use journal snippet upon entering new journal
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = "*/journal/*.norg",
			callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

        if line_count > 1 or (first_line ~= "" and first_line ~= nil) then
          return
        end

				vim.api.nvim_buf_set_lines(0, 0, 0, false, { "" })
				vim.api.nvim_win_set_cursor(0, { 1, 0 })

        vim.notify("This is working", vim.log.levels.INFO)

				local ls = require("luasnip")
				local snippets = ls.get_snippets("norg")
				for _, snip in pairs(snippets) do
					if snip.trigger == "journal" then
						ls.snip_expand(snip)
						break
					end
				end
			end,
		})

		-- Neorg buffer settings
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = "*.norg",
			callback = function(ev)
				vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, silent = true })

				vim.opt_local.conceallevel = 3

				vim.opt_local.wrap = true
				vim.opt_local.linebreak = true
				vim.opt.colorcolumn = "144"
				vim.opt.foldlevel = 3

				vim.opt.tabstop = 1
				vim.opt.softtabstop = 1
				vim.opt.shiftwidth = 1
				vim.opt.expandtab = true

				vim.opt.smartindent = true

				vim.opt.autochdir = true

				vim.opt.breakindent = true
			end,
		})
	end,
}

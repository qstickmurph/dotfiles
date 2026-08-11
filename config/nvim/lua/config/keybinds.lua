local function open_journal(dir)
  local path = vim.fn.expand(dir) .. "/" .. os.date("%Y-%m-%d") .. ".org"
  vim.cmd("edit " .. vim.fn.fnameescape(path))
end

return {
	{ -- Vanilla remaps
		-- Change escape commands
		{ "jh", "<esc>", mode = "i" },
		{ "jh", "<C-C>", mode = "i" },

		-- Move lines in visual mode
		{ "J", ":m '>+1<CR>gv=gv", mode = "v" },
		{ "K", ":m '<-2<CR>gv=gv", mode = "v" },

		-- Recenter window on page down
		{ "<C-d>", "<C-d>zz", mode = "n" },
		{ "<C-u>", "<C-u>zz", mode = "n" },

		-- Copy to clipboard
		{ "<Leader>y", '"+y', mode = { "n", "v" }, desc = "which_key_ignore" },
		{ "<Leader>Y", '"+Y', mode = "n", desc = "which_key_ignore" },
	},
	{ -- Root level keybinds
		{
			"<Leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},
		{
			"<C-w><Space>",
			function()
				require("which-key").show({ loop = true })
			end,
			desc = "Buffer Local Keymaps",
		},
		{
			"<Leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<Leader>N",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notifications",
		},
		{
			"<Leader>u",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<Leader>U",
			function()
				vim.cmd("UndotreeToggle")
			end,
			desc = "Undo Tree",
		},
		{
			"<Leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Zen Toggle",
		},
		{
			"<Leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Zen Zoom",
		},
		{
			"<Leader>S",
			function()
				require("spectre").toggle()
			end,
			desc = "Toggle Spectre",
		},
		{
			"<Leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<Leader>q",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<Leader>Q",
			function()
				Snacks.bufdelete.all()
				Snacks.dashboard()
			end,
			desc = "Delete Buffer",
		},
	},
	{ -- Flash Group
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash Everywhere",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<C-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
	{ -- Project/Files Group
		"<Leader>p",
		group = "Project/Files",
		mode = "n",

		{
			"<Leader>pp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<Leader>pD",
			function()
				if Snacks.picker.get({ source = "explorer" })[1] == nil then
					Snacks.picker.explorer()
				elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == true then
					Snacks.picker.explorer()
				elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == false then
					Snacks.picker.get({ source = "explorer" })[1]:focus()
				end
			end,
			desc = "File Explorer Sidebar",
		},
		{
			"<Leader>pd",
			function()
        Snacks.picker.explorer({
           auto_close = true,
           layout = {
             preset="dropdown"
           }
        })
			end,
			desc = "File Explorer",
		},
		{
			"<Leader>pv",
			function()
				Snacks.explorer.reveal({ buf = 0 })
			end,
			desc = "Show in File Explorer",
		},
		{
			"<Leader>pf",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<Leader>pg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<Leader>ps",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<Leader>p.",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<Leader>pr",
			function()
				Snacks.picker.recent({ filter = { cwd = true } })
			end,
			desc = "Recent Files",
		},
		{
			"<Leader>pj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<Leader>pb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<Leader>pm",
			function()
				Snacks.picker.marks({ filter = { cwd = true } })
			end,
			desc = "Marks",
		},
	},
	{ -- Git Group
		"<Leader>g",
		group = "Git",
		mode = "n",
		cond = function()
			local handle = io.popen("git rev-parse --is-inside-work-tree 2> /dev/null")
			if handle == nil then
				return
			end
			local result = handle:read("*a")
			handle:close()
			return result ~= ""
		end,

		{ "<Leader>gg", "<cmd>Git<CR>", desc = "Open Fugitive" },
		{ "<Leader>gl", "<cmd>GitBlameToggle<CR>", desc = "Toggle Git Blame" },

		{ -- Pickers
			"<Leader>gp",
			group = "Git Pickers",

			{
				"<Leader>gpb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<Leader>gpl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<Leader>gpL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<Leader>gps",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<Leader>gpS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<Leader>gpd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<Leader>gpf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},
		},

		{ -- Add
			"<Leader>ga",
			group = "Git Add",

			{
				"<Leader>ga",
				function()
					vim.ui.input({
						prompt = "What would you like to stage?",
						completion = "file",
					}, function(input_text)
						if input_text then
							vim.cmd("Git add " .. input_text)
							vim.notify("Staged " .. input_text, vim.log.levels.INFO, { title = "Git" })
						end
					end)
				end,
				desc = "Git Add",
			},
			{
				"<Leader>gaa",
				function()
					vim.cmd("Git add --all")
					vim.notify("Staged all files", vim.log.levels.INFO, { title = "Git" })
				end,
				desc = "Git Add All",
			},
		},

		{ -- Branches
			"<Leader>gb",
			group = "Git Branches",

			{
				"<Leader>gbs",
				function()
					vim.ui.input({
						prompt = "What branch would you like to switch to?",
						-- completion = "git branch?",
					}, function(input_text)
						if input_text then
							vim.cmd("Git switch " .. input_text)
							vim.notify("Switch to branch" .. input_text, vim.log.levels.INFO, { title = "Git" })
						end
					end)
				end,
				desc = "Git Branch Switch",
			},
			{
				"<Leader>gbc",
				function()
					vim.ui.input({
						prompt = "What branch would you like create?",
						-- completion = "git branch?",
					}, function(branch_name)
						if branch_name then
							local handle = io.popen("git branch --show-current 2> /dev/null")
							if handle == nil then
								return
							end
							local current_branch = handle:read("*a")
							handle:close()
							vim.ui.input({
								prompt = "What should the parent branch be?",
								default = current_branch,
								-- completion = "git branch?",
							}, function(parent_name)
								vim.cmd("Git branch " .. branch_name .. " " .. parent_name)
								vim.notify("Created new branch" .. branch_name, vim.log.levels.INFO, { title = "Git" })
							end)
						end
					end)
				end,
				desc = "Git Branch Create",
			},
			{
				"<Leader>gbr",
				function()
					local handle = io.popen("git branch --show-current 2> /dev/null")
					if handle == nil then
						return
					end
					local current_branch = handle:read("*a")
					handle:close()

					vim.ui.input({
						prompt = "What would you like to rename the current branch (" .. current_branch .. ") to?",
						-- completion = "git branch?",
					}, function(branch_name)
						if branch_name then
							vim.cmd("Git branch -m" .. branch_name)
							vim.notify(
								"Renamed branch from " .. current_branch .. " to " .. branch_name,
								vim.log.levels.INFO,
								{ title = "Git" }
							)
						end
					end)
				end,
				desc = "Git Branch Rename",
			},
		},

		{ -- Commits
			"<Leader>gc",
			group = "Git Commits",

			{
				"<Leader>gc",
				function()
					vim.ui.input({
						prompt = "What should the commit message be?",
					}, function(input_text)
						if input_text then
							vim.cmd('Git commit -m "' .. input_text .. '"')
							vim.notify("Committed", vim.log.levels.INFO, { title = "Git" })
						end
					end)
				end,
				desc = "Git Commit",
			},
		},
    { -- Fugitive Keymaps
      cond = function()
        return vim.bo.filetype == "fugitive"
      end,
    },
  },
  { -- Notes group
    "<Leader>o",
    group = "Org mode",

    -- Indexes
    {
      "<Leader>oR",
      "<cmd>e ~/Documents/notes/index.org<CR>",
      desc = "Org root index"
    },
    {
      "<Leader>oI",
      function()
        local parent_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h:t")
        vim.cmd("e " .. parent_dir .. ".norg")
      end,
      desc = "Org current dir base"
  },

    -- Journal
    {
      "<Leader>ojw",
      function()
        open_journal("~/Documents/notes/work/journal")       -- adjust to your actual work journal dir
      end,
      desc = "Work journal"
    },
    {
      "<Leader>ojp",
      function()
        open_journal("~/Documents/notes/personal/journal")       -- adjust to your actual work journal dir
      end,
      desc = "Personal journal"
    },
  },
  { -- Diagnostics Group
    "<Leader>d",
    group = "Diagnostics",

		{
			"<Leader>dd",
			function()
				vim.diagnostic.open_float()
			end,
			desc = "Open Diagnostic",
		},
		{ "<Leader>dg", proxy = "[D", desc = "First Diagnostic" },
		{ "<Leader>dG", proxy = "]D", desc = "Last Diagnostic" },
		{
			"<Leader>dn",
			function()
				vim.diagnostic.get_next()
			end,
			desc = "Next Diagnostic",
		},
		{
			"<Leader>dp",
			function()
				vim.diagnostic.get_prev()
			end,
			desc = "Prev Diagnostic",
		},
		{
			"<Leader>dh",
			function()
				vim.diagnostic.hide()
			end,
			desc = "Hide Diagnostics",
		},
		{
			"<Leader>ds",
			function()
				vim.diagnostic.show()
			end,
			desc = "Show Diagnostics",
		},
		{
			"<Leader>dl",
			function()
				vim.cmd("Trouble diagnostics toggle filter.buf=0")
			end,
			desc = "Diagnostics List (Local Buffer)",
		},
		{
			"<Leader>dL",
			function()
				vim.cmd("Trouble diagnostics toggle")
			end,
			desc = "Diagnostics List (Whole Project)",
		},
	},
	{ -- LSP Group
		"<Leader>l",
		group = "LSP",

		{
			"<Leader>lS",
			function()
				vim.cmd("AerialToggle")
			end,
			desc = "List Code Symbols",
		},
		{
			"<Leader>la",
			function()
				vim.lsp.buf.code_action()
			end,
			desc = "Get Code Actions",
		},
		{
			"<Leader>ld",
			function()
				vim.lsp.buf.definition()
			end,
			desc = "Go To Definition",
		},
		{
			"<Leader>lD",
			function()
				vim.lsp.buf.declaration()
			end,
			desc = "Go To Declaration",
		},
		{
			"<Leader>li",
			function()
				vim.lsp.buf.implementation()
			end,
			desc = "Go To Implementation",
		},
		{
			"<Leader>lr",
			function()
				vim.lsp.buf.references()
			end,
			desc = "Go To References",
		},
		{
			"<Leader>lt",
			function()
				vim.lsp.buf.type_definition()
			end,
			desc = "Go To Type Definition",
		},
		{
			"<Leader>lh",
			function()
				vim.lsp.buf.typehierarchy("supertypes")
			end,
			desc = "Show Type Parents",
		},
		{
			"<Leader>lH",
			function()
				vim.lsp.buf.typehierarchy("subtypes")
			end,
			desc = "Show Type Children",
		},
		{
			"<Leader>ls",
			function()
				vim.lsp.buf.signature_help()
			end,
			desc = "Signature Info",
		},
		{
			"<Leader>lR",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Rename All References",
		},
		{
			"<Leader>lF",
			function()
				vim.lsp.buf.format()
			end,
			desc = "Format using LSP",
		},
		{
			"<Leader>lk",
			function()
				vim.lsp.buf.hover()
			end,
			desc = "Hover Info",
		},
		{
			"<Leader>lw",
			function()
				vim.lsp.buf.workspace_diagnostics()
			end,
			desc = "Show Workspace Diagnostics",
		},
		{
			"<Leader>lw",
			function()
				vim.lsp.buf.workspace_diagnostics()
			end,
			desc = "Show Workspace Diagnostics",
		},
	},
	{ -- Linting Group
		"<Leader>L",
		group = "Linter",
		cond = function()
			return package.loaded["lint"] ~= nil
		end,

		{
			"<Leader>LL",
			function()
				require("lint").try_lint()
			end,
			desc = "Run Linters",
		},
	},
	{ -- Formatter Group
		"<Leader>F",
		group = "Formatter",
		cond = function()
			return package.loaded["conform"] ~= nil
		end,

		{
			"<Leader>FF",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Run Formatter",
		},
	},
	{ -- Debugger Group
		"<Leader>D",
		group = "Debugger",
		cond = function()
			return package.loaded["dap"] ~= nil
		end,

		{
			"<Leader>DB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<Leader>Db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<Leader>Dc",
			function()
				require("dap").continue()
			end,
			desc = "Run/Continue",
		},
		{
			"<Leader>Da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<Leader>DC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<Leader>Dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to Line (No Execute)",
		},
		{
			"<Leader>Di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<Leader>Dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<Leader>Dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<Leader>Dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<Leader>Do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<Leader>DO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<Leader>DP",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<Leader>Dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<Leader>Ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<Leader>Dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<Leader>Dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
		{
			"<Leader>Du",
			function()
				require("dapui").toggle({})
			end,
			desc = "Dap UI",
		},
		{
			"<Leader>De",
			function()
				require("dapui").eval()
			end,
			desc = "Eval",
			mode = { "n", "x" },
		},
	},
	{ -- Refactoring Group
		"<Leader>r",
		group = "Refactoring",
		cond = function()
			return package.loaded["refactoring"] ~= nil
		end,
		mode = { "n", "x" },

		{
			"<Leader>re",
			function()
				return require("refactoring").refactor("Extract Function")
			end,
			desc = "Extract Function",
			expr = true,
		},
		{
			"<Leader>rf",
			function()
				return require("refactoring").refactor("Extract Function To File")
			end,
			desc = "Extract Function to File",
		},
		{
			"<Leader>rv",
			function()
				return require("refactoring").refactor("Extract Variable")
			end,
			desc = "Extract Variable",
		},
		{
			"<Leader>rI",
			function()
				return require("refactoring").refactor("Inline Function")
			end,
			desc = "Inline Function",
		},
		{
			"<Leader>ri",
			function()
				return require("refactoring").refactor("Inline Variable")
			end,
			desc = "Inline Variable",
		},
		{
			"<Leader>rbb",
			function()
				return require("refactoring").refactor("Extract Block")
			end,
			desc = "Extract Block",
		},
		{
			"<Leader>rbf",
			function()
				return require("refactoring").refactor("Extract Block to File")
			end,
			desc = "Extract Block to File",
		},
	},
	{ -- Window Group
		"<C-w>",
		group = "Window",
		mode = "n",

		{ "<C-w>-", ":split<CR>", desc = "Split Window Horiz" },
		{ "<C-w>\\", ":vsplit<CR>", desc = "Split Window Vert" },
	},
	{ -- Tab Group
	},
	{ -- Marks Group
		"<Leader>m",
		group = "Marks",
	},
	{ -- Quickfix Group
	},
	{ -- Nvim config
		"<Leader>c",
		group = "Nvim Config",
		mode = "n",

		{
			"<Leader>cdd",
			function()
				vim.ui.input({
					prompt = "cd",
					completion = "dir",
				}, function(dir)
					if dir then
						vim.cmd("cd " .. dir)
					end
				end)
			end,
			desc = "Change Working Directory",
		},
		{
			"<Leader>cdh",
			function()
				vim.cmd("cd %:h")
			end,
			desc = "Change Working Directory Here",
		},
		{
			"<Leader>cd..",
			function()
				vim.cmd("cd ..")
			end,
			desc = "Change Working Directory",
		},
		{
			"<Leader>cf",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config Files",
		},
		{
			"<Leader>cc",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<Leader>cac",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocommands",
		},
		{
			"<Leader>cD",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<Leader>ch",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<Leader>ck",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<Leader>cM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{ "<Leader>cl", "<cmd>Lazy<CR>", desc = "Lazy.nvim" },
		{ "<Leader>cm", "<cmd>Mason<CR>", desc = "Lazy.nvim" },
	},
}

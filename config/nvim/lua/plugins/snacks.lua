return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "󱈹 ", key = "w", desc = "Neorg Workspace", action = "<cmd>Neorg index<CR>" },
          { icon = " ", key = "J", desc = "Neorg Journal", action = "<cmd>Neorg journal today<CR>" },
          {
            icon = "󱈹 ",
            key = "W",
            desc = "Neorg Choose Workspaces",
            action = function()
              local workspace_names = require("neorg").modules.get_module("core.dirman").get_workspace_names()
              vim.ui.select(workspace_names, { prompt = "Select a Neorg workspace" }, function(workspace_name)
                if workspace_name then
                  vim.cmd("Neorg workspace " .. workspace_name)
                end
              end)
            end,
          },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "󰍎", key = "m", desc = "Marks", action = ":lua Snacks.picker.marks()" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
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
      hidden = false,
      ignored = false,
      sources = {
        explorer = {
          layout = {
            layout = {
              preset = "sidebar",
              width = 50,
            },
          },
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

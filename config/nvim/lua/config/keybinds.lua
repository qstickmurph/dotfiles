return {
  { -- Vanilla remaps
    -- Change escape commands
    { "jh", "<esc>", mode="i" },
    { "jh", "<C-C>", mode="i" },

    -- Move lines in visual mode
    { "J", ":m '>+1<CR>gv=gv", mode="v" },
    { "K", ":m '<-2<CR>gv=gv", mode="v" },

    -- Recenter window on page down
    { "<C-d>", "<C-d>zz", mode="n" },
    { "<C-u>", "<C-u>zz", mode="n" },

    -- Copy to clipboard
    { "<leader>y", "\"+y", mode={"n", "v"}, desc="which_key_ignore" },
    { "<leader>Y", "\"+Y", mode="n", desc="which_key_ignore" },
  },

  { -- Root level keybinds
    { "<Leader>?", function() require("which-key").show({ global = false }) end, desc="Buffer Local Keymaps" },
    { "<C-w><Space>", function() require("which-key").show({ loop = true }) end, desc="Buffer Local Keymaps" },
    { "<Leader>:", function() Snacks.picker.command_history() end, desc="Command History" },
    { "<Leader>N", function() Snacks.picker.notifications() end, desc="Notifications" },
    { "<Leader>u", function() Snacks.picker.undo() end, desc="Undo History" },
    { "<Leader>z", function() Snacks.zen() end, desc="Zen Toggle" },
    { "<Leader>Z", function() Snacks.zen.zoom() end, desc="Zen Zoom" },
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash TS" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "TS Search" },
    { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    { "<Leader>S", function() require("spectre").toggle() end, desc="Toggle Spectre" },
  },
  { -- Project/Files Group
    "<Leader>p",
    group="Project/Files",
    mode="n",

    { "<Leader>pp", function() Snacks.picker.projects() end, desc="Projects" },
    { "<Leader>pd", function() Snacks.explorer.open() end, desc="File Explorer" },
    { "<Leader>pf", function() Snacks.picker.files() end, desc="Find Files" },
    { "<Leader>pg", function() Snacks.picker.git_files() end, desc="Find Git Files" },
    { "<Leader>ps", function() Snacks.picker.grep() end, desc="Grep" },
    { "<Leader>pr", function() Snacks.picker.recent({ filter = { cwd=true }}) end, desc="Recent Files" },
  },
  { -- Git Group
    "<Leader>g",
    group="Git",
    mode="n",
    cond = function()
      local handle = io.popen("git rev-parse --is-inside-work-tree 2> /dev/null")
      if handle == nil then
        return
      end
      local result = handle:read("*a")
      handle:close()
      return result ~= ""
    end,

    { "<Leader>gg", "<cmd>Git<CR>", desc="Open Fugitive" },
    { "<Leader>gl", "<cmd>GitBlameToggle<CR>", desc="Toggle Git Blame" },

    { -- Pickers
      "<Leader>gp",
      group="Git Pickers",

      { "<leader>gpb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gpl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gpL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gps", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gpS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gpd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gpf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    },

    { -- Add
      "<Leader>ga",
      group="Git Add",

      {
        "<Leader>ga",
        function()
          vim.ui.input({
            prompt = "What would you like to stage?",
            completion = "file",
          }, function(input_text)
            if input_text then
              vim.cmd("Git add " .. input_text)
              vim.notify("Staged " .. input_text, vim.log.levels.INFO, { title="Git" })
            end
          end)
        end,
        desc="Git Add"
      },
      {
        "<Leader>gaa",
        function()
          vim.cmd("Git add --all")
          vim.notify("Staged all files", vim.log.levels.INFO, { title="Git" })
        end,
        desc="Git Add All"
      },
    },

    { -- Branches
      "<Leader>gb",
      group="Git Branches",

      {
        "<Leader>gbs",
        function()
          vim.ui.input({
            prompt = "What branch would you like to switch to?",
            -- completion = "git branch?",
          }, function(input_text)
            if input_text then
              vim.cmd("Git switch " .. input_text)
              vim.notify("Switch to branch" .. input_text, vim.log.levels.INFO, { title="Git" })
            end
          end)
        end,
        desc="Git Branch Switch"
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
                vim.notify("Created new branch" .. branch_name, vim.log.levels.INFO, { title="Git" })
              end)
            end
          end)
        end,
        desc="Git Branch Create"
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
                  "Renamed branch from "
                    .. current_branch
                    .. " to "
                    .. branch_name,
                  vim.log.levels.INFO,
                  { title="Git" }
                )
            end
          end)
        end,
        desc="Git Branch Rename"
      },
    },

    { -- Commits
      "<Leader>gc",
      group="Git Commits",

      {
        "<Leader>gc",
        function()
          vim.ui.input({
            prompt = "What should the commit message be?",
          }, function(input_text)
            if input_text then
              vim.cmd("Git commit -m" .. input_text)
              vim.notify("Committed", vim.log.levels.INFO, { title="Git" })
            end
          end)
        end,
        desc="Git Commit"
      }
    },

    { -- Fugitive Keymaps
      cond=function() return vim.bo.filetype=="fugitive" end,
    }
  },
  { -- Notes group
    "<Leader>n",
    group="Notes",

    {
      "<Leader>nw",
      function()
        local workspace_names = require("neorg").modules.get_module("core.dirman").get_workspace_names()
        vim.ui.select(
          workspace_names,
          { prompt="Select a Neorg workspace" },
          function(workspace_name)
            vim.cmd("Neorg workspace " .. workspace_name)
          end
        )
      end,
      desc="Neorg Workspace",
    },

    { -- Neorg only commands
      cond=function() return vim.bo.filetype == "norg" end,

      { "<Leader>nr", "<cmd>Neorg index<CR>", desc="Neorg Root" },
      { "<Leader>ni", "<cmd>e index.norg<CR>", desc="Neorg index" },
      { "<Leader>nj", "<cmd>Neorg Journal<CR>", desc="Neorg Today's Journal" },

      { -- Task Actions
        "<Leader>nt",
        group="Task Actions",

        { "<Leader>ntd", "<Plug>(core.qol.todo_items.todo.task_done)", desc="Task Done" },
        { "<Leader>ntu", "<Plug>(core.qol.todo_items.todo.task_undone)", desc="Task Undone" },
        { "<Leader>ntp", "<Plug>(core.qol.todo_items.todo.task_pending)", desc="Task Pending" },
        { "<Leader>nth", "<Plug>(core.qol.todo_items.todo.task_on_hold)", desc="Task On Hold" },
        { "<Leader>ntc", "<Plug>(core.qol.todo_items.todo.task_cancelled)", desc="Task Cancelled" },
        { "<Leader>ntr", "<Plug>(core.qol.todo_items.todo.task_recurring)", desc="Task Recurring" },
        { "<Leader>nti", "<Plug>(core.qol.todo_items.todo.task_important)", desc="Task Important" },
        { "<Leader>ntt", "<Plug>(core.qol.todo_items.todo.task_cycle)", desc="Task Cycle" },
      },

      { -- List Actions
        "<Leader>nl",
        group="List Actions",

        { "<Leader>nlt", "<Plug>(core.pivot.toggle-list-type)", desc="Toggle List Type" },
        { "<Leader>nli", "<Plug>(core.pivot.invert-list-type)", desc="Invert List Type" },
      },

      { "<Leader>j", "<Plug>(core.integrations.treesitter.next.heading)", desc="Next Heading" },
      { "<Leader>k", "<Plug>(core.integrations.treesitter.previous.heading)", desc="Previous Heading" },
      { "<Leader>nn", "<Plug>(core.integrations.treesitter.next.link)", desc="Next Link" },
      { "<Leader>np", "<Plug>(core.integrations.treesitter.previous.link)", desc="Previous Link" },
      { "<Leader>nn", "<Plug>(core.dirman.new.note)", desc="New Note" },
      { "<Leader>nc", "<Plug>(core.looking_glass.magnify_code_block)", desc="Magnify Code Block" },

      {
        "<c-cr>",
        "<cmd>vert split<CR><cmd>wincmd l<CR><cmd>Neorg keybind norg core.esupports.hop.hop-link<CR>",
        desc="Navigate in new pane"
      },
      { "<Leader>nsl", "ciw{:<esc>pi:}[]<esc>P", desc="which_key_ignore" },
      { "j", "gj", desc="which_key_ignore" },
      { "k", "gk", desc="which_key_ignore" },
    }
  },
  { -- Diagnostics Group
    "<Leader>d",
    group="Diagnostics",

    { "<Leader>dd", function() vim.diagnostic.open_float() end, desc="Open Diagnostic" },
    { "<Leader>dg", proxy="[D", desc="First Diagnostic" },
    { "<Leader>dG", proxy="]D", desc="Last Diagnostic" },
    { "<Leader>dn", function() vim.diagnostic.get_next() end, desc="Next Diagnostic" },
    { "<Leader>dp", function() vim.diagnostic.get_prev() end, desc="Prev Diagnostic" },
    { "<Leader>dh", function() vim.diagnostic.hide() end, desc="Hide Diagnostics" },
    { "<Leader>ds", function() vim.diagnostic.show() end, desc="Show Diagnostics" },
    {
      "<Leader>dl",
      function() vim.cmd("Trouble diagnostics toggle filter.buf=0") end,
      desc="Diagnostics List (Local Buffer)"
    },
    { "<Leader>dL", function() vim.cmd("Trouble diagnostics toggle") end, desc="Diagnostics List (Whole Project)" },
  },
  { -- LSP Group
    "<Leader>l",
    group="LSP",

    { "<Leader>lS", function() vim.cmd("AerialToggle") end, desc="List Code Symbols" },
    { "<Leader>la", function() vim.lsp.buf.code_action() end, desc="Get Code Actions" },
    { "<Leader>ld", function() vim.lsp.buf.definition() end, desc="Go To Definition" },
    { "<Leader>lD", function() vim.lsp.buf.declaration() end, desc="Go To Declaration" },
    { "<Leader>li", function() vim.lsp.buf.implementation() end, desc="Go To Implementation" },
    { "<Leader>lr", function() vim.lsp.buf.references() end, desc="Go To References" },
    { "<Leader>lt", function() vim.lsp.buf.type_definition() end, desc="Go To Type Definition" },
    { "<Leader>lh", function() vim.lsp.buf.typehierarchy("supertypes") end, desc="Show Type Parents" },
    { "<Leader>lH", function() vim.lsp.buf.typehierarchy("subtypes") end, desc="Show Type Children" },
    { "<Leader>ls", function() vim.lsp.buf.signature_help() end, desc="Signature Info" },
    { "<Leader>lR", function() vim.lsp.buf.rename() end, desc="Rename All References" },
    { "<Leader>lF", function() vim.lsp.buf.format() end, desc="Format using LSP" },
    { "<Leader>lk", function() vim.lsp.buf.hover() end, desc="Hover Info" },
    { "<Leader>lw", function() vim.lsp.buf.workspace_diagnostics() end, desc="Show Workspace Diagnostics" },
    { "<Leader>lw", function() vim.lsp.buf.workspace_diagnostics() end, desc="Show Workspace Diagnostics" },
  },
  { -- Linting Group
    "<Leader>L",
    group="Linter",
    cond=function()
      return package.loaded["lint"] ~= nil
    end,

    { "<Leader>LL", function() require("lint").try_lint() end, desc="Run Linters" },
  },
  { -- Formatter Group
    "<Leader>F",
    group="Formatter",
    cond=function()
      return package.loaded["conform"] ~= nil
    end,

    { "<Leader>FF", function() require("conform").format({ async=true }) end, desc="Run Formatter" },
  },
  { -- Debugger Group
    "<Leader>D",
    group="Debugger",
    cond=function()
      return package.loaded["dap"] ~= nil
    end,

    {
      "<leader>DB",
      function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = "Breakpoint Condition"
    },
    { "<leader>Db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>Dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>Da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>DC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>Dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>Di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>Dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>Dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>Dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>Do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>DO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>DP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>Dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>Ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>Dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>Dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    { "<leader>Du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>De", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "x"} },
  },
  { -- Refactoring Group
    "<Leader>r",
    group="Refactoring",
    cond=function()
      return package.loaded["refactoring"] ~= nil
    end,


  },
  { -- Window Group
    "<C-w>",
    group="Window",
    mode="n",

    { "<C-w>-", ":split<CR>", desc="Split Window Horiz"},
    { "<C-w>\\", ":vsplit<CR>", desc="Split Window Vert"},
  },
  { -- Nvim config
    "<Leader>c",
    group="Nvim Config",
    mode="n",

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
      desc="Change Working Directory"
    },
    {
      "<Leader>cdh",
      function()
        vim.cmd("cd %:h")
      end,
      desc="Change Working Directory Here"
    },
    {
      "<Leader>cd..",
      function()
        vim.cmd("cd ..")
      end,
      desc="Change Working Directory"
    },
    { "<Leader>cf", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc="Find Config Files" },
    { "<Leader>cc", function() Snacks.picker.commands() end, desc="Commands" },
    { "<Leader>cac", function() Snacks.picker.autocmds() end, desc="Autocommands" },
    { "<Leader>cD", function() Snacks.picker.diagnostics() end, desc="Diagnostics" },
    { "<Leader>ch", function() Snacks.picker.help() end, desc="Help Pages" },
    { "<Leader>ck", function() Snacks.picker.keymaps() end, desc="Keymaps" },
    { "<Leader>cM", function() Snacks.picker.man() end, desc="Man Pages" },
    { "<Leader>cl", "<cmd>Lazy<CR>", desc="Lazy.nvim" },
    { "<Leader>cm", "<cmd>Mason<CR>", desc="Lazy.nvim" },
  },
}

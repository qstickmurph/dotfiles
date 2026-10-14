local lib = require("lib")

-- Testing
local neotest = require("neotest")

local group = vim.api.nvim_create_augroup("ManagerProject", { clear = true })

-- Frontend
local frontendWorktreesSetup = {}
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*/manager/*/web/Gui/*.ts",
  callback = function(args)
    if not lib.in_git_project("manager", args.buf) then
      return
    end

    local buf_path = vim.api.nvim_buf_get_name(args.buf)
    local buf_dir = vim.fs.dirname(buf_path)

    local worktreePath = vim.trim(vim.system({ "git", "-C", buf_dir, "rev-parse", "--show-toplevel" }, { text = true }):wait().stdout)
    if vim.tbl_contains(frontendWorktreesSetup, worktreePath) then
      return
    end
    table.insert(frontendWorktreesSetup, worktreePath)

    neotest.setup_project(worktreePath .. "/web/Gui", {
      adapters = {
        require("neotest-vitest")({
          filter_dir = function(name)
            return name ~= "node_modules" and name ~= "dist"
          end,
        }),
      },
    })
  end
})

-- Backend
local backendWorktreesSetup = {}
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = {
    "*/manager/*/src/*.cs",
    "*/manager/*/tests/*.cs"
  },
  callback = function(args)
    if not lib.in_git_project("manager", args.buf) then
      return
    end

    local buf_path = vim.api.nvim_buf_get_name(args.buf)
    local buf_dir = vim.fs.dirname(buf_path)

    local worktreePath = vim.trim(vim.system({ "git", "-C", buf_dir, "rev-parse", "--show-toplevel" }, { text = true }):wait().stdout)
    if vim.tbl_contains(backendWorktreesSetup, worktreePath) then
      return
    end
    table.insert(backendWorktreesSetup, worktreePath)

    vim.g.neotest_vstest = {
      broad_recursive_discovery = false,
    }

    neotest.setup_project(worktreePath, {
      adapters = {
        require("neotest-vstest")
      },
    })
  end
})

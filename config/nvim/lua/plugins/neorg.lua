local Path = require("pathlib")

local function BufferIsInWorkspaceAndWorktree(buffer) 
  local currentBufferBuftype = vim.api.nvim_get_option_value('buftype', {buf = buffer})
  local currentBufferBufname = vim.api.nvim_buf_get_name(buffer)
  if not (currentBufferBuftype == "" and currentBufferBufname ~= "") then
    return false
  end

  local filePath = Path(currentBufferBufname)
  local neorgWorkspaces = require("neorg").modules.get_module("core.dirman").get_workspaces()
  local neorgWorkspacePaths = vim.tbl_values(neorgWorkspaces)

  local isInWorkspace = vim.tbl_contains(
    neorgWorkspacePaths,
    function (path)
      return filePath:is_relative_to(path)
    end,
    { predicate = true }
  )

  if not(isInWorkspace) then
    return false
  end

  local gitCmd = {
    "git",
    "rev-parse",
    "--is-inside-work-tree",
    "2>/dev/null"
  }
  local isInGitWorktree = vim.system(gitCmd, { cwd = tostring(filePath:parent()), stderr = false }):wait().stdout ~= ""
  if not(isInGitWorktree) then
    return false
  end

  return true
end

return {
  "nvim-neorg/neorg",
  cmd = "Neorg",
  ft = "norg",
  version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "pysan3/pathlib.nvim",
    "benlubas/neorg-interim-ls",
    "benlubas/neorg-conceal-wrap"
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
        ["core.completion"] = {
          config = { engine = { module_name = "external.lsp-completion" } },
        },
        ["external.interim-ls"] = {
          config = {
            -- default config shown
            completion_provider = {
              -- Enable or disable the completion provider
              enable = true,

              -- Show file contents as documentation when you complete a file name
              documentation = true,

              -- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
              categories = false,

              -- suggest heading completions from the given file for `{@x|}` where `|` is your cursor
              -- and `x` is an alphanumeric character. `{@name}` expands to `[name]{:$/people:# name}`
              people = {
                enable = false,

                -- path to the file you're like to use with the `{@x` syntax, relative to the
                -- workspace root, without the `.norg` at the end.
                -- ie. `folder/people` results in searching `$/folder/people.norg` for headings.
                -- Note that this will change with your workspace, so it fails silently if the file
                -- doesn't exist
                path = "people",
              }
            }
          }
        },
        ["external.conceal-wrap"] = {},
      },
    })
    -- Neorg use journal snippet upon entering new journal
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      desc = "Autopopulate neorg journals with journal snippet",
      pattern = "*/journal/*.norg",
      callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

        if line_count > 1 or (first_line ~= "" and first_line ~= nil) then
          return
        end

        vim.api.nvim_buf_set_lines(0, 0, 0, false, { "" })
        vim.api.nvim_win_set_cursor(0, { 1, 0 })

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
      desc = "Setup neorg buffer settings",
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

    -- Auto pull git changes
    vim.api.nvim_create_autocmd({ "BufReadPre" }, {
      desc = "Automatically pull before reading norg files",
      pattern = "*.norg",
      once = true,
      callback = function()
        local currentBuffer = vim.api.nvim_get_current_buf()
        if not(BufferIsInWorkspaceAndWorktree(currentBuffer)) then
          return
        end

        vim.system({ "git", "fetch" }):wait()
        local output = vim.system({ "git", "rev-list", "HEAD..@{u}", "--count" }):wait().stdout
        local behind = tonumber(vim.trim(output))

        if behind and behind > 0 then
          vim.system({ "git", "pull" }):wait()
          vim.notify("Pulled notes changes from origin", vim.log.levels.INFO, { title = "Neorg" })
        end
      end
    })

    -- Auto commit and push neorg changes
    vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
      desc = "Autocommit and push neorg workspace on save",
      pattern = "*.norg",
      callback = function()
        local currentBuffer = vim.api.nvim_get_current_buf()
        if not(BufferIsInWorkspaceAndWorktree(currentBuffer)) then
          return
        end

        local parentDirectory = tostring(Path(vim.api.nvim_buf_get_name(currentBuffer)):parent())

        vim.system({ "git", "add", "--all" }, { cwd = parentDirectory }):wait()
        
        local hasStagedChanges = vim.system({ "git", "diff", "--cached", "--quiet" }, { cwd = parentDirectory }):wait().code ~= 0
        if not(hasStagedChanges) then
          return
        end

        vim.system({ "git", "commit", "-m", "AUTOCOMMIT"}, { cwd = parentDirectory }):wait()

        vim.system(
          { "git", "push"},
          { cwd = parentDirectory },
          function (exit)
            if (exit.code ~= 0) then
              print("Failed to push changes to origin")
            end
              print("Pushed changes to origin")
          end
        )
      end
    });
  end,
}



local Path = require("pathlib")

local function BufferIsInWorktree(buffer) 
  local currentBufferBuftype = vim.api.nvim_get_option_value('buftype', {buf = buffer})
  local currentBufferBufname = vim.api.nvim_buf_get_name(buffer)
  if not (currentBufferBuftype == "" and currentBufferBufname ~= "") then
    return false
  end

  local filePath = Path(currentBufferBufname)

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
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = { '~/Documents/notes/**/*' },
      org_default_notes_file = '~/Documents/notes/inbox.org',
      org_todo_keywords = {
        'TODO(t)',
        'INPROGRESS(i)',
        'NEXT(n)',
        'BLOCKED(b)',
        'SOMEDAY(s)',
        '|',
        'DONE(d)',
        'DELEGATED(e)',
        'DROPPED(r)',
      },
      org_todo_repeat_to_state = 'TODO',
      win_split_mode = 'auto',
      win_border = 'rounded',
      org_startup_folded = 'content',
      org_todo_keyword_faces = {}, -- TODO
      org_archive_location = '~/Documents/notes/archive/%s_archive::',
      org_hide_leading_stars = false,
      org_hide_emphasis_markers = true,
      org_ellipsis = '...',
      org_log_done = 'time',
      org_log_repeat = 'time',
      org_log_into_drawer = nil,
      org_highlight_latex_and_related = 'entities',
      org_startup_indented = true,
      org_adapt_indentation = true,
      org_indent_mode_turns_off_org_adapt_indentation = true,
      org_indent_mode_turns_on_hiding_stars = true,
      -- org_src_window_setup 
      -- org_edit_src_content_indentation
      -- org_edit_src_filetype_map
      -- org_custom_exports
      org_time_stamp_rounding_minutes = 5,
      org_cycle_separator_lines = 2,
      -- org_blank_before_new_entry
      -- org_id_uuid_program
      -- org_id_ts_format
      -- org_id_method
      -- org_id_prefix
      -- org_id_link_to_org_use_id
      -- org_use_property_inheritance
      -- org_babel_default_header_args
      calendar_week_start_day = 1,
      -- emacs_config

      ----- Agenda Settings
      org_deadline_warning_days = 14,
      org_agenda_span = 'week',
      org_agenda_start_on_weekday = 1,
      org_agenda_start_day = nil,
      -- org_agenda_custom_commands
      org_agenda_hide_empty_blocks = false,
      org_agenda_sorting_strategy = {
        agenda = {'time-up', 'priority-down', 'category-keep'},
        todo = {'priority-down', 'category-keep'},
        tags = {'priority-down', 'category-keep'}
      },
      org_agenda_block_separator = '-',
      org_agenda_remove_tags = false,
      org_agenda_time_grid = {
        type = { 'daily', 'today', 'require-timed' },
        times = { 800, 1000, 1200, 1400, 1600, 1800, 2000 },
        time_separator = '┄┄┄┄┄',
        time_label = '┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄'
      },
      org_agenda_use_time_grid = true,
      org_agenda_current_time_string = '<- now -----------------------------------------------',
      org_agenda_show_future_repeats = true,
      org_capture_templates = {
        p = {
          description = "Personal",
          subtemplates = {
            t = {
              description = 'Tasks',
              subtemplates = {
                t = {
                  description = 'TODO',
                  template = '* TODO %?\n %u',
                  target = '~/Documents/notes/personal/todo.org',
                },
                r = {
                  description = 'Recurring',
                  template = '* TODO %?\n %u',
                  target = '~/Documents/notes/personal/todo.org',
                },
                s = {
                  description = 'Someday',
                  template = '* SOMEDAY %?\n %u',
                  target = '~/Documents/notes/personal/todo.org',
                }
              }
            },
            j = {
              description = 'Journal',
              template = '%U\n%?',
              target = '~/Documents/notes/personal/journal/%<%Y-%m-%d>.org',
              headline = '%(local d=os.date("*t");local s="th";local r=d.day%10;if r==1 and d.day~=11 then s="st" elseif r==2 and d.day~=12 then s="nd" elseif r==3 and d.day~=13 then s="rd" end;return os.date("%A, %b ")..d.day..s..os.date(", %Y"))',
            },
            l = {
              description = 'List',
              template = '- %?',
              target = '~/Documents/notes/personal/refile.org',
            },
            c = {
              description = 'List',
              template = '- [ ] %?',
              target = '~/Documents/notes/personal/refile.org',
            },
            h = {
              description = 'Heading',
              template = '* %?',
              target = '~/Documents/notes/personal/refile.org',
            },
            q = {
              description = 'Quick Note',
              template = '%?',
              target = '~/Documents/notes/personal/refile.org',
            },
            u = {
              description = 'URL/Link',
              template = '* %?\n %x\n %u',
              target = '~/Documents/notes/personal/refile.org',
            }
          },
        },
        w = {
          description = "Work",
          subtemplates = {
            t = {
              description = 'Tasks',
              subtemplates = {
                t = {
                  description = 'TODO',
                  template = '* TODO %?\n %u',
                  target = '~/Documents/notes/work/todo.org',
                },
                r = {
                  description = 'Recurring',
                  template = '* TODO %?\n %u',
                  target = '~/Documents/notes/work/todo.org',
                },
                s = {
                  description = 'Someday',
                  template = '* SOMEDAY %?\n %u',
                  target = '~/Documents/notes/work/todo.org',
                }
              }
            },
            j = {
              description = 'Journal',
              template = '%U\n%?',
              target = '~/Documents/notes/work/journal/%<%Y-%m-%d>.org',
              headline = '%(local d=os.date("*t");local s="th";local r=d.day%10;if r==1 and d.day~=11 then s="st" elseif r==2 and d.day~=12 then s="nd" elseif r==3 and d.day~=13 then s="rd" end;return os.date("%A, %b ")..d.day..s..os.date(", %Y"))',
            },
            l = {
              description = 'List',
              template = '- %?',
              target = '~/Documents/notes/work/refile.org',
            },
            c = {
              description = 'List',
              template = '- [ ] %?',
              target = '~/Documents/notes/work/refile.org',
            },
            h = {
              description = 'Heading',
              template = '* %?',
              target = '~/Documents/notes/work/refile.org',
            },
            q = {
              description = 'Quick Note',
              template = '%?',
              target = '~/Documents/notes/work/refile.org',
            },
            u = {
              description = 'URL/Link',
              template = '* %?\n %x\n %u',
              target = '~/Documents/notes/work/refile.org',
            }
          }
        },
      },
      org_agenda_min_height = 16,
      org_priority_highest = 'A',
      org_priority_default = 'C',
      org_priority_lowest = 'F',
      org_agenda_skip_scheduled_if_done = false,
      org_agenda_skip_deadline_if_done = false,
      org_agenda_text_search_extra_files = {},

      ----- Calendar configuration TODO

      ----- Tags configuration
      org_tags_column = 80,
      org_use_tag_inheritance = true,
      org_tags_exclude_from_inheritance = {},

      ----- Mappings
      mappings = {
        global = {
          org_agenda = '<Leader>oa',
          org_capture = '<Leader>oc',
        },
        agenda = {},
        capture = {},
        note = {},
        org = {},
      }
    })

    -- Experimental LSP support
    vim.lsp.enable('org')

    vim.opt.conceallevel = 2

    -- Custom highlighting
    ---- Priorities
    vim.api.nvim_set_hl(0, "@org.priority.highest", { link = "GruvboxRedSign" })
    vim.api.nvim_set_hl(0, "@org.priority.high", { link = "GruvboxOrangeSign" })
    vim.api.nvim_set_hl(0, "@org.priority.default", { link = "GruvboxYellowSign" })
    vim.api.nvim_set_hl(0, "@org.priority.low", { link = "GruvboxBlueSign" })
    vim.api.nvim_set_hl(0, "@org.priority.lowest", { link = "GruvboxPurpleSign" })

    -- Shift Enter for meta return
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'org',
      callback = function()
        vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
          silent = true,
          buffer = true,
        })
      end,
    })

    -- Org use journal snippet upon entering new journal
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      desc = "Autopopulate neorg journals with journal snippet",
      pattern = "*/journal-*/*.org",
      callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

        if line_count > 1 or (first_line ~= "" and first_line ~= nil) then
          return
        end

        vim.api.nvim_buf_set_lines(0, 0, 0, false, { "" })
        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        local ls = require("luasnip")
        local snippets = ls.get_snippets("org")
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
      pattern = "*.org",
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
      pattern = "*.org",
      once = true,
      callback = function()
        local currentBuffer = vim.api.nvim_get_current_buf()
        if not(BufferIsInWorktree(currentBuffer)) then
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
      pattern = "*.org",
      callback = function()
        local currentBuffer = vim.api.nvim_get_current_buf()
        if not(BufferIsInWorktree(currentBuffer)) then
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

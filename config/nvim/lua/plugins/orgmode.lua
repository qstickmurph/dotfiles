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
  dependencies = {
    'pysan3/pathlib.nvim',
    {
      "nvim-orgmode/org-bullets.nvim",
      opts = {
        concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
        symbols = {
          -- list symbol
          list = "•",
          -- headlines can be a list
          headlines = {
            { "◉", "@org.headline.level1.org" },
            { "○", "@org.headline.level2.org" },
            { "✸", "@org.headline.level3.org" },
            { "✿", "@org.headline.level4.org" }
          },
        },
        checkboxes = {
          half = { "", "@org.checkbox.halfchecked" },
          done = { "✓", "@org.keyword.done" },
          todo = { "", "@org.keyword.todo" },
        },
      }
    }
  },
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      ui = {
        input = {
          use_vim_ui = true
        }
      },
      notifications = {
        enabled = true,            -- Set to false to completely turn off notifications
        cron_enabled = false,      -- Keep false if you only want in-editor popups
        repeats = 10,              -- Number of times to repeat the notification
        reminder_time = {10, 5, 0},-- Remind 10 mins, 5 mins, and exactly on time
        deadline_reminder_days = 7,-- Start reminding 7 days before a deadline
        cron_notifier = nil,       -- Used for external notifications (see below)
      },
      org_agenda_files = { '~/Documents/notes/**/*' },
      org_default_notes_file = '~/Documents/notes/inbox.org',
      org_todo_keywords = {
        'TODO(t)',
        'INPROGRESS(i)',
        'NEXT(n)',
        'BLOCKED(b)',
        'SOMEDAY(s)',
        'APPT(a)',
        '|',
        'DONE(d)',
        'DELEGATED(e)',
        'DROPPED(r)',
      },
      org_todo_repeat_to_state = 'TODO',
      win_split_mode = 'auto',
      win_border = 'rounded',
      org_startup_folded = 'content',
      org_todo_keyword_faces = {
        TODO = ':foreground #fb4934 :weight bold',
        INPROGRESS = ':foreground #b8bb26 :weight bold :underline on',
        NEXT = ':foreground #fabd2f :weight bold',
        BLOCKED = ':foreground #fe8019 :slant italic',
        SOMEDAY = ':foreground #8ec07c :slant italic',
        APPT = ':foreground #d3869b',
        DONE = ':foreground #928374',
        DELEGATED = ':foreground #928374 :slant italic :background #3c3836',
        DROPPED = ':foreground #928374',
      },
      org_archive_location = '~/Documents/notes/archive/%s_archive::',
      org_hide_leading_stars = false,
      org_hide_emphasis_markers = true,
      org_ellipsis = '...',
      org_log_done = 'time',
      org_log_repeat = 'time',
      org_log_into_drawer = 'LOGBOOK',
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
        type = { 'daily', 'today', 'remove-match', 'remove-range-match' },
        times = { 800, 1000, 1200, 1400, 1600, 1800, 2000 },
        time_separator = '┄┄┄┄┄',
        time_label = '┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄'
      },
      org_agenda_use_time_grid = true,
      org_agenda_current_time_string = '<- now -----------------------------------------------',
      org_agenda_show_future_repeats = true,
      org_capture_templates = {
        l = {
          description = 'List',
          template = '- %?',
          target = '~/Documents/notes/inbox.org',
        },
        c = {
          description = 'List',
          template = '- [ ] %?',
          target = '~/Documents/notes/inbox.org',
        },
        h = {
          description = 'Heading',
          template = '* %?\n:PROPERTIES:\n:CREATED: %U\n:END:',
          target = '~/Documents/notes/inbox.org',
        },
        q = {
          description = 'Quick Note',
          template = '%?',
          target = '~/Documents/notes/inbox.org',
        },
        u = {
          description = 'URL/Link',
          template = '* %?\n %x\n:PROPERTIES:\n:CREATED: %U\n:END:',
          target = '~/Documents/notes/inbox.org',
        },
        t = {
          description = "Task",
          subtemplates = {
            t = {
              description = 'TOOD',
              template = '* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:',
              target = '~/Documents/notes/inbox.org',
            },
            s = {
              description = 'Scheduled Task',
              template = '* TODO %?\n  SCHEDULED: %^t\n  %u',
              target = '~/Documents/notes/inbox.org',
            },
            l = {
              description = 'Deadline Task',
              template = '* TODO %?\n  SCHEDULED: %^t\n  %u',
              target = '~/Documents/notes/inbox.org',
            },
            o = {
              description = 'SOMEDAY',
              template = '* SOMEDAY %?\n:PROPERTIES:\n:CREATED: %U\n:END:',
              target = '~/Documents/notes/inbox.org',
            },
            a = {
              description = 'Daily Task',
              template = '* TODO %?\n  SCHEDULED: <%<%Y-%m-%d %a> +1d>\n  %u',
              target = '~/Documents/notes/inbox.org',
            },
            w = {
              description = 'Weekly Task',
              template = '* TODO %?\n  SCHEDULED: <%<%Y-%m-%d %a> +1w>\n  %u',
              target = '~/Documents/notes/inbox.org',
            },
            m = {
              description = 'Monthly Task',
              template = '* TODO %?\n  SCHEDULED: <%<%Y-%m-%d %a> +1m>\n  %u',
              target = '~/Documents/notes/inbox.org',
            },
          }
        },
        j = {
          description = "Journal",
          subtemplates = {
            p = {
              description = 'Personal Journal',
              template = '* %?',
              headline = "Notes",
              target = '~/Documents/notes/journal-personal/%<%Y-%m-%d>.org',
            },
            w = {
              description = 'Work Journal',
              template = '* %?',
              headline = "Notes",
              target = '~/Documents/notes/journal-work/%<%Y-%m-%d>.org',
            }
          }
        }
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
        agenda = {
          org_agenda_preview = '<Leader>oak'
        },
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
    vim.api.nvim_set_hl(0, "@org.priority.lowest", { fg = "#d3869b", bg = "#3c3836", italic = true })
    vim.api.nvim_set_hl(0, "@org.priority.low", { fg = "#83a598", bg = "#3c3836", italic = true })
    vim.api.nvim_set_hl(0, "@org.priority.default", { fg = "#fabd2f", bg = "#3c3836" })
    vim.api.nvim_set_hl(0, "@org.priority.high", { fg = "#fe8019", bg = "#3c3836", bold = true })
    vim.api.nvim_set_hl(0, "@org.priority.highest", { fg = "#fb4934", bg = "#3c3836", bold = true, underline = true })

    ---- Agenda
    vim.api.nvim_set_hl(0, "@org.agenda.day", { link = "GruvboxGreen" })
    vim.api.nvim_set_hl(0, "@org.agenda.scheduled", { link = "GruvboxBlue" })
    vim.api.nvim_set_hl(0, "@org.agenda.deadline", { link = "GruvboxRed" })
    vim.api.nvim_set_hl(0, "@org.agenda.time_grid", { link = "GruvboxGray" })

    ---- Headlines
    vim.api.nvim_set_hl(0, "@org.headline.level1.org", { link = "GruvboxRed" })
    vim.api.nvim_set_hl(0, "@org.headline.level2.org", { link = "GruvboxOrange" })
    vim.api.nvim_set_hl(0, "@org.headline.level3.org", { link = "GruvboxYellow" })
    vim.api.nvim_set_hl(0, "@org.headline.level4.org", { link = "GruvboxGreen" })
    vim.api.nvim_set_hl(0, "@org.headline.level5.org", { link = "GruvboxAqua" })
    vim.api.nvim_set_hl(0, "@org.headline.level6.org", { link = "GruvboxBlue" })
    vim.api.nvim_set_hl(0, "@org.headline.level7.org", { link = "GruvboxPurple" })
    vim.api.nvim_set_hl(0, "@org.headline.level8.org", { link = "GruvboxGray" })

    ---- Keywords
    vim.api.nvim_set_hl(0, "@org.keyword.face.DROPPED.org", { strikethrough = true })

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

        vim.opt_local.wrap = false
        vim.opt_local.linebreak = false
        vim.opt.colorcolumn = "80"

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

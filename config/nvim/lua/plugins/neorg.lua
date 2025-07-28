return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},
                ["core.journal"] = {
                    config = {
                        strategy = "flat",
                    }
                },
                ["core.concealer"] = {
                    config = {
                        icons = {
                            code_block = { conceal = true },
                            todo = {
                                undone = { icon = " " },
                            }
                        }
                    }
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            personal = "~/Documents/notes/personal",
                            work = "~/Documents/notes/work",
                        },
                        default_workspace = "personal"
                    }
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                        name = "[Neorg]",
                    }
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            -- core.qol.todo_items
                            keybinds.remap_event("norg", "n", "<Leader>ntd", "core.qol.todo_items.todo.task_done")
                            keybinds.remap_event("norg", "n", "<Leader>ntu", "core.qol.todo_items.todo.task_undone")
                            keybinds.remap_event("norg", "n", "<Leader>ntp", "core.qol.todo_items.todo.task_pending")
                            keybinds.remap_event("norg", "n", "<Leader>nth", "core.qol.todo_items.todo.task_on_hold")
                            keybinds.remap_event("norg", "n", "<Leader>ntc", "core.qol.todo_items.todo.task_cancelled")
                            keybinds.remap_event("norg", "n", "<Leader>ntr", "core.qol.todo_items.todo.task_recurring")
                            keybinds.remap_event("norg", "n", "<Leader>nti", "core.qol.todo_items.todo.task_important")
                            keybinds.remap_event("norg", "n", "<Leader>ntt", "core.qol.todo_items.todo.task_cycle")

                            -- core.integrations.treesitter
                            keybinds.remap_event("norg", "n", "<Leader>j", "core.integrations.treesitter.next.heading")
                            keybinds.remap_event("norg", "n", "<Leader>k", "core.integrations.treesitter.previous.heading")
                            -- keybinds.remap_event("norg", "n", "<Leader>nj", "core.integrations.treesitter.next.link")
                            -- keybinds.remap_event("norg", "n", "<Leader>nk", "core.integrations.treesitter.previous.link")

                            -- core.dirman
                            keybinds.remap_event("norg", "n", "<Leader>nn", "core.dirman.new.note")

                            -- core.pivot
                            keybinds.remap_event("norg", "n", "<Leader>nlt", "core.pivot.toggle-list-type")
                            keybinds.remap_event("norg", "n", "<Leader>nli", "core.pivot.invert-list-type")

                            -- core.looking-glass
                            keybinds.remap_event("norg", "n", "<Leader>nc", "core.looking_glass.magnify_code_block")

                            -- Navigation commands
                            keybinds.remap("norg", "n", "<Leader>nI", "<cmd>Neorg index<CR>")
                            keybinds.remap("norg", "n", "<Leader>ni", "<cmd>e index.norg<CR>")
                            keybinds.remap("norg", "n", "<c-cr>", "<cmd>vert split<CR><cmd>wincmd l<CR><cmd>Neorg keybind norg core.esupports.hop.hop-link<CR>")

                            -- Stylize Word
                            keybinds.remap("norg", "n", "<Leader>nsi", "ciw//<esc>P")
                            keybinds.remap("norg", "n", "<Leader>nsb", "ciw**<esc>P")
                            keybinds.remap("norg", "n", "<Leader>nsu", "ciw__<esc>P")
                            keybinds.remap("norg", "n", "<Leader>nss", "ciw--<esc>P")
                            keybinds.remap("norg", "n", "<Leader>nsp", "ciw!!<esc>P")
                            keybinds.remap("norg", "n", "<Leader>nsc", "ciw``<esc>P")
                            keybinds.remap("norg", "n", "<Leader>nsm", "ciw$$<esc>P")
                            keybinds.remap("norg", "n", "<Leader>nsv", "ciw%%<esc>P")

                            -- Stylize Range (Visual)
                            -- TODO LATER

                            -- Auto /Links/
                            -- TODO LATER
                            keybinds.remap("norg", "n", "<Leader>nsl", "ciw{:<esc>pi:}[]<esc>P")

                            -- Navigation
                            keybinds.remap("norg", "n", "j", "gj")
                            keybinds.remap("norg", "n", "k", "gk")

                            -- Journal
                            keybinds.remap("norg", "n", "<Leader>nj", "<cmd>Neorg journal today<CR>")

                        end
                    }
                }
            }
        }
        vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
            pattern = "*.norg",
            callback = function(ev)
                vim.opt_local.wrap = true;
                vim.opt_local.linebreak = true;
                vim.opt.colorcolumn = "144";
                vim.opt.foldlevel = 3;

                vim.opt.tabstop = 1;
                vim.opt.softtabstop = 1;
                vim.opt.shiftwidth = 1;
                vim.opt.expandtab = true;

                vim.opt.smartindent = true;

                vim.opt.autochdir = true;

                vim.opt.breakindent = true;
            end
        })
    end
}

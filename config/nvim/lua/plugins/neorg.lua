return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
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
                        default_workspace = "work"
                    }
                },
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

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
	"windwp/nvim-autopairs",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
    },
    config = function ()
        local cmp = require("cmp")
	cmp.setup({
	    snippet = {
	        expand = function(args)
		    vim.fn["vsnip#anonymous"](args.body)
		end,
	    },
	    window = {
	        completion = cmp.config.window.bordered(),
        	documentation = cmp.config.window.bordered(),
	    },
	    mapping = cmp.mapping.preset.insert({
	        ['<C-p>'] = cmp.mapping.scroll_docs(-4),
	        ['<C-n>'] = cmp.mapping.scroll_docs(4),
	        ['<C-Space>'] = cmp.mapping.complete(),
	        ['<C-e>'] = cmp.mapping.abort(),
	        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	    }),
	    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	      	{ name = 'vsnip' },
	    }, {
	        { name = 'buffer' },
	    }),
	    enabled = function ()
                local context = require('cmp.config.context')

		if vim.api.nvim_get_mode().mode == 'c' then
		    return true
		else
		    return not context.in_treesitter_capture("comment")
			and not context.in_syntax_group("Comment")
		end
	    end
	})

	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	cmp.event:on(
	    'confirm_done',
	    cmp_autopairs.on_confirm_done()
	)

	cmp.setup.filetype('gitcommit', {
	    mapping = cmp.mapping.preset.cmdline(),
	    sources = cmp.config.sources({
	    	{ name = 'git' }
	    }, {
	        { name = 'buffer' }
	    })
	})

	cmp.setup.cmdline({ '/', '?' }, {
	    mapping = cmp.mapping.preset.cmdline(),
	    sources = {
		{ name = 'buffer' }
	    }
	})

        cmp.setup.cmdline(':', {
	    mapping = cmp.mapping.preset.cmdline(),
	    sources = cmp.config.sources({
	      { name = 'path' }
	    }, {
	      { name = 'cmdline' }
	    })
	})
    end
}

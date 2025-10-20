return {
    "neovim/nvim-lspconfig",
    config = function ()
      vim.api.nvim_set_keymap("n", "<Leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>GD", "<cmd>vsplit | lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>Gd", "<cmd>vsplit | vlua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>Gi", "<cmd>vsplit | lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>Gr", "<cmd>vsplit | lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
    end
}

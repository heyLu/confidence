-- looks
vim.api.nvim_command('colorscheme peachpuff')
vim.api.nvim_command('set number')

-- fast navigation with fzf
vim.api.nvim_set_keymap('n', '<Leader>q', [[ <Cmd>b#<CR> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>b', [[ <Cmd>Buffers<CR> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>e', [[ <Cmd>Files<CR> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>s', [[ <Cmd>Ag<CR> ]], {noremap = true})

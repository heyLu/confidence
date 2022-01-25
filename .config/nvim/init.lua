-- looks
vim.api.nvim_command('colorscheme peachpuff')
vim.api.nvim_command('set number')

-- highlight character that was jumped to correctly after lightspeed motions (https://github.com/ggandor/lightspeed.nvim/issues/66#issuecomment-952888479)
vim.cmd[[highlight Cursor ctermfg=NONE ctermbg=NONE cterm=reverse]] 

-- fast navigation with fzf
vim.api.nvim_set_keymap('n', '<Leader>q', [[ <Cmd>b#<CR> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>b', [[ <Cmd>Buffers<CR> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>e', [[ <Cmd>Files<CR> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>s', [[ <Cmd>Ag<CR> ]], {noremap = true})

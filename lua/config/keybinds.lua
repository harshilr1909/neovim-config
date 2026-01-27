vim.g.mapleader = " "
vim.keymap.set("n","<leader>cd", vim.cmd.Ex)
vim.keymap.set("n","K",vim.lsp.buf.hover,{})
vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursorr'
vim.keymap.set("n","<C-u>","<C-u>zz",{silent = true, noremap = true})
vim.keymap.set("n","<C-d>","<C-d>zz",{silent = true, noremap = true})


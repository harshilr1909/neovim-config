vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.guifont = "CaskaydiaCove Nerd Font:h14"
vim.api.nvim_set_hl(0,"CursorLine",{bg = "#222222"})
vim.opt.shiftwidth = 4

-- Encoding
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"

-- Netrw settings
vim.g.netrw_browse_split = 0   -- Open files in the same window
vim.g.netrw_winsize = 25       -- Initial window size
vim.g.netrw_altv = 1           -- Open splits to the right


vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10

-- Fix for Neovim 0.12 double trigger on Enter/Backspace in Alacritty
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.env.TERM == "alacritty" then
            io.stdout:write("\27[<u")
        end
    end,
})


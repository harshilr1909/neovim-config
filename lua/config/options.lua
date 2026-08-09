vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.guifont = "CaskaydiaCove Nerd Font:h14"
vim.api.nvim_set_hl(0,"CursorLine",{bg = "#222222"})
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = "80"

-- Line wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "

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

-- Workaround: guard vim.snippet autocommands against nil _session (Neovim core bug)
-- Ref: vim/snippet.lua - "attempt to index field '_session' (a nil value)"
local snippet_group_id = vim.api.nvim_create_augroup('nvim.snippet', { clear = false })
local original_create_autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd = function(event, opts)
    if opts and (opts.group == snippet_group_id or opts.desc == 'Update snippet state when the cursor moves' or opts.desc == 'Update active tabstops when buffer text changes') then
        local original_callback = opts.callback
        if type(original_callback) == 'function' then
            opts.callback = function(...)
                if not vim.snippet or not vim.snippet._session then
                    return true -- deletes the autocommand automatically
                end
                local success, result = pcall(original_callback, ...)
                if not success then
                    if result and string.find(result, "_session") then
                        return true
                    end
                    error(result)
                end
                return result
            end
        end
    end
    return original_create_autocmd(event, opts)
end

-- Fix for Neovim 0.12 double trigger on Enter/Backspace in Alacritty
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.env.TERM == "alacritty" then
            io.stdout:write("\27[<u")
        end
    end,
})


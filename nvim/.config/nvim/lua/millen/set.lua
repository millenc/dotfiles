-- simulate the space being the leader key as in spacemacs
vim.g.mapleader = " "

-- line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- statusline
function SetWindowStatusline()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local win_num = vim.api.nvim_win_get_number(win)
    vim.api.nvim_win_set_option(win, "statusline", string.format("w:%d | %s %%m %%r %%= %%l,%%c %%p%%%%", win_num, vim.fn.expand("%f")))
  end
end

-- Automatically set the statusline when opening or switching windows
vim.api.nvim_create_autocmd({"WinEnter", "BufEnter", "VimResized"}, {
  callback = SetWindowStatusline
})

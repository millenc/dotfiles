local harpoon = require('harpoon')
local telescope_builtin = require('telescope.builtin')

-- general
vim.keymap.set("n", "<leader><leader>", telescope_builtin.commands, { desc = "Lists all commands" })
vim.keymap.set("n", "<leader>kk", telescope_builtin.keymaps, { desc = "Lists all keymaps" })
vim.keymap.set("n", "<leader>so", vim.cmd.so, { desc = "Sources (reloads) the current file" })
vim.keymap.set("n", "<leader>qq", "<cmd>silent! xa<cr><cmd>qa<cr>", { desc = "Save all and quit" })

-- help
vim.keymap.set("n", "<leader>ht", telescope_builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>hm", telescope_builtin.man_pages, { desc = "Man pages" })

-- browse files with Ex and telescope
vim.keymap.set("n", "<leader>pn", vim.cmd.Ex, { desc = "Open file browser (netrw)" })
vim.keymap.set("n", "<leader>pt", ":Telescope file_browser<CR>", { desc = "Open file browser (telescope)" })
vim.keymap.set('n', '<leader>pf', telescope_builtin.find_files, { desc = "Find project files (all)" })
vim.keymap.set('n', '<leader>ph', telescope_builtin.git_files, { desc = "Fing project files (git)" })

-- files
vim.keymap.set("n", "<leader>fs", vim.cmd.w, { desc = "Save file" })
vim.keymap.set("n", "<leader>fr", telescope_builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fa", function() harpoon:list():add() end, { desc = "Add file to the Harpoon list" })
vim.keymap.set("n", "<leader>fh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon files" })
vim.keymap.set("n", "<leader>fz", function() harpoon:list():remove() end, { desc = "Remove file to the Harpoon list" })
vim.keymap.set("n", "<leader>f1", function() harpoon:list():select(1) end, { desc = "Harpoon 1st file" })
vim.keymap.set("n", "<leader>f2", function() harpoon:list():select(2) end, { desc = "Harpoon 2nd file" })
vim.keymap.set("n", "<leader>f3", function() harpoon:list():select(3) end, { desc = "Harpoon 3rd file" })
vim.keymap.set("n", "<leader>f4", function() harpoon:list():select(4) end, { desc = "Harpoon 4th file" })

-- buffers
vim.keymap.set('n', '<leader>bb', telescope_builtin.buffers, { desc = 'List all buffers' })
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious, { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bt", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Open file browser (under current buffer)" })
vim.keymap.set("n", "<leader>bY", ":%y<CR>", { desc = "Yank buffer" })
vim.keymap.set("n", "<leader>bP", "gg0vGP", { desc = "Replace yanked buffer" })

-- windows
vim.keymap.set("n", "<leader>wv", "<C-w>v<C-w>l", { desc = "Create a new window (vertical)" })
vim.keymap.set("n", "<leader>ws", "<C-w>s<C-w>j", { desc = "Create a new window (horizontal)" })
vim.keymap.set("n", "<leader>wd", "<C-w>q", { desc = "Close a window" })
vim.keymap.set("n", "<leader>wm", "<C-w>o", { desc = "Maximize window" })
vim.keymap.set("n", "<leader>wn", "<C-w>n", { desc = "Create a new window and start editing" })

vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to the window on the left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to the window below" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to the window above" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to the window on the right" })

-- search
vim.keymap.set('n', '<leader>sp', telescope_builtin.live_grep, { desc = 'Search current working directory' })
vim.keymap.set('n', '<leader>sh', telescope_builtin.search_history, { desc = 'Search history' })
vim.keymap.set('n', '<leader>ss', telescope_builtin.current_buffer_fuzzy_find, { desc = 'Swoop' })
vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = 'Searches string under current word' })
vim.keymap.set("n", "<leader>sc", vim.cmd.noh, { desc = "Clear highlighted text (search)"})

-- git
vim.keymap.set('n', '<leader>gs', telescope_builtin.git_status, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gl', telescope_builtin.git_commits, { desc = 'Git log' })
vim.keymap.set('n', '<leader>gf', telescope_builtin.git_bcommits, { desc = 'Git log (file)' })
vim.keymap.set('n', '<leader>gb', telescope_builtin.git_branches, { desc = 'Git branches' })

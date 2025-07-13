require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "Theme switcher" })

-- Visual mode line movement
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Markdown rendering controls
map("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Rendering" })
map("n", "<leader>me", "<cmd>RenderMarkdown enable<CR>", { desc = "Enable Markdown Rendering" })
map("n", "<leader>md", "<cmd>RenderMarkdown disable<CR>", { desc = "Disable Markdown Rendering" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

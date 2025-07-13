local wk = require("which-key")

-- Group definitions for which-key
wk.add({
  { "<leader>t", group = "Theme" },
  { "<leader>m", group = "Markdown" },
  { "<leader>c", group = "Claude Code" },
  -- Add more groups here as needed
  -- { "<leader>g", group = "Git" },
  -- { "<leader>f", group = "Find" },
  -- { "<leader>l", group = "LSP" },
})
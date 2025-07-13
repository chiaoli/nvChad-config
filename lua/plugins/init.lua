return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = nil,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    event = "BufRead",
    config = function()
      require("hop").setup()
      -- Advanced hop keymaps with directions and line-only mode
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      local opts = { remap = true, silent = true }
      
      -- Basic hop commands
      vim.keymap.set("n", "s", ":HopChar1<cr>", opts)
      vim.keymap.set("n", "S", ":HopWord<cr>", opts)
      
      -- Enhanced f/F/t/T with hop for current line only
      vim.keymap.set("", "f", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", "t", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set("", "T", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
      
      -- Visual mode line hopping
      vim.keymap.set("x", "f", "<cmd>HopLine<cr>", opts)
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        surrounds = {
          -- Add custom surrounds here
          ["("] = {
            add = { "(", ")" },
            find = function()
              return require("nvim-surround.config").get_selection({ motion = "a(" })
            end,
            delete = "^(.)().-(.)()$",
          },
          [")"] = {
            add = { "( ", " )" },
            find = function()
              return require("nvim-surround.config").get_selection({ motion = "a)" })
            end,
            delete = "^(. ?)().-(.? ?)()$",
          },
        },
      })
    end,
  },

  -- UFO folding dependencies
  {
    "kevinhwang91/promise-async",
    lazy = true,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",
    config = function()
      -- Configure fold options
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)

      -- Option 1: coc.nvim as LSP client
      -- use('neoclide/coc.nvim', {branch = 'release'})
      -- require('ufo').setup()
      --
      -- Option 2: nvim lsp as LSP client
      -- Use treesitter as main provider to avoid LSP conflicts
      require('ufo').setup({
          provider_selector = function(bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
          end
      })
    end,
    keys = {
      { "zR", desc = "Open all folds" },
      { "zM", desc = "Close all folds" },
      { "zr", desc = "Open folds except kinds" },
      { "zm", desc = "Close folds with" },
    },
  },

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {
          '<C-u>', '<C-d>',
          '<C-b>', '<C-f>',
          '<C-y>', '<C-e>',
          'zt', 'zz', 'zb',
        },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false,    -- Disable "Performance Mode" on all buffers.
      })
      
      -- Custom scroll mappings with different speeds
      local neoscroll = require('neoscroll')
      local keymap = {
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
        ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end;
        ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end;
        ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
        ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
        ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end;
        ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end;
        ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end;
      }
      local modes = { 'n', 'v', 'x' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },

  {
    "gbprod/cutlass.nvim",
    event = "VeryLazy",
    config = function()
      require("cutlass").setup({
        cut_key = "m",
        override_del = true,  -- Override the default 'd' behavior
        exclude = {},         -- Exclude certain filetypes
        registers = {
          select = "_",       -- Use blackhole register for deletes
          delete = "_",       -- Use blackhole register for deletes
          change = "_",       -- Use blackhole register for changes
        }
      })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 
      "nvim-tree/nvim-web-devicons" -- Optional: for file icons
    },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        -- 標題渲染設定
        heading = {
          enabled = true,
          sign = true,
          position = "overlay",
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg", 
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          foregrounds = {
            "RenderMarkdownH1",
            "RenderMarkdownH2",
            "RenderMarkdownH3", 
            "RenderMarkdownH4",
            "RenderMarkdownH5",
            "RenderMarkdownH6",
          },
        },
        -- 段落設定
        paragraph = {
          enabled = true,
          left_margin = 0,
          min_width = 0,
        },
        -- 核取方塊設定
        checkbox = {
          enabled = true,
          position = "inline",
          unchecked = { icon = "󰄭 ", highlight = "RenderMarkdownUnchecked" },
          checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
          custom = {
            todo = { raw = "[>]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
          },
        },
        -- 引用塊設定
        quote = {
          enabled = true,
          icon = "▋",
          repeat_linebreak = false,
          highlight = "RenderMarkdownQuote",
        },
        -- 程式碼區塊設定
        code = {
          enabled = true,
          sign = false,
          style = "full",
          position = "left",
          language_pad = 0,
          disable_background = { "diff" },
          width = "full",
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
          border = "thin",
          above = "▄",
          below = "▀",
          highlight = "RenderMarkdownCode",
          highlight_inline = "RenderMarkdownCodeInline",
          highlight_language = "RenderMarkdownCodeLanguage",
        },
        -- 列表設定
        bullet = {
          enabled = true,
          icons = { "●", "○", "◆", "◇" },
          ordered_icons = {},
          left_pad = 0,
          right_pad = 0,
          highlight = "RenderMarkdownBullet",
        },
        -- 連結設定
        link = {
          enabled = true,
          image = "󰥶 ",
          email = "󰀓 ",
          hyperlink = "󰌹 ",
          highlight = "RenderMarkdownLink",
          custom = {
            web = { pattern = "^http[s]?://", icon = "󰖟 " },
            youtube = { pattern = "youtube%.com", icon = "󰗃 " },
            github = { pattern = "github%.com", icon = "󰊤 " },
          },
        },
        -- 表格設定
        table = {
          enabled = true,
          style = "full",
          cell = "padded",
          border = {
            "┌", "┬", "┐",
            "├", "┼", "┤", 
            "└", "┴", "┘",
            "│", "─",
          },
          alignment_indicator = "━",
          head = "RenderMarkdownTableHead",
          row = "RenderMarkdownTableRow",
          filler = "RenderMarkdownTableFill",
        },
        -- 分隔線設定
        dash = {
          enabled = true,
          icon = "─",
          width = "full",
          highlight = "RenderMarkdownDash",
        },
        -- 打字模式設定
        pipe_table = {
          enabled = true,
          preset = "none",
          style = "full",
          cell = "padded",
          alignment_indicator = "━",
          border = {
            "┌", "┬", "┐",
            "├", "┼", "┤",
            "└", "┴", "┘", 
            "│", "─",
          },
          head = "RenderMarkdownTableHead",
          row = "RenderMarkdownTableRow",
          filler = "RenderMarkdownTableFill",
        },
        -- 呼叫塊設定
        callout = {
          note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
          tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
          important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
          warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
          caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
          abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
          summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
          tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
          info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
          todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
          hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
          success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
          check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
          done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
          question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
          help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
          faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
          attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
          failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
          fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
          missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
          danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
          error = { raw = "[!ERROR]", rendered = "󰅖 Error", highlight = "RenderMarkdownError" },
          bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
          example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
          quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
          cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
        },
        -- 自定義處理程序
        custom_handlers = {},
      })
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}

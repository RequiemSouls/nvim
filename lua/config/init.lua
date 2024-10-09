require("config.lazy")
require("config.commonkeys")
require("config.options")

require("lazy").setup({
  spec = {
    { import = "plugins"},
    -- projectile
    {
      "nvim-telescope/telescope.nvim",
      keys = { 
        {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files"},
        {"<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "recent files"},
        {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "buffers"},
        {"<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "find in project"},
        {"<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "find in buffer"},
        {"<leader>pf", "<cmd>Telescope git_files<cr>", desc = "git files"},
      },
      dependencies = {
        "nvim-lua/plenary.nvim"
      }
    },
    {
      "windwp/nvim-autopairs",
      config = true,
      event = "InsertEnter"
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = {"lua_ls", "clangd"}
        })
        require("lspconfig").clangd.setup({})
      end,
    },
    {
      "folke/which-key.nvim"
    },
    {
      "tpope/vim-fugitive",
      cmd = "Git",
      keys = {
        {"<leader>gg", "<cmd>Git<cr>", desc = "fugitive"}
      }
    },
    {
      "lewis6991/gitsigns.nvim",
      config = true
    }
  },
  install = {colorscheme = {"habamax"}},
  checker = {enabled = true},
})

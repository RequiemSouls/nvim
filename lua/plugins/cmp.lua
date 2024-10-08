return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {name = "buffer"}
        }
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {name = "cmdline"}
        }
      })
      
      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<CR>'] = cmp.mapping.confirm({select = true}),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {"i", "s"}),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {"i", "s"})
        }),
        sources = cmp.config.sources({
          {name = "luasnip"},
          {name = "nvim_lsp"},
          {name = "nvim_lua"},
          {name = "path"},
          {name = "buffer"},
        }),
        formatting = {
          fields = { 'abbr', "menu"},
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[Lsp]",
              luasnip = "[Luasnip]",
              buffer = "[File]",
              path = "[Path]",
              cmdline = "[CMD]",
              nvim_lua = "[nvim_lua]",
            })[entry.source.name]
            return vim_item
          end
        },
      }
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      }
    },
  }
}

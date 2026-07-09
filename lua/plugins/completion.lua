return {
    -- Snippet Engine
  {
    "L3MON4D3/LuaSnip",
    enabled=false,
    dependencies = {
      -- VS Code style snippets library
      "rafamadriz/friendly-snippets",
      -- Autocomplete integration
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local luasnip = require("luasnip")
      
      -- Load VS Code snippets (including friendly-snippets and custom JSON templates)
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Extend React snippets to work in plain JS/TS files besides JSX/TSX
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      luasnip.filetype_extend("typescript", { "typescriptreact" })
    end,
  },



    {


        "hrsh7th/nvim-cmp",


        event = "InsertEnter",


        dependencies = {


            "hrsh7th/cmp-nvim-lsp",


            "hrsh7th/cmp-path",


            "hrsh7th/cmp-buffer",


        },
        config = function()


            local cmp = require("cmp")





            cmp.setup({
                enabled = function() return vim.bo.filetype ~= "netrw" end,
                preselect = cmp.PreselectMode.Item, -- <— preselect first item

                completion = { completeopt = "menu,menuone,noinsert" },


                window = { documentation = cmp.config.window.bordered() },

                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },


                mapping = cmp.mapping.preset.insert({


                    ["<CR>"]      = cmp.mapping.confirm({ select = false }),


                    ["<C-e>"]     = cmp.mapping.abort(),


                    ["<C-Space>"] = cmp.mapping.complete(), -- manual trigger if you want it


                    ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),


                    ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),


                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),


                    ["<C-u>"]     = cmp.mapping.scroll_docs(-4),


                    ["<Tab>"]     = cmp.mapping(function(fallback)


                        if cmp.visible() then cmp.select_next_item() else fallback() end


                    end, { "i", "s" }),


                    ["<S-Tab>"]   = cmp.mapping(function()


                        if cmp.visible() then cmp.select_prev_item() end


                    end, { "i", "s" }),


                }),


                sources = {


                    { name = "nvim_lsp" },


                    { name = "path" },


                    { name = "buffer",  keyword_length = 3 },


                },


            })


        end,


    },


}

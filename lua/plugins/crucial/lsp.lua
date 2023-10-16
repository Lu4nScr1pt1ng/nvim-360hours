return {
  'VonHeikemen/lsp-zero.nvim',
  event = { "BufReadPre", "BufNewFile" },
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    {
      -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },     -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' },     -- Required
    { 'onsails/lspkind.nvim' }, -- Mais bonitinho né kk

    -- Some custom LSP config
    { 'jose-elias-alvarez/typescript.nvim' },
    { 'Decodetalkers/csharpls-extended-lsp.nvim' },
    { 'j-hui/fidget.nvim',                       branch = 'legacy' }

  },
  config = function()
    require('fidget').setup()
    local lspzero = require('lsp-zero').preset({})

    lspzero.on_attach(function(client, bufnr)
      lspzero.default_keymaps({ buffer = bufnr })
    end)

    lspzero.ensure_installed({
      'svelte',
      'tsserver',
      'lua_ls',
      'eslint',
      'apex_ls',
      'emmet_ls',
      'jsonls',
      'csharp_ls',
      'html',
      'clangd',
      'dockerls',
      'tailwindcss',
      'rust_analyzer'
    })

    local lspconfig = require('lspconfig')
    local masonPath = vim.fn.stdpath('data') .. '/mason/packages'
    lspconfig.lua_ls.setup(lspzero.nvim_lua_ls())

    lspconfig.eslint.setup({
      single_file_support = false,
      on_attach = function(client, bufnr)
        print('[!]Loaded eslint')
      end
    })

    lspconfig.svelte.setup {}

    lspconfig.html.setup {}

    lspconfig.clangd.setup {

      cmd = {
        "clangd", -- SEE: clangd --help-hidden for possible options
        "--clang-tidy",
        "--completion-style=bundled",
        "--cross-file-rename",
        "--header-insertion=iwyu",
      },

    }

    lspconfig.emmet_ls.setup {
      filetypes = { "css", "html", "svelte", "javascript", "javascriptreact", "less", "sass", "scss", "typescriptreact" },
      init_options = {
        html = {
          options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ["bem.enabled"] = true,
          },
        },
      },
    }

    lspconfig.csharp_ls.setup {
      handlers = {
        ['textDocument/definition'] = require('csharpls_extended').handler,
        cmd = { csharpls }
      }
    }

    lspconfig.apex_ls.setup {
      apex_jar_path = masonPath .. '/apex-language-server/extension/dist/apex-jorje-lsp.jar',
      apex_enable_semantic_errors = true,        -- Whether to allow Apex Language Server to surface semantic errors
      apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
      filetypes = { 'apex', 'apexcode', 'apex-anon' },
      trace = 'verbose'
    }


    lspzero.set_server_config({
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          }
        }
      }
    })

    lspzero.skip_server_setup({ 'tsserver' })


    lspzero.setup()

    require('typescript').setup({
      server = {
        on_attach = function(client, bufnr)
          -- You can find more commands in the documentation:
          -- https://github.com/jose-elias-alvarez/typescript.nvim#commands

          vim.keymap.set('n', '<leader>ci', '<cmd>TypescriptAddMissingImports<cr>', { buffer = bufnr })
        end
      }
    })
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = "Float diagnostic" })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Declaration" }, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "References to this" }, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)
        --        vim.keymap.set('n', "<leader>cs", require("telescope.builtin").lsp_document_symbols,         { desc = "Document Symbols" })
        vim.keymap.set('n', '<leader>ct', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>ce', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" }, opts)
        vim.keymap.set('n', '<Leader>cf', function()
          vim.lsp.buf.format { async = true }
        end, { desc = "Code format" }, opts)
      end,
    })


    -- completion config
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()

    cmp.setup({
      preselect = 'item',
      completion = {
        completeopt = 'menu,menuone,noinsert'
      },
      mapping = {
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<C-Space>'] = cmp.mapping.complete(),
      },

      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
          mode = 'text_symbol',  -- show only symbol annotations
          preset = 'codicons',
          maxwidth = 50,         -- prevent the popup from showing more than provided characters
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        })
      }
    })
  end
}

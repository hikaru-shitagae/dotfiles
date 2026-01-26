return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        -- 非推奨警告を一時的に抑制
        local notify = vim.notify
        vim.notify = function(msg, ...)
            if msg:match("lspconfig") then
                return
            end
            notify(msg, ...)
        end

        -- LSPサーバー起動時のキーマップ設定
        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, noremap = true, silent = true }

            -- キーマップ
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)           -- 定義へジャンプ
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)          -- 宣言へジャンプ
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)           -- 参照を表示
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)       -- 実装へジャンプ
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                 -- ホバー情報
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)    -- シグネチャヘルプ
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)        -- リネーム
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)   -- コードアクション
            vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format({ async = true })
            end, opts)                                                         -- フォーマット
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)         -- 前のエラーへ
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)         -- 次のエラーへ
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)  -- エラー詳細
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)  -- エラー一覧
        end

        -- LSP補完の機能を追加
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local lspconfig = require('lspconfig')

        -- 各LSPサーバーの設定
        lspconfig.ts_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- Ruby LSP: Docker環境で開発しているため無効化
        -- 必要な場合はVSCodeのDev Containersを使用
        -- lspconfig.ruby_lsp.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        -- })

        lspconfig.html.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig.cssls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig.jsonls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig.yamlls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },  -- vimをグローバル変数として認識
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        -- typos_lsp (スペルチェック)
        lspconfig.typos_lsp.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
                -- typosの設定をカスタマイズする場合
                diagnosticSeverity = "Hint",  -- "Error", "Warning", "Information", "Hint"
            },
        })

        -- 診断表示の設定
        vim.diagnostic.config({
            virtual_text = {
                prefix = '●',
                source = "if_many",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            },
        })

        -- 診断記号の設定
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end
}

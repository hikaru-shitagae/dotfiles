return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    config = function()
        require('mason-lspconfig').setup({
            -- CHWorkforceプロジェクトで使う言語のLSP
            ensure_installed = {
                'ts_ls',        -- JavaScript/TypeScript
                -- 'ruby_lsp',  -- Ruby (Docker環境で開発のため無効化)
                'html',         -- HTML
                'cssls',        -- CSS/SCSS
                'jsonls',       -- JSON
                'yamlls',       -- YAML
                'lua_ls',       -- Lua
                'typos_lsp',    -- スペルチェック
            },
            automatic_installation = true,
        })
    end
}

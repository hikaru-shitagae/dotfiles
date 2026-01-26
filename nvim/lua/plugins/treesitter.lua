return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    lazy = false,
    priority = 1000,
    config = function()
        local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
        if not status_ok then
            return
        end

        configs.setup({
            -- CHWorkforceプロジェクトで使用されている言語
            ensure_installed = {
                -- Web Frontend
                'javascript',     -- .js (36536 files)
                'typescript',     -- .ts (1978 files)
                'tsx',           -- TypeScript with JSX
                'html',          -- .html (573 files)
                'css',           -- .css (563 files)
                'scss',          -- .scss (526 files)

                -- Backend
                'ruby',          -- .rb (6535 files)

                -- Config & Data
                'json',          -- .json (3045 files)
                'yaml',          -- .yml (397 files)

                -- Documentation
                'markdown',      -- .md (3380 files)
                'markdown_inline',

                -- Neovim config
                'lua',
                'vim',
                'vimdoc',

                -- Shell
                'bash',
            },

            -- 新しいファイルタイプも自動インストール
            auto_install = true,

            sync_install = false,

            -- シンタックスハイライト
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            -- 自動インデント
            indent = {
                enable = true,
            },

            -- インクリメンタル選択
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    scope_incremental = '<S-CR>',
                    node_decremental = '<BS>',
                },
            },
        })
    end
}

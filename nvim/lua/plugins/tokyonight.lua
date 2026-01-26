return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('tokyonight').setup({
            -- スタイル: storm, moon, night, day
            style = 'night',
            -- 透過背景を有効にする場合はtrueに
            transparent = false,
            -- ターミナルカラーを設定
            terminal_colors = true,
            styles = {
                -- コメントのスタイル
                comments = { italic = true },
                -- キーワードのスタイル
                keywords = { italic = true },
                -- 関数のスタイル
                functions = {},
                -- 変数のスタイル
                variables = {},
            },
            -- サイドバー（nvim-tree等）の背景を暗くする
            sidebars = { "qf", "help", "terminal", "packer", "NvimTree" },
            -- 昼夜自動切り替え（falseで固定）
            day_brightness = 0.3,
            -- 各プラグインのハイライトを無効化する場合はここで設定
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = false,
        })

        -- カラースキームを適用
        vim.cmd('colorscheme tokyonight')
    end
}

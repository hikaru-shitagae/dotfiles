return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- CHWorkforceからの相対パスを取得する関数
        local function get_relative_path()
            local base_path = "/Users/umadahikaru/CHWorkforce"
            local file_path = vim.fn.expand('%:p')  -- フルパスを取得

            -- base_pathで始まる場合、相対パスを返す
            if file_path:find(base_path, 1, true) == 1 then
                return file_path:sub(#base_path + 2)  -- +2は "/" を除くため
            else
                -- CHWorkforce外のファイルはフルパスを表示
                return vim.fn.expand('%:~')
            end
        end

        require('lualine').setup({
            options = {
                theme = 'tokyonight',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {
                    {
                        get_relative_path,
                        icon = '📁',
                    }
                },
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
        })
    end
}

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        require('ibl').setup({
            indent = {
                char = '│',
                tab_char = '│',
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = false,
                injected_languages = false,
                highlight = { 'Function', 'Label' },
                priority = 500,
            },
            exclude = {
                filetypes = {
                    'help',
                    'terminal',
                    'lazy',
                    'lspinfo',
                    'TelescopePrompt',
                    'TelescopeResults',
                    'mason',
                    'nvim-tree',
                    '',
                },
                buftypes = {
                    'terminal',
                    'nofile',
                },
            },
        })
    end
}

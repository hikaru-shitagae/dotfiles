-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 行番号の表示設定
vim.opt.number = true           -- 行番号を表示
vim.opt.relativenumber = false  -- 相対行番号は無効
vim.opt.signcolumn = "yes"      -- 左側の記号列を常に表示（Git差分、診断記号用）

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {{ import = "plugins" }},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- バッファ操作のキーバインド
vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>")    -- Ctrl+h: 前のバッファ
vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>")    -- Ctrl+l: 次のバッファ
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>")   -- Space+x: バッファを閉じる

-- 自動保存の設定（Neovim標準機能）
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    -- ファイル名があり、変更されているバッファのみ保存
    if vim.fn.expand("%") ~= "" and vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})
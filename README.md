# dotfiles

私の開発環境の設定ファイルです。

## 含まれる設定

- **Neovim**: エディタ設定（lazy.nvim、LSP、各種プラグイン）
  - [Neovimチートシート](neovim-cheatsheet.md) - 基本操作とプラグインのリファレンス
- **WezTerm**: ターミナル設定（キーバインド、外観）
  - [WezTermチートシート](wezterm-cheatsheet.md) - キーバインドと操作方法のリファレンス

## セットアップ方法

### 新しいマシンでのセットアップ

```bash
# リポジトリをクローン
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# セットアップスクリプトを実行
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### 手動セットアップ

```bash
# Neovim設定のシンボリックリンク作成
ln -sf ~/dotfiles/nvim ~/.config/nvim

# WezTerm設定のシンボリックリンク作成
ln -sf ~/dotfiles/wezterm ~/.config/wezterm
```

## ディレクトリ構造

```
dotfiles/
├── nvim/                   # Neovim設定
│   ├── init.lua
│   └── lua/
│       └── plugins/
├── wezterm/                # WezTerm設定
│   ├── wezterm.lua
│   └── keybinds.lua
├── neovim-cheatsheet.md    # Neovim操作リファレンス
├── wezterm-cheatsheet.md   # WezTerm操作リファレンス
├── install.sh              # セットアップスクリプト
└── README.md
```

## 必要な環境

- Neovim >= 0.9.0
- WezTerm
- Git
- Node.js (LSP用)

## 管理方法

設定を変更したら、以下のコマンドでGitHubにプッシュします：

```bash
cd ~/dotfiles
git add .
git commit -m "Update configuration"
git push
```

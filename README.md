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
├── nvim/                   # Neovim設定（GitHubで管理）
│   ├── init.lua
│   └── lua/
│       └── plugins/
├── wezterm/                # WezTerm設定（GitHubで管理）
│   ├── wezterm.lua
│   └── keybinds.lua
├── neovim-cheatsheet.md    # Neovim操作リファレンス
├── wezterm-cheatsheet.md   # WezTerm操作リファレンス
├── install.sh              # セットアップスクリプト
├── sync.sh                 # 設定同期スクリプト
└── README.md
```

## 必要な環境

- Neovim >= 0.9.0
- WezTerm
- Git
- Node.js (LSP用)

## 管理方法

### 設定の同期（推奨）

設定を変更したら、同期スクリプトを実行してGitHubにプッシュします：

```bash
~/dotfiles/sync.sh
```

このスクリプトは以下を自動的に行います：
1. `~/.config/nvim` と `~/.config/wezterm` から最新の設定をコピー
2. 変更内容を表示
3. コミットメッセージを入力
4. GitHubにプッシュ

### 手動で同期する場合

```bash
# Neovim設定をコピー
rsync -av --delete --exclude='lazy-lock.json' ~/.config/nvim/ ~/dotfiles/nvim/

# WezTerm設定をコピー
rsync -av --delete ~/.config/wezterm/ ~/dotfiles/wezterm/

# Gitにコミット＆プッシュ
cd ~/dotfiles
git add .
git commit -m "Update configuration"
git push
```

### 設定の場所

- **実際に使う設定**: `~/.config/nvim` と `~/.config/wezterm`
- **GitHubで管理**: `~/dotfiles/nvim` と `~/dotfiles/wezterm`

普段は `~/.config/` 内のファイルを編集し、定期的に `sync.sh` で同期してください。

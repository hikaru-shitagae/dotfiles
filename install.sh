#!/bin/bash

# dotfiles セットアップスクリプト
# 新しいマシンで設定ファイルをシンボリックリンクで配置します

set -e  # エラーが発生したら終了

# 色の定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"

echo -e "${GREEN}=== dotfiles セットアップ ===${NC}"
echo ""

# dotfilesディレクトリの確認
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}エラー: $DOTFILES_DIR が見つかりません${NC}"
    echo "リポジトリをクローンしてから実行してください："
    echo "  git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles"
    exit 1
fi

cd "$DOTFILES_DIR"

# バックアップディレクトリの作成
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo -e "${YELLOW}既存の設定ファイルは $BACKUP_DIR にバックアップします${NC}"
echo ""

# Neovim設定のシンボリックリンク作成
echo "--- Neovim設定 ---"
if [ -e "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
    echo "既存の ~/.config/nvim をバックアップします"
    mv "$HOME/.config/nvim" "$BACKUP_DIR/nvim"
fi
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo -e "${GREEN}✓ Neovim設定をリンクしました: ~/.config/nvim -> $DOTFILES_DIR/nvim${NC}"
echo ""

# WezTerm設定のシンボリックリンク作成
echo "--- WezTerm設定 ---"
if [ -e "$HOME/.config/wezterm" ] || [ -L "$HOME/.config/wezterm" ]; then
    echo "既存の ~/.config/wezterm をバックアップします"
    mv "$HOME/.config/wezterm" "$BACKUP_DIR/wezterm"
fi
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
echo -e "${GREEN}✓ WezTerm設定をリンクしました: ~/.config/wezterm -> $DOTFILES_DIR/wezterm${NC}"
echo ""

# 必要なツールの確認
echo "--- 必要なツールの確認 ---"

# Neovimの確認
if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -n1)
    echo -e "${GREEN}✓ Neovim がインストールされています: $NVIM_VERSION${NC}"
else
    echo -e "${YELLOW}⚠ Neovim がインストールされていません${NC}"
    echo "  インストール方法: brew install neovim"
fi

# WezTermの確認
if [ -d "/Applications/WezTerm.app" ] || command -v wezterm &> /dev/null; then
    echo -e "${GREEN}✓ WezTerm がインストールされています${NC}"
else
    echo -e "${YELLOW}⚠ WezTerm がインストールされていません${NC}"
    echo "  インストール方法: brew install --cask wezterm"
fi

# Node.jsの確認（LSP用）
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✓ Node.js がインストールされています: $NODE_VERSION${NC}"
else
    echo -e "${YELLOW}⚠ Node.js がインストールされていません（LSP用）${NC}"
    echo "  インストール方法: brew install node"
fi

# Gitの確認
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    echo -e "${GREEN}✓ Git がインストールされています: $GIT_VERSION${NC}"
else
    echo -e "${YELLOW}⚠ Git がインストールされていません${NC}"
    echo "  インストール方法: brew install git"
fi

echo ""
echo -e "${GREEN}=== セットアップ完了 ===${NC}"
echo ""
echo "次のステップ："
echo "1. Neovimを起動すると、プラグインが自動的にインストールされます"
echo "   $ nvim"
echo ""
echo "2. WezTermを起動して設定を確認してください"
echo ""
echo "3. チートシートを確認："
echo "   - Neovim: $DOTFILES_DIR/neovim-cheatsheet.md"
echo "   - WezTerm: $DOTFILES_DIR/wezterm-cheatsheet.md"
echo ""

if [ "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
    echo -e "${YELLOW}バックアップされたファイルは $BACKUP_DIR に保存されています${NC}"
else
    # バックアップディレクトリが空の場合は削除
    rmdir "$BACKUP_DIR"
fi

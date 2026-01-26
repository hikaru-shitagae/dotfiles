#!/bin/bash

# 現在の設定ファイルをdotfilesにコピーしてGitHubにプッシュするスクリプト

set -e  # エラーが発生したら終了

# 色の定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

DOTFILES_DIR="$HOME/dotfiles"

echo -e "${GREEN}=== dotfiles 同期スクリプト ===${NC}"
echo ""

# dotfilesディレクトリの確認
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}エラー: $DOTFILES_DIR が見つかりません${NC}"
    exit 1
fi

cd "$DOTFILES_DIR"

# Gitの変更があるか確認
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}警告: dotfilesに未コミットの変更があります${NC}"
    echo "続行すると、これらの変更が上書きされる可能性があります。"
    read -p "続行しますか？ (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "キャンセルしました"
        exit 1
    fi
fi

echo "--- 設定ファイルをコピー中 ---"

# Neovim設定をコピー
echo "Neovim設定をコピー..."
rsync -av --delete \
    --exclude='lazy-lock.json' \
    --exclude='.netrwhist' \
    ~/.config/nvim/ "$DOTFILES_DIR/nvim/"
echo -e "${GREEN}✓ Neovim設定をコピーしました${NC}"

# WezTerm設定をコピー
echo "WezTerm設定をコピー..."
rsync -av --delete \
    ~/.config/wezterm/ "$DOTFILES_DIR/wezterm/"
echo -e "${GREEN}✓ WezTerm設定をコピーしました${NC}"

echo ""
echo "--- Git 操作 ---"

# 変更があるか確認
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}変更がありません${NC}"
    exit 0
fi

# 変更内容を表示
echo "変更されたファイル："
git status --short

echo ""
read -p "コミットメッセージを入力してください (空白でデフォルト): " COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Update configuration ($(date '+%Y-%m-%d %H:%M:%S'))"
fi

# コミット
git add .
git commit -m "$COMMIT_MSG"
echo -e "${GREEN}✓ コミットしました${NC}"

# プッシュ
read -p "GitHubにプッシュしますか？ (Y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    git push
    echo -e "${GREEN}✓ GitHubにプッシュしました${NC}"
    echo ""
    echo "リポジトリURL: https://github.com/hikaru-shitagae/dotfiles"
else
    echo "プッシュをスキップしました"
    echo "後でプッシュするには："
    echo "  cd ~/dotfiles && git push"
fi

echo ""
echo -e "${GREEN}=== 同期完了 ===${NC}"

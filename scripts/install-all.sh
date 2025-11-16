#!/bin/bash

# 全環境にChrome DevTools MCPをインストールするスクリプト

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "🚀 Chrome DevTools MCP ワンコマンドセットアップ"
echo "================================================"
echo ""
echo "このスクリプトは以下の環境にMCPサーバーをセットアップします："
echo "  - Cline (VS Code拡張)"
echo "  - Cursor IDE"
echo "  - Gemini CLI"
echo "  - Genspark"
echo "  - Claude Desktop"
echo ""
read -p "続行しますか？ (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "セットアップをキャンセルしました"
    exit 0
fi

echo ""
echo -e "${BLUE}📦 Chrome DevTools MCPをセットアップ中...${NC}"
echo ""

# Chrome DevToolsのセットアップを実行
cd "$ROOT_DIR/chrome-devtools"
chmod +x setup.sh
./setup.sh all

echo ""
echo "================================================"
echo -e "${GREEN}✅ すべてのセットアップが完了しました！${NC}"
echo ""
echo "次のステップ："
echo "  1. エディタ/IDEを再起動"
echo "  2. 動作確認を実行: ./scripts/verify-setup.sh"
echo "  3. ドキュメントを確認: docs/use-cases.md"
echo ""

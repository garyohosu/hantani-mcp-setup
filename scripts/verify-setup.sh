#!/bin/bash

# Chrome DevTools MCPのセットアップを確認するスクリプト

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "🔍 Chrome DevTools MCP セットアップ確認"
echo "======================================="
echo ""

# Node.jsの確認
echo "📦 Node.js のチェック..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}✅ Node.js $NODE_VERSION がインストールされています${NC}"
else
    echo -e "${RED}❌ Node.js が見つかりません${NC}"
    echo "Node.js 18以上をインストールしてください: https://nodejs.org/"
fi
echo ""

# npxの確認
echo "📦 npx のチェック..."
if command -v npx &> /dev/null; then
    echo -e "${GREEN}✅ npx が利用可能です${NC}"
else
    echo -e "${RED}❌ npx が見つかりません${NC}"
fi
echo ""

# Clineの設定確認
echo "📝 Cline (VS Code) の設定確認..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_CONFIG="$HOME/Library/Application Support/Code/User/settings.json"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    VSCODE_CONFIG="$HOME/.config/Code/User/settings.json"
else
    VSCODE_CONFIG="$APPDATA/Code/User/settings.json"
fi

if [ -f "$VSCODE_CONFIG" ]; then
    if grep -q "chrome-devtools" "$VSCODE_CONFIG"; then
        echo -e "${GREEN}✅ Cline設定ファイルにMCP設定が見つかりました${NC}"
    else
        echo -e "${YELLOW}⚠️  Cline設定ファイルにMCP設定が見つかりません${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Cline設定ファイルが見つかりません${NC}"
fi
echo ""

# Cursorの設定確認
echo "📝 Cursor の設定確認..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    CURSOR_CONFIG="$HOME/Library/Application Support/Cursor/User/settings.json"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CURSOR_CONFIG="$HOME/.config/Cursor/User/settings.json"
else
    CURSOR_CONFIG="$APPDATA/Cursor/User/settings.json"
fi

if [ -f "$CURSOR_CONFIG" ]; then
    if grep -q "chrome-devtools" "$CURSOR_CONFIG"; then
        echo -e "${GREEN}✅ Cursor設定ファイルにMCP設定が見つかりました${NC}"
    else
        echo -e "${YELLOW}⚠️  Cursor設定ファイルにMCP設定が見つかりません${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Cursor設定ファイルが見つかりません${NC}"
fi
echo ""

# Gemini CLIの設定確認
echo "📝 Gemini CLI の設定確認..."
GEMINI_CONFIG="$HOME/.config/gemini-cli/config.json"
if [ -f "$GEMINI_CONFIG" ]; then
    if grep -q "chrome-devtools" "$GEMINI_CONFIG"; then
        echo -e "${GREEN}✅ Gemini CLI設定ファイルにMCP設定が見つかりました${NC}"
    else
        echo -e "${YELLOW}⚠️  Gemini CLI設定ファイルにMCP設定が見つかりません${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Gemini CLI設定ファイルが見つかりません${NC}"
fi
echo ""

# Claude Desktopの設定確認
echo "📝 Claude Desktop の設定確認..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    CLAUDE_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CLAUDE_CONFIG="$HOME/.config/Claude/claude_desktop_config.json"
else
    CLAUDE_CONFIG="$APPDATA/Claude/claude_desktop_config.json"
fi

if [ -f "$CLAUDE_CONFIG" ]; then
    if grep -q "chrome-devtools" "$CLAUDE_CONFIG"; then
        echo -e "${GREEN}✅ Claude Desktop設定ファイルにMCP設定が見つかりました${NC}"
    else
        echo -e "${YELLOW}⚠️  Claude Desktop設定ファイルにMCP設定が見つかりません${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Claude Desktop設定ファイルが見つかりません${NC}"
fi
echo ""

# Chromeのポート確認
echo "🌐 Chrome デバッグポートの確認..."
if lsof -i :9222 &> /dev/null; then
    echo -e "${YELLOW}⚠️  ポート9222は既に使用されています${NC}"
    echo "使用中のプロセス:"
    lsof -i :9222
else
    echo -e "${GREEN}✅ ポート9222は利用可能です${NC}"
fi
echo ""

echo "======================================="
echo "確認完了！"
echo ""
echo "問題がある場合："
echo "  - エディタ/IDEを再起動してください"
echo "  - docs/troubleshooting.md を確認してください"
echo ""

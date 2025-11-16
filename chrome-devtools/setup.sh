#!/bin/bash

# Chrome DevTools MCP セットアップスクリプト
# 使い方: ./setup.sh [cline|cursor|gemini|genspark|claude]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🚀 Chrome DevTools MCP セットアップ"
echo "======================================"
echo ""

# 環境を指定
TARGET=${1:-"all"}

# Node.jsのチェック
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.jsがインストールされていません${NC}"
    echo "Node.js 18以上をインストールしてください: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${RED}❌ Node.js 18以上が必要です（現在: v$NODE_VERSION）${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Node.js $(node -v) 検出${NC}"
echo ""

# Clineのセットアップ
setup_cline() {
    echo "📝 Cline (VS Code拡張) をセットアップ中..."
    
    # VS Code設定ディレクトリ
    if [[ "$OSTYPE" == "darwin"* ]]; then
        CONFIG_DIR="$HOME/Library/Application Support/Code/User"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        CONFIG_DIR="$HOME/.config/Code/User"
    else
        CONFIG_DIR="$APPDATA/Code/User"
    fi
    
    mkdir -p "$CONFIG_DIR"
    
    # 設定ファイルをコピー
    if [ -f "$CONFIG_DIR/settings.json" ]; then
        echo -e "${YELLOW}⚠️  既存のsettings.jsonが見つかりました${NC}"
        echo "MCPサーバー設定を手動で追加してください："
        cat "$SCRIPT_DIR/config-cline.json"
    else
        cp "$SCRIPT_DIR/config-cline.json" "$CONFIG_DIR/settings.json"
        echo -e "${GREEN}✅ Clineの設定完了${NC}"
    fi
}

# Cursorのセットアップ
setup_cursor() {
    echo "📝 Cursor IDE をセットアップ中..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        CONFIG_DIR="$HOME/.config/Cursor/User"
    else
        CONFIG_DIR="$APPDATA/Cursor/User"
    fi
    
    mkdir -p "$CONFIG_DIR"
    
    if [ -f "$CONFIG_DIR/settings.json" ]; then
        echo -e "${YELLOW}⚠️  既存のsettings.jsonが見つかりました${NC}"
        echo "MCPサーバー設定を手動で追加してください："
        cat "$SCRIPT_DIR/config-cursor.json"
    else
        cp "$SCRIPT_DIR/config-cursor.json" "$CONFIG_DIR/settings.json"
        echo -e "${GREEN}✅ Cursorの設定完了${NC}"
    fi
}

# Gemini CLIのセットアップ
setup_gemini() {
    echo "📝 Gemini CLI をセットアップ中..."
    
    CONFIG_DIR="$HOME/.config/gemini-cli"
    mkdir -p "$CONFIG_DIR"
    
    if [ -f "$CONFIG_DIR/config.json" ]; then
        echo -e "${YELLOW}⚠️  既存のconfig.jsonが見つかりました${NC}"
        echo "MCPサーバー設定を手動で追加してください："
        cat "$SCRIPT_DIR/config-gemini-cli.json"
    else
        cp "$SCRIPT_DIR/config-gemini-cli.json" "$CONFIG_DIR/config.json"
        echo -e "${GREEN}✅ Gemini CLIの設定完了${NC}"
    fi
}

# Gensparkのセットアップ
setup_genspark() {
    echo "📝 Genspark をセットアップ中..."
    
    echo ""
    echo "Gensparkの設定方法："
    echo "1. Gensparkの設定画面を開く"
    echo "2. 'MCP Servers' セクションに移動"
    echo "3. 以下の設定を追加："
    echo ""
    cat "$SCRIPT_DIR/config-genspark.json"
    echo ""
    echo -e "${GREEN}✅ Genspark用の設定ファイルを準備しました${NC}"
    echo "詳細は docs/genspark-guide.md を参照してください"
}

# Claude Desktopのセットアップ
setup_claude() {
    echo "📝 Claude Desktop をセットアップ中..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        CONFIG_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        CONFIG_FILE="$HOME/.config/Claude/claude_desktop_config.json"
    else
        CONFIG_FILE="$APPDATA/Claude/claude_desktop_config.json"
    fi
    
    CONFIG_DIR=$(dirname "$CONFIG_FILE")
    mkdir -p "$CONFIG_DIR"
    
    if [ -f "$CONFIG_FILE" ]; then
        echo -e "${YELLOW}⚠️  既存の設定ファイルが見つかりました${NC}"
        echo "MCPサーバー設定を手動で追加してください："
        cat "$SCRIPT_DIR/config-claude-desktop.json"
    else
        cp "$SCRIPT_DIR/config-claude-desktop.json" "$CONFIG_FILE"
        echo -e "${GREEN}✅ Claude Desktopの設定完了${NC}"
    fi
}

# セットアップ実行
case $TARGET in
    cline)
        setup_cline
        ;;
    cursor)
        setup_cursor
        ;;
    gemini)
        setup_gemini
        ;;
    genspark)
        setup_genspark
        ;;
    claude)
        setup_claude
        ;;
    all)
        setup_cline
        echo ""
        setup_cursor
        echo ""
        setup_gemini
        echo ""
        setup_genspark
        echo ""
        setup_claude
        ;;
    *)
        echo -e "${RED}❌ 不明な環境: $TARGET${NC}"
        echo "使い方: ./setup.sh [cline|cursor|gemini|genspark|claude|all]"
        exit 1
        ;;
esac

echo ""
echo "======================================"
echo -e "${GREEN}🎉 セットアップ完了！${NC}"
echo ""
echo "次のステップ："
echo "1. エディタ/IDEを再起動してください"
echo "2. 動作確認: ./scripts/verify-setup.sh を実行"
echo "3. 使い方: docs/use-cases.md を参照"
echo ""

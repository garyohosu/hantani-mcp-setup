# 📖 詳細セットアップガイド

このガイドでは、各環境でのChrome DevTools MCPの詳細なセットアップ方法を説明します。

## 📋 目次

- [Cline (VS Code拡張)](#cline-vs-code拡張)
- [Cursor IDE](#cursor-ide)
- [Gemini CLI](#gemini-cli)
- [Genspark](#genspark)
- [Claude Desktop](#claude-desktop)

---

## Cline (VS Code拡張)

Cline（旧Claude Dev）は、VS Code内で動作するAI開発アシスタント拡張です。

### 自動セットアップ

```bash
cd chrome-devtools
./setup.sh cline
```

### 手動セットアップ

#### ステップ1: VS Code設定ファイルの場所を確認

**macOS:**
```bash
~/Library/Application Support/Code/User/settings.json
```

**Linux:**
```bash
~/.config/Code/User/settings.json
```

**Windows:**
```
%APPDATA%\Code\User\settings.json
```

#### ステップ2: MCP設定を追加

既存の`settings.json`を開き、以下を追加：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"],
      "env": {
        "CHROME_DEBUG_PORT": "9222"
      }
    }
  }
}
```

既に他の設定がある場合は、`mcpServers`セクションを適切にマージしてください。

#### ステップ3: VS Codeを再起動

設定を反映させるため、VS Codeを完全に再起動してください。

#### ステップ4: 動作確認

1. Clineを開く（サイドバーのClineアイコン）
2. 「利用可能なMCPサーバー」を確認
3. `chrome-devtools`が表示されていれば成功

---

## Cursor IDE

CursorはAI統合型のコードエディタです。

### 自動セットアップ

```bash
cd chrome-devtools
./setup.sh cursor
```

### 手動セットアップ

#### ステップ1: Cursor設定ファイルの場所を確認

**macOS:**
```bash
~/Library/Application Support/Cursor/User/settings.json
```

**Linux:**
```bash
~/.config/Cursor/User/settings.json
```

**Windows:**
```
%APPDATA%\Cursor\User\settings.json
```

#### ステップ2: MCP設定を追加

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"],
      "env": {
        "CHROME_DEBUG_PORT": "9222"
      }
    }
  }
}
```

#### ステップ3: Cursorを再起動

#### ステップ4: 動作確認

1. Cursor AIチャットを開く（Cmd/Ctrl + L）
2. MCPサーバーが利用可能か確認
3. テスト: 「Chrome DevTools MCPが使えるか確認して」

---

## Gemini CLI

Gemini CLIは、ターミナルで動作するGoogle Geminiインターフェースです。

### 自動セットアップ

```bash
cd chrome-devtools
./setup.sh gemini
```

### 手動セットアップ

#### ステップ1: 設定ディレクトリを作成

```bash
mkdir -p ~/.config/gemini-cli
```

#### ステップ2: 設定ファイルを作成

`~/.config/gemini-cli/config.json` を作成：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"],
      "env": {
        "CHROME_DEBUG_PORT": "9222"
      }
    }
  }
}
```

#### ステップ3: Gemini CLIを再起動

既に実行中の場合は、一度終了して再起動してください。

#### ステップ4: 動作確認

```bash
gemini "Chrome DevTools MCPが使えるか確認して"
```

---

## Genspark

Gensparkは次世代のAI検索・対話プラットフォームです。

詳細は [Genspark専用ガイド](genspark-guide.md) を参照してください。

### クイックセットアップ

1. [Genspark](https://genspark.ai) にログイン
2. Settings → MCP Servers
3. `chrome-devtools/config-genspark.json` の内容を追加
4. 保存して確認

---

## Claude Desktop

Claude Desktopは、AnthropicのClaude AIのデスクトップアプリです。

### 自動セットアップ

```bash
cd chrome-devtools
./setup.sh claude
```

### 手動セットアップ

#### ステップ1: 設定ファイルの場所を確認

**macOS:**
```bash
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Linux:**
```bash
~/.config/Claude/claude_desktop_config.json
```

**Windows:**
```
%APPDATA%\Claude\claude_desktop_config.json
```

#### ステップ2: 設定ファイルを編集

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"],
      "env": {
        "CHROME_DEBUG_PORT": "9222"
      }
    }
  }
}
```

#### ステップ3: Claude Desktopを再起動

完全に終了してから再度起動してください。

#### ステップ4: 動作確認

1. 新しい対話を開始
2. MCPツールアイコンを確認
3. `chrome-devtools`が表示されていれば成功

---

## 共通の注意事項

### Node.jsのバージョン

すべての環境でNode.js 18以上が必要です：

```bash
node -v  # v18.0.0以上であることを確認
```

### ポートの競合

デフォルトのポート9222が既に使用されている場合：

```json
{
  "env": {
    "CHROME_DEBUG_PORT": "9223"
  }
}
```

### ファイアウォール設定

ローカルホスト（127.0.0.1）への接続がブロックされていないか確認してください。

### パスの指定

絶対パスを使用する場合：

```json
{
  "command": "python",
  "args": ["/absolute/path/to/chrome-devtools-mcp/server.py"]
}
```

---

## トラブルシューティング

問題が発生した場合は、[トラブルシューティングガイド](troubleshooting.md) を参照してください。

---

🐱 Created by hantani - AI時代の創作技術研究者

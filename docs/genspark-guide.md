# 🌟 Genspark専用セットアップガイド

Gensparkは次世代のAI検索・対話プラットフォームで、MCPサーバーをカスタマイズして接続することができます。

## 📋 目次

- [Gensparkとは？](#gensparkとは)
- [前提条件](#前提条件)
- [セットアップ方法](#セットアップ方法)
- [設定の詳細](#設定の詳細)
- [使い方](#使い方)
- [トラブルシューティング](#トラブルシューティング)

## 🎯 Gensparkとは？

Gensparkは、複数のAIモデルと統合された検索・対話プラットフォームです。MCPサーバーを追加することで、AIエージェントにカスタム機能を追加できます。

**Gensparkの特徴:**
- マルチモデル対応（GPT-4、Claude、Gemini等）
- リアルタイム検索統合
- 拡張可能なMCPアーキテクチャ
- ブラウザベースの統合環境

## ✅ 前提条件

1. **Gensparkアカウント**
   - [Genspark](https://genspark.ai) にサインアップ
   
2. **Node.js 18以上**
   ```bash
   node -v  # v18.0.0以上であることを確認
   ```

3. **Chrome DevTools MCP設定ファイル**
   - このリポジトリの `chrome-devtools/config-genspark.json`

## 🚀 セットアップ方法

### ステップ1: Genspark設定画面を開く

1. [Genspark](https://genspark.ai) にログイン
2. 右上のユーザーメニューから **Settings**（設定）を選択
3. 左サイドバーの **MCP Servers** セクションに移動

### ステップ2: Chrome DevTools MCPを追加

1. **「Add Server」** または **「+ New MCP Server」** ボタンをクリック

2. 以下の設定を入力：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": [
        "chrome-devtools-mcp@latest"
      ],
      "env": {
        "CHROME_DEBUG_PORT": "9222"
      },
      "description": "Chrome DevTools Protocol integration for browser debugging",
      "metadata": {
        "author": "Google Chrome DevTools Team",
        "repository": "https://github.com/ChromeDevTools/chrome-devtools-mcp",
        "version": "latest"
      }
    }
  }
}
```

### ステップ3: 設定を保存

1. **「Save」** または **「Apply」** ボタンをクリック
2. ページをリフレッシュ（必要に応じて）

### ステップ4: 動作確認

Gensparkの対話ウィンドウで以下を試してください：

```
「Chrome DevTools MCPが利用可能か確認して」
```

または

```
「MCPサーバーのリストを表示して」
```

## 🔧 設定の詳細

### 設定項目の説明

| 項目 | 説明 | 値 |
|------|------|-----|
| `command` | 実行するコマンド | `npx` |
| `args` | コマンドの引数 | `["chrome-devtools-mcp@latest"]` |
| `env.CHROME_DEBUG_PORT` | Chromeデバッグポート | `9222`（デフォルト） |
| `description` | サーバーの説明 | 任意のテキスト |
| `metadata` | メタデータ | 作者、リポジトリ等の情報 |

### カスタマイズ例

#### デバッグポートを変更する場合

```json
{
  "env": {
    "CHROME_DEBUG_PORT": "9223"
  }
}
```

#### ローカルインストール版を使う場合

```json
{
  "command": "python",
  "args": [
    "/absolute/path/to/chrome-devtools-mcp/server.py"
  ],
  "env": {
    "CHROME_DEBUG_PORT": "9222"
  }
}
```

## 💡 使い方

### 基本的な使い方

Gensparkでの対話例：

```
「localhost:3000のReactアプリをデバッグして」
→ AIが自動でChromeを起動、接続、分析

「ネットワークリクエストのエラーを調べて」
→ AIがHTTPトラフィックを分析

「このページのパフォーマンスを最適化する方法を教えて」
→ AIがパフォーマンスメトリクスを解析して提案
```

### 利用可能な機能

Chrome DevTools MCPを通じて以下の機能が利用可能：

- ✅ ネットワークトラフィック監視
- ✅ コンソールログ取得
- ✅ JavaScriptエラー分析
- ✅ パフォーマンスメトリクス
- ✅ DOM/CSS検査
- ✅ Cookie/Storage操作
- ✅ JavaScript実行

### 実践的なユースケース

#### 1. APIデバッグ

```
「このフォームの送信で500エラーが出る原因を調べて」

AIの応答例：
1. Chromeに接続します
2. ネットワークリクエストを監視します
3. フォーム送信時のリクエストを分析します
4. エラーの原因を特定します
```

#### 2. パフォーマンス分析

```
「ページの読み込みが遅い理由を特定して」

AIの応答例：
1. ページのパフォーマンスメトリクスを取得
2. リソースの読み込み時間を分析
3. ボトルネックを特定
4. 最適化の提案
```

#### 3. コンソールエラー診断

```
「JavaScriptエラーをまとめて原因を教えて」

AIの応答例：
1. コンソールログを取得
2. エラーを分類
3. 各エラーの原因を分析
4. 修正方法を提案
```

## 🔍 トラブルシューティング

### MCPサーバーが表示されない

**原因:** 設定が正しく保存されていない

**解決策:**
1. 設定を再度確認
2. JSONフォーマットが正しいか確認
3. ブラウザをリフレッシュ
4. 必要に応じてログアウト/ログインを試す

### "Command not found" エラー

**原因:** Node.jsまたはnpxがインストールされていない

**解決策:**
```bash
# Node.jsのバージョン確認
node -v

# Node.jsが18未満の場合、アップデート
# または https://nodejs.org/ からインストール
```

### Chromeに接続できない

**原因:** ポート9222が既に使用されている

**解決策:**
```bash
# macOS/Linux
lsof -i :9222
kill -9 <PID>

# または別のポートを使用
# config-genspark.jsonでCHROME_DEBUG_PORTを変更
```

### MCPサーバーが応答しない

**原因:** ネットワークまたはファイアウォールの問題

**解決策:**
1. ローカルホスト接続が許可されているか確認
2. ファイアウォール設定を確認
3. VPNを一時的に無効化して試す

## 🌟 Gensparkならではの機能

### マルチモデル連携

GensparkではChrome DevTools MCPを複数のAIモデルから利用可能：

- **GPT-4**: 詳細な分析と説明
- **Claude**: コード理解と最適化提案
- **Gemini**: マルチモーダル分析

### リアルタイム検索統合

Chrome DevToolsで取得した情報をGensparkの検索機能と組み合わせ：

```
「このエラーメッセージの解決策を検索して」
→ コンソールエラーを取得 + 最新の解決策を検索
```

### コンテキスト保持

Gensparkは対話のコンテキストを保持するため、継続的なデバッグが可能：

```
ユーザー: 「localhost:3000のエラーを調べて」
AI: [ネットワークエラーを分析]

ユーザー: 「そのエラーを修正するコードを書いて」
AI: [前のコンテキストを踏まえてコード生成]
```

## 📚 参考リンク

- [Genspark公式サイト](https://genspark.ai)
- [Chrome DevTools MCP公式リポジトリ](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [Model Context Protocol仕様](https://modelcontextprotocol.io/)

## 💬 サポート

問題が解決しない場合：

1. [GitHubリポジトリのIssues](https://github.com/YOUR_USERNAME/hantani-mcp-setup/issues)
2. Gensparkのサポートチャット
3. X (Twitter): [@your_handle]

---

🐱 Created by hantani - AI時代の創作技術研究者

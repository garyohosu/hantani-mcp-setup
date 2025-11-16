# 🚀 hantani-mcp-setup

**AIエージェントにブラウザデバッグ能力を追加する統合セットアップリポジトリ**

Chrome DevTools MCPを各種AI開発環境（Cline、Cursor、Gemini CLI、Genspark、Claude Desktop）に簡単にセットアップできるリポジトリです。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

## 📚 目次

- [Chrome DevTools MCPとは？](#chrome-devtools-mcpとは)
- [クイックスタート](#クイックスタート)
- [対応環境](#対応環境)
- [セットアップ方法](#セットアップ方法)
- [使い方](#使い方)
- [トラブルシューティング](#トラブルシューティング)
- [ユースケース](#ユースケース)
- [貢献](#貢献)

## 🎯 Chrome DevTools MCPとは？

Chrome DevTools MCPは、Google Chrome DevToolsチームが開発した**Model Context Protocol (MCP)** サーバーです。

AIエージェント（Cursor、Cline、Gemini CLI、Genspark等）に以下の能力を与えます：

- 🔍 **ネットワークリクエストの監視** - HTTPトラフィックの分析、APIエラーの特定
- 🐛 **コンソールログの取得** - JavaScriptエラーの自動分析
- 📊 **パフォーマンス分析** - ページ読み込み速度、メモリ使用量の測定
- 🎨 **DOM/CSS検査** - 要素の検査、スタイルの分析
- 🍪 **ストレージアクセス** - Cookie、localStorage、sessionStorageの操作
- ⚡ **JavaScript実行** - ブラウザコンテキストでのコード実行

## ⚡ クイックスタート

```bash
# リポジトリをクローン
git clone https://github.com/garyohosu/hantani-mcp-setup.git
cd hantani-mcp-setup

# ワンコマンドでセットアップ
./scripts/install-all.sh

# セットアップ確認
./scripts/verify-setup.sh
```

## 🖥️ 対応環境

| 環境 | 対応状況 | 設定ファイル |
|------|---------|-------------|
| **Cline (VS Code拡張)** | ✅ | `chrome-devtools/config-cline.json` |
| **Cursor IDE** | ✅ | `chrome-devtools/config-cursor.json` |
| **Gemini CLI** | ✅ | `chrome-devtools/config-gemini-cli.json` |
| **Genspark** | ✅ | `chrome-devtools/config-genspark.json` |
| **Claude Desktop** | ✅ | `chrome-devtools/config-claude-desktop.json` |

## 📦 セットアップ方法

### 前提条件

- Node.js 18以上
- Python 3.10以上（ローカルインストール方式の場合）
- Git

### 方法1: 自動セットアップ（推奨）

```bash
# リポジトリをクローン
git clone https://github.com/garyohosu/hantani-mcp-setup.git
cd hantani-mcp-setup

# 全環境に自動セットアップ
./scripts/install-all.sh

# 特定の環境のみセットアップ
./chrome-devtools/setup.sh cline      # Clineのみ
./chrome-devtools/setup.sh cursor     # Cursorのみ
./chrome-devtools/setup.sh gemini     # Gemini CLIのみ
./chrome-devtools/setup.sh genspark   # Gensparkのみ
./chrome-devtools/setup.sh claude     # Claude Desktopのみ
```

### 方法2: 手動セットアップ

各環境の詳細なセットアップ手順は以下を参照：

- [Clineセットアップガイド](docs/setup-guide.md#cline)
- [Cursorセットアップガイド](docs/setup-guide.md#cursor)
- [Gemini CLIセットアップガイド](docs/setup-guide.md#gemini-cli)
- [Gensparkセットアップガイド](docs/genspark-guide.md)
- [Claude Desktopセットアップガイド](docs/setup-guide.md#claude-desktop)

## 🎮 使い方

### 基本的な使い方

セットアップ後、AIエージェントに以下のように指示できます：

```
「localhost:3000を開いてネットワークエラーを調べて」
→ AIが自動でChromeを起動、接続、分析

「このページのパフォーマンスボトルネックを特定して」
→ AIがパフォーマンスメトリクスを解析

「コンソールエラーをまとめて原因を教えて」
→ AIがエラーログを分析、解決策を提案
```

### よく使うコマンド

```javascript
// Chromeを起動してアプリに接続
start_chrome_and_connect("localhost:3000")

// ネットワークリクエストを取得
get_network_requests()

// 失敗したAPIコールを特定
get_network_requests(filter_status=500)

// コンソールエラーのサマリー
get_console_error_summary()

// リアルタイムでコンソールを監視
monitor_console_live(10)

// パフォーマンスメトリクスを取得
get_performance_metrics()

// JavaScriptオブジェクトを検査
inspect_console_object("window.myApp")
```

## 🔧 トラブルシューティング

セットアップや使用時の問題は [トラブルシューティングガイド](docs/troubleshooting.md) を参照してください。

### よくある問題

- **MCPサーバーが表示されない** → 設定ファイルのパスを確認、エディタ/IDEを再起動
- **Chromeに接続できない** → ポート9222が使用中でないか確認
- **"Module not found"エラー** → `npm install`または`uv sync`を実行

## 💡 ユースケース

実践的なユースケースは [use-cases.md](docs/use-cases.md) を参照：

- [Reactアプリのデバッグ](examples/debug-react-app.md)
- [パフォーマンス分析と最適化](examples/performance-analysis.md)
- 認証・セッション問題の診断
- CSSスタイルのトラブルシューティング

## 🌟 特徴

### 1. **複数環境対応**
一つのリポジトリで、Cline、Cursor、Gemini CLI、Genspark、Claude Desktopすべてに対応。

### 2. **ワンコマンドセットアップ**
複雑な設定を自動化。初心者でも5分で導入可能。

### 3. **日本語ドキュメント完備**
すべてのドキュメントを日本語で提供（英語版も用意）。

### 4. **実践的なサンプル**
実際の開発シーンで使えるユースケースとサンプルコード。

### 5. **環境の永続化**
dotfilesとして管理可能。PC移行時も簡単に復元。

## 📖 詳細ドキュメント

- [詳細セットアップガイド](docs/setup-guide.md)
- [Genspark専用ガイド](docs/genspark-guide.md)
- [トラブルシューティング](docs/troubleshooting.md)
- [ユースケース集](docs/use-cases.md)

## 🤝 貢献

プルリクエスト、イシュー、フィードバックを歓迎します！

1. このリポジトリをフォーク
2. フィーチャーブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📝 ライセンス

MIT License - 詳細は [LICENSE](LICENSE) を参照

## 🙏 謝辞

- [Chrome DevTools MCP](https://github.com/ChromeDevTools/chrome-devtools-mcp) - Google Chrome DevToolsチーム
- [Model Context Protocol](https://modelcontextprotocol.io/) - Anthropic

## 📮 お問い合わせ

- **作者**: hantani
- **note**: [https://note.com/hantani]
- **X (Twitter)**: [@garyo]
- **GitHub**: [@garyohosu]

## 🔗 関連リンク

- [Chrome DevTools MCP 公式リポジトリ](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [Model Context Protocol 公式サイト](https://modelcontextprotocol.io/)
- [Awesome MCP Servers](https://mcpservers.org/)

---

⭐ このリポジトリが役に立ったら、スターをお願いします！

🐱 Created with ❤️ by hantani - AI時代の創作技術研究者

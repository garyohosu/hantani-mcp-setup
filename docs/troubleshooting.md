# 🔧 トラブルシューティングガイド

Chrome DevTools MCPのセットアップや使用時に発生する一般的な問題と解決策をまとめています。

## 📋 目次

- [セットアップ関連](#セットアップ関連)
- [接続関連](#接続関連)
- [実行時エラー](#実行時エラー)
- [パフォーマンス問題](#パフォーマンス問題)
- [環境別の問題](#環境別の問題)

---

## セットアップ関連

### MCPサーバーが表示されない

**症状:** エディタ/IDEでMCPサーバーのリストに`chrome-devtools`が表示されない

**原因と解決策:**

1. **設定ファイルのパスが間違っている**
   ```bash
   # 設定ファイルの場所を確認
   # macOS (VS Code)
   cat ~/Library/Application\ Support/Code/User/settings.json
   
   # Linux (VS Code)
   cat ~/.config/Code/User/settings.json
   ```

2. **JSONフォーマットエラー**
   ```bash
   # JSONの妥当性をチェック
   cat settings.json | jq .
   # エラーが表示される場合はJSONを修正
   ```

3. **エディタ/IDEを再起動していない**
   - 設定変更後は必ず完全に再起動してください

4. **権限の問題**
   ```bash
   # 設定ファイルの権限を確認
   ls -la ~/Library/Application\ Support/Code/User/settings.json
   # 必要に応じて修正
   chmod 644 settings.json
   ```

### "Command not found: npx" エラー

**症状:** セットアップ時に`npx`が見つからないエラー

**解決策:**

```bash
# Node.jsとnpmのインストール確認
node -v
npm -v

# インストールされていない場合
# macOS (Homebrew)
brew install node

# Linux (Ubuntu/Debian)
sudo apt update
sudo apt install nodejs npm

# Windows
# https://nodejs.org/ からインストーラーをダウンロード
```

### Node.jsのバージョンが古い

**症状:** "Node.js 18以上が必要" というエラー

**解決策:**

```bash
# 現在のバージョン確認
node -v

# macOS (Homebrew)
brew upgrade node

# Linux (nvm使用)
nvm install 18
nvm use 18

# Windows
# https://nodejs.org/ から最新版をダウンロード
```

---

## 接続関連

### Chromeに接続できない

**症状:** "Cannot connect to Chrome" または "Connection refused"

**原因と解決策:**

1. **ポート9222が既に使用されている**
   ```bash
   # macOS/Linux
   lsof -i :9222
   
   # 使用中のプロセスを終了
   kill -9 <PID>
   
   # または設定で別のポートを使用
   "CHROME_DEBUG_PORT": "9223"
   ```

2. **Chromeが起動していない**
   - MCPサーバーが自動でChromeを起動する前に手動で起動している場合
   - 解決策: Chromeを終了してからMCPに任せる

3. **ファイアウォールがブロックしている**
   ```bash
   # macOS
   # システム環境設定 → セキュリティとプライバシー → ファイアウォール
   # ローカルホスト接続を許可
   
   # Linux (ufw)
   sudo ufw allow 9222/tcp
   
   # Windows
   # Windowsファイアウォール設定でポート9222を許可
   ```

### "WebSocket connection failed"

**症状:** WebSocket接続エラー

**解決策:**

1. **Chromeのバージョン確認**
   ```bash
   # Chromeのバージョンが古すぎる可能性
   # Chrome 90以上を推奨
   ```

2. **プロキシ設定の確認**
   - VPNやプロキシがローカルホスト接続を妨げている可能性
   - 一時的に無効化して試す

3. **ポート転送の問題**
   ```bash
   # リモート開発環境の場合
   # ポート転送が正しく設定されているか確認
   ssh -L 9222:localhost:9222 user@remote
   ```

---

## 実行時エラー

### "Module not found" エラー

**症状:** MCPサーバー起動時にPythonモジュールが見つからない

**解決策:**

```bash
# ローカルインストール版を使用している場合

# 依存関係を再インストール
cd chrome-devtools-mcp
pip install -r requirements.txt

# またはuvを使用
uv sync

# npx版に切り替える（推奨）
# 設定ファイルで:
{
  "command": "npx",
  "args": ["chrome-devtools-mcp@latest"]
}
```

### "Permission denied" エラー

**症状:** スクリプト実行時に権限エラー

**解決策:**

```bash
# 実行権限を付与
chmod +x chrome-devtools/setup.sh
chmod +x scripts/*.sh

# セットアップスクリプトを実行
./chrome-devtools/setup.sh
```

### タイムアウトエラー

**症状:** "Connection timeout" または "Request timeout"

**原因と解決策:**

1. **ネットワークが遅い**
   - タイムアウト時間を延長（MCPサーバーの設定で可能な場合）

2. **Chromeの起動が遅い**
   ```bash
   # Chromeのキャッシュをクリア
   # または別のChrome profileを使用
   ```

3. **システムリソース不足**
   - 他のアプリケーションを終了してメモリを解放

---

## パフォーマンス問題

### MCPサーバーが遅い

**症状:** コマンドの実行に時間がかかる

**解決策:**

1. **ネットワークリクエストのフィルタリング**
   ```javascript
   // 特定のドメインのみ取得
   get_network_requests(filter_domain="api.example.com")
   
   // ステータスコードでフィルタ
   get_network_requests(filter_status=500)
   
   // リミットを設定
   get_network_requests(limit=10)
   ```

2. **コンソールログの制限**
   ```javascript
   // 最新のログのみ取得
   get_console_logs(limit=20)
   
   // エラーのみ取得
   get_console_logs(level="error")
   ```

3. **Chrome拡張機能の無効化**
   - デバッグ用のChromeプロファイルは拡張機能なしで使用

### メモリ使用量が多い

**症状:** Chromeやエディタのメモリ使用量が増加

**解決策:**

1. **定期的にコンソールをクリア**
   ```javascript
   clear_console()
   ```

2. **使用後は接続を切断**
   ```javascript
   disconnect_from_browser()
   ```

3. **不要なタブを閉じる**
   - デバッグ対象のページのみ開く

---

## 環境別の問題

### Cline (VS Code) 特有の問題

**症状:** Clineが設定を認識しない

**解決策:**

1. **ワークスペース設定との競合**
   ```bash
   # ユーザー設定とワークスペース設定を確認
   # .vscode/settings.json より優先度が高い
   ```

2. **Cline拡張のバージョン確認**
   - 最新版にアップデート

3. **設定の再読み込み**
   - Cmd/Ctrl + Shift + P → "Reload Window"

### Cursor 特有の問題

**症状:** CursorでMCPツールが表示されない

**解決策:**

1. **Cursor独自の設定場所**
   ```bash
   # VS Codeとは異なる場所に設定がある場合
   ~/Library/Application Support/Cursor/User/settings.json
   ```

2. **AIモデルの選択**
   - 一部のモデルではMCP機能が制限される可能性
   - GPT-4やClaudeを選択

### Gemini CLI 特有の問題

**症状:** Gemini CLIでMCPが動作しない

**解決策:**

1. **設定ファイルの場所**
   ```bash
   # デフォルトの場所を確認
   ~/.config/gemini-cli/config.json
   
   # 環境変数で指定されている場合
   echo $GEMINI_CONFIG_PATH
   ```

2. **Gemini CLIのバージョン**
   ```bash
   gemini --version
   # 古い場合はアップデート
   pip install --upgrade gemini-cli
   ```

### Genspark 特有の問題

**症状:** Gensparkで設定が保存されない

**解決策:**

詳細は [Genspark専用ガイド](genspark-guide.md#トラブルシューティング) を参照

1. **ブラウザのキャッシュをクリア**
2. **別のブラウザで試す**
3. **設定のエクスポート/インポートを試す**

---

## その他の問題

### セキュリティ警告

**症状:** "Untrusted server" や証明書エラー

**解決策:**

```bash
# localhost接続は安全
# 開発環境でのみ使用し、本番環境では使用しない
```

### 複数のChromeインスタンスの問題

**症状:** 複数のChromeが起動して混乱

**解決策:**

```bash
# すべてのChromeプロセスを終了
killall "Google Chrome"

# またはプロセスマネージャーから終了

# MCPサーバーに起動を任せる
start_chrome_and_connect("localhost:3000")
```

---

## デバッグ方法

### MCPサーバーのログを確認

```bash
# エディタ/IDEのログを確認
# VS Code
~/Library/Logs/Code/

# Cursor
~/Library/Logs/Cursor/

# Claude Desktop
~/Library/Logs/Claude/
```

### 手動でMCPサーバーをテスト

```bash
# npx版
npx chrome-devtools-mcp@latest

# ローカル版
cd chrome-devtools-mcp
python server.py
```

### 設定の完全リセット

```bash
# バックアップを取ってから
cp settings.json settings.json.backup

# 設定を削除
rm settings.json

# 再セットアップ
./chrome-devtools/setup.sh
```

---

## サポート

それでも問題が解決しない場合：

1. **GitHubでIssueを作成**
   - [Issues](https://github.com/YOUR_USERNAME/hantani-mcp-setup/issues)
   - エラーメッセージと環境情報を含めてください

2. **コミュニティに質問**
   - X (Twitter): [@your_handle]
   - note: [あなたのnoteプロフィール]

3. **公式リソース**
   - [Chrome DevTools MCP Issues](https://github.com/ChromeDevTools/chrome-devtools-mcp/issues)
   - [MCP公式ドキュメント](https://modelcontextprotocol.io/)

---

🐱 Created by hantani - AI時代の創作技術研究者

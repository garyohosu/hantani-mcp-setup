# 📝 TODO List

## 🚀 リポジトリ公開前にやること

### 必須タスク

- [ ] **GitHubにリポジトリを作成**
  - リポジトリ名: `hantani-mcp-setup`
  - 公開設定: Public
  - ライセンス: MIT（既に含まれています）

- [ ] **README.mdの情報を更新**
  - `YOUR_USERNAME` → 自分のGitHubユーザー名に置き換え
  - `[あなたのnoteプロフィールURL]` → 実際のnoteプロフィールURLに
  - `[@your_handle]` → 自分のX (Twitter)ハンドルに
  - `[@your_github]` → 自分のGitHubユーザー名に

- [ ] **ローカルでセットアップスクリプトをテスト**
  ```bash
  cd hantani-mcp-setup
  ./scripts/install-all.sh
  ./scripts/verify-setup.sh
  ```

- [ ] **各環境で動作確認**
  - [ ] Cline (VS Code)
  - [ ] Cursor IDE
  - [ ] Gemini CLI
  - [x] Genspark ✅
  - [ ] Claude Desktop

## 📝 note記事執筆

### 記事構成（案）

**タイトル:**
「AIエージェントにブラウザデバッグ能力を！Chrome DevTools MCP完全ガイド【Cursor/Cline/Gemini CLI/Genspark対応】」

**構成:**

1. **導入部（問題提起）**
   - [ ] CursorやClineでコードを書く時の課題
   - [ ] ブラウザコンソールとAIの間の断絶
   - [ ] Chrome DevTools MCPで解決できること

2. **Chrome DevTools MCPとは**
   - [ ] Google公式開発のMCPサーバー
   - [ ] 主な機能の紹介
   - [ ] 対応環境の一覧

3. **セットアップ方法**
   - [ ] リポジトリのリンク挿入
   - [ ] ワンコマンドセットアップの紹介
   - [ ] 各環境別の設定方法（スクリーンショット）

4. **実践例1: Reactアプリのデバッグ**
   - [ ] APIエラーの診断
   - [ ] コンソールエラーの分析
   - [ ] 実際のコード例

5. **実践例2: パフォーマンス最適化**
   - [ ] Core Web Vitalsの測定
   - [ ] ボトルネックの特定
   - [ ] 改善前後の比較

6. **Genspark特有の使い方**
   - [ ] Genspark設定の特徴
   - [ ] マルチモデル連携
   - [ ] リアルタイム検索統合

7. **CVWワークフローへの統合**
   - [ ] AI協働開発の新しい形
   - [ ] 環境の永続化（dotfiles）
   - [ ] PC移行時の対応

8. **まとめ**
   - [ ] 主なメリットの振り返り
   - [ ] GitHubスター依頼
   - [ ] コミュニティへの参加呼びかけ

### 記事用の素材

- [ ] **スクリーンショット撮影**
  - [ ] Clineの設定画面
  - [ ] MCPサーバーのリスト表示
  - [ ] 実際のデバッグ画面
  - [ ] パフォーマンスメトリクス

- [ ] **動画/GIF作成（オプション）**
  - [ ] セットアップの流れ
  - [ ] AIがブラウザをデバッグする様子
  - [ ] リアルタイム分析のデモ

## 🎨 リポジトリの改善

### 優先度: 高

- [ ] **README_EN.md の作成**
  - 英語版のREADMEを追加
  - グローバルな開発者コミュニティへのリーチ

- [ ] **CONTRIBUTING.md の作成**
  - コントリビューションガイドライン
  - プルリクエストのルール
  - Issue作成の指針

- [ ] **GitHub Actions の設定**
  - [ ] リンク切れチェック
  - [ ] マークダウンのlint
  - [ ] スクリプトの自動テスト

### 優先度: 中

- [ ] **動画チュートリアルの作成**
  - YouTube動画へのリンク
  - セットアップの実演
  - 実践的な使用例

- [ ] **FAQ.md の作成**
  - よくある質問と回答
  - トラブルシューティングから抽出

- [ ] **CHANGELOG.md の作成**
  - バージョン管理
  - 変更履歴の記録

### 優先度: 低

- [ ] **各種バッジの追加**
  - License badge
  - Stars badge
  - Issues badge
  - PRs welcome badge

- [ ] **より多くのサンプル追加**
  - Vue.jsアプリのデバッグ
  - Next.js SSRのデバッグ
  - Angularアプリのデバッグ

## 📢 プロモーション

### note記事公開後

- [ ] **Xで告知**
  - リポジトリリンク付きツイート
  - 主な機能の紹介スレッド
  - #AI開発 #MCP #ChromeDevTools などのハッシュタグ

- [ ] **はてなブログで紹介**
  - 技術的な詳細を深掘り
  - noteとの相互リンク

- [ ] **Quoraで回答**
  - 関連する質問に回答
  - リポジトリを紹介

- [ ] **GitHubコミュニティ**
  - Awesome MCP Serversへのプルリクエスト
  - 関連リポジトリでの紹介

### コミュニティエンゲージメント

- [ ] **Issueテンプレートの作成**
  - バグレポート
  - 機能リクエスト
  - 質問

- [ ] **Discussionsの有効化**
  - Q&A
  - アイデア共有
  - ショーケース

## 🔄 継続的な改善

### 定期的にやること

- [ ] **週次: Issue/PRの確認**
  - コミュニティからのフィードバック対応
  - バグ修正
  - 新機能の検討

- [ ] **月次: ドキュメントの更新**
  - Chrome DevTools MCPの最新版対応
  - 新しいユースケースの追加
  - トラブルシューティングの更新

- [ ] **四半期: 大規模改善**
  - 新しいエディタ/IDE対応
  - チュートリアル動画の追加
  - パフォーマンス改善

## 📊 メトリクスの追跡

### 追跡する指標

- [ ] **GitHubスター数**
  - 目標: 最初の1ヶ月で100スター
  - 目標: 6ヶ月で500スター

- [ ] **note記事のビュー数**
  - 初週のビュー数
  - スキ数
  - コメント数

- [ ] **コミュニティの成長**
  - Issue/PR数
  - Contributors数
  - Fork数

## 🎯 長期的なビジョン

- [ ] **他のMCPサーバーの統合**
  - ファイルシステムMCP
  - データベースMCP
  - API連携MCP

- [ ] **GUIツールの開発**
  - ワンクリックインストーラー
  - 設定管理ツール
  - ビジュアルデバッガー

- [ ] **ワークショップ/ウェビナー開催**
  - オンラインハンズオン
  - CVWワークフローとの統合実演
  - コミュニティイベント

## 💡 アイデアメモ

### 将来の機能

- [ ] **設定のインポート/エクスポート**
  - 複数PCでの設定同期
  - チーム内での設定共有

- [ ] **テンプレートプロジェクト**
  - React + Chrome DevTools MCP
  - Next.js + Chrome DevTools MCP
  - Vue.js + Chrome DevTools MCP

- [ ] **VSCode拡張の開発**
  - ワンクリックセットアップ
  - GUI設定
  - ステータス表示

## 📞 サポート体制

- [ ] **サポートチャンネルの設定**
  - GitHub Discussions
  - Discord サーバー（オプション）
  - X (Twitter) DMでの質問受付

- [ ] **ドキュメントの多言語化**
  - 英語版（優先度: 高）
  - 中国語版（優先度: 中）
  - 韓国語版（オプション）

---

## 🎉 完了したタスク

✅ リポジトリの初期構造作成  
✅ README.mdの作成  
✅ 各環境用の設定ファイル作成  
✅ セットアップスクリプトの作成  
✅ Genspark専用ガイドの作成  
✅ トラブルシューティングガイドの作成  
✅ ユースケース集の作成  
✅ Reactアプリデバッグ例の作成  
✅ パフォーマンス分析例の作成  
✅ LICENSE追加  
✅ .gitignore追加  
✅ AI Drive へのファイル保存完了  
✅ GitHubリポジトリ公開 (https://github.com/garyohosu/hantani-mcp-setup)  
✅ GitHub Pages 有効化 (https://garyohosu.github.io/hantani-mcp-setup/)  
✅ TODO.md の進捗記録  

---

## 📋 作業ログ

### 2025-11-16 - Genspark E2B Sandbox MCP サーバー設定

**追加したMCPサーバー:**

1. **Memory MCP** ✅
   - 長期記憶機能
   - エンティティとリレーションの管理
   - 知識グラフの構築
   - 動作確認: 正常

2. **OpenAPI MCP** ✅
   - OpenAPI/Swagger ドキュメント解析
   - API仕様書の検証
   - cURL コマンド生成
   - C# コードスニペット生成
   - 動作確認: 正常（Petstore API で検証済み）

3. **Code Interpreter MCP** ✅
   - Python コード実行環境
   - セッション持続型（Session ID: 1763278449）
   - Python 3.12.11
   - データ分析・計算処理対応
   - 動作確認: 正常（2+2=4 で検証済み）

**Genspark での MCP サーバー管理方法:**
- E2B Sandbox を使用したクラウド実行環境
- Pre-built MCP Servers から選択可能
- Custom MCP Servers も GitHub リポジトリから追加可能
- Chrome DevTools MCP は E2B 環境では動作困難（ローカルブラウザ接続が必要なため）

**次のステップ:**
- [ ] Memory MCP にプロジェクト情報を保存
- [ ] Code Interpreter でデータ分析の実践
- [ ] OpenAPI を使った API 統合の検証
- [ ] 他の有用な Pre-built MCP サーバーの探索
  - Playwright (ブラウザ自動化)
  - arXiv (学術論文検索)
  - Obsidian (ノート管理)
  - Exa (AI検索エンジン)

---

**最終更新:** 2025-11-16  
**作成者:** hantani  

🐱 このTODOリストも随時更新していきましょう！
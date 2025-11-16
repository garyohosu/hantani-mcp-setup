# 💡 Chrome DevTools MCP ユースケース集

実際の開発シーンで役立つChrome DevTools MCPの使い方を紹介します。

## 📋 目次

- [Webアプリケーション開発](#webアプリケーション開発)
- [パフォーマンス最適化](#パフォーマンス最適化)
- [デバッグとトラブルシューティング](#デバッグとトラブルシューティング)
- [セキュリティとプライバシー](#セキュリティとプライバシー)
- [開発ワークフロー改善](#開発ワークフロー改善)

---

## Webアプリケーション開発

### ユースケース1: ReactアプリのAPIエラー診断

**シナリオ:** ReactアプリでAPIリクエストが失敗している

**手順:**

```
あなた: 「localhost:3000のReactアプリでAPIエラーが出てる。調べて」

AI: Chromeを起動してアプリに接続します...
    start_chrome_and_connect("localhost:3000")
    
    ネットワークリクエストを確認します...
    get_network_requests(filter_status=500)
    
    【結果】
    - POST /api/users → 500 Internal Server Error
    - レスポンス: {"error": "Database connection failed"}
    
    データベース接続の問題のようです。
    詳細なエラーログを確認しますか？
```

**効果:**
- エラーの原因を即座に特定
- フロントエンドとバックエンドのどちらの問題か判別
- 修正のための具体的な情報を取得

### ユースケース2: Next.jsのSSRデバッグ

**シナリオ:** サーバーサイドレンダリングで期待通りのデータが表示されない

**手順:**

```
あなた: 「Next.jsのSSRページでデータが空になってる」

AI: ページを読み込んでコンソールを確認します...
    navigate_to_url("localhost:3000/products")
    get_console_error_summary()
    
    【コンソールエラー】
    Warning: Prop `data` did not match. Server: "undefined" Client: "[...]"
    
    ハイドレーションの不一致が発生しています。
    getServerSidePropsのreturn値を確認しますか？
```

### ユースケース3: Vue.jsのリアクティビティ問題

**シナリオ:** Vueコンポーネントが更新されない

**手順:**

```
あなた: 「Vueでデータを変更しても画面が更新されない」

AI: コンソールをリアルタイム監視します...
    monitor_console_live(15)
    
    今、問題の操作を実行してください。
    
    【検出されたログ】
    - Vue warn: Avoid mutating a prop directly
    
    親コンポーネントから渡されたpropsを直接変更しようとしています。
    ローカルstateにコピーして使用する必要があります。
```

---

## パフォーマンス最適化

### ユースケース4: ページ読み込み速度の改善

**シナリオ:** Webページの読み込みが遅い

**手順:**

```
あなた: 「トップページの読み込みが遅い。原因を特定して」

AI: パフォーマンスメトリクスを取得します...
    navigate_to_url("localhost:3000")
    get_performance_metrics()
    
    【分析結果】
    - DOMContentLoaded: 3.2秒
    - Load: 5.8秒
    - 大きなリソース:
      * bundle.js (2.4MB) - 2.1秒
      * hero-image.jpg (1.8MB) - 1.3秒
    
    【推奨される改善策】
    1. JavaScriptバンドルのコード分割
    2. 画像の最適化（WebP形式、遅延読み込み）
    3. 未使用CSSの削除
```

### ユースケース5: メモリリーク検出

**シナリオ:** SPAで長時間使用するとメモリ使用量が増える

**手順:**

```
あなた: 「アプリを使ってるとだんだん重くなる」

AI: 初期状態のメモリ使用量を記録します...
    get_performance_metrics()
    
    では、通常の操作を5分間実行してください。
    その後、再度メモリを確認します。
    
    【結果】
    - 初期: JSヒープ 45MB
    - 5分後: JSヒープ 180MB
    
    メモリリークの可能性があります。
    イベントリスナーの解除漏れや、
    DOMへの参照保持が原因かもしれません。
```

### ユースケース6: CSSパフォーマンス最適化

**シナリオ:** 未使用のCSSが多く、ファイルサイズが大きい

**手順:**

```
あなた: 「CSSファイルが大きすぎる。削減できる？」

AI: CSS使用状況を分析します...
    start_css_coverage_tracking()
    navigate_to_url("localhost:3000")
    [ページを操作]
    stop_css_coverage_tracking()
    
    【結果】
    - 全CSS: 450KB
    - 未使用: 320KB (71%)
    
    【削減できるCSS】
    - Bootstrap全体をインポート → 使用する部分のみ
    - 古いブラウザ用のprefixが不要
    - 未使用のユーティリティクラス
```

---

## デバッグとトラブルシューティング

### ユースケース7: JavaScriptエラーの一括分析

**シナリオ:** 本番環境で複数のエラーが報告されている

**手順:**

```
あなた: 「本番環境でエラーが多発してる。まとめて」

AI: エラーサマリーを取得します...
    connect_to_browser()
    get_console_error_summary()
    
    【エラー分類】
    
    🔴 Critical (3件):
    - TypeError: Cannot read property 'map' of undefined
      場所: UserList.jsx:45
      頻度: 12回
      
    ⚠️ Warning (8件):
    - React: componentWillMount is deprecated
      場所: OldComponent.jsx
      
    📝 Info (15件):
    - API response time: 1200ms (slow)
    
    【優先度順の修正提案】
    1. UserList.jxsのnullチェック追加
    2. OldComponentのライフサイクルメソッド更新
    3. APIレスポンス時間の最適化
```

### ユースケース8: CORSエラーの診断

**シナリオ:** APIリクエストがCORSエラーで失敗する

**手順:**

```
あなた: 「APIにアクセスできない。CORSエラーが出る」

AI: ネットワークリクエストとコンソールを確認します...
    get_network_requests(filter_domain="api.example.com")
    get_console_logs(level="error")
    
    【検出されたエラー】
    Access to fetch at 'https://api.example.com/data'
    from origin 'http://localhost:3000' has been blocked by CORS policy:
    No 'Access-Control-Allow-Origin' header is present.
    
    【解決策】
    サーバー側で以下のヘッダーを追加:
    Access-Control-Allow-Origin: http://localhost:3000
    Access-Control-Allow-Methods: GET, POST, PUT, DELETE
    Access-Control-Allow-Headers: Content-Type
```

### ユースケース9: 認証フローのデバッグ

**シナリオ:** ログイン後にセッションが保持されない

**手順:**

```
あなた: 「ログインしてもすぐログアウトされる」

AI: 認証フローを追跡します...
    navigate_to_url("localhost:3000/login")
    monitor_console_live(20)
    
    ログインを実行してください...
    
    【ネットワーク分析】
    POST /api/auth/login → 200 OK
    Set-Cookie: session_id=abc123; HttpOnly; SameSite=Strict
    
    【Cookie確認】
    get_cookies(domain="localhost")
    
    【問題】
    SameSite=Strictが設定されているため、
    クロスサイトリクエストでCookieが送信されません。
    
    【解決策】
    開発環境: SameSite=Lax
    本番環境: SameSite=None; Secure
```

---

## セキュリティとプライバシー

### ユースケース10: XSS脆弱性のチェック

**シナリオ:** ユーザー入力を表示する機能のセキュリティチェック

**手順:**

```
あなた: 「ユーザーのコメント機能、XSSの心配ない？」

AI: セキュリティをチェックします...
    navigate_to_url("localhost:3000/comments")
    
    テスト入力を検査します:
    execute_javascript(`
      document.querySelector('#comment').value = '<script>alert("XSS")</script>';
      document.querySelector('form').submit();
    `)
    
    【結果】
    ✅ スクリプトタグがエスケープされています
    表示: &lt;script&gt;alert("XSS")&lt;/script&gt;
    
    【追加確認が必要な箇所】
    - HTMLイベントハンドラ（onload等）
    - CSSインジェクション
    - URLパラメータからの入力
```

### ユースケース11: Cookie設定の監査

**シナリオ:** Cookieのセキュリティ設定を確認

**手順:**

```
あなた: 「Cookieの設定、セキュアになってる？」

AI: Cookie設定を確認します...
    get_all_cookies()
    
    【監査結果】
    
    ⚠️ 改善が必要:
    - session_id: HttpOnlyが未設定
      → JSからアクセス可能（XSS脆弱性）
      
    - auth_token: Secureフラグが未設定
      → HTTP通信で送信される可能性
      
    ✅ 適切な設定:
    - csrf_token: HttpOnly, Secure, SameSite=Strict
    
    【推奨設定】
    Set-Cookie: session_id=...; 
                HttpOnly; 
                Secure; 
                SameSite=Strict;
                Max-Age=3600
```

---

## 開発ワークフロー改善

### ユースケース12: レスポンシブデザインの確認

**シナリオ:** 各画面サイズでのレイアウト確認

**手順:**

```
あなた: 「モバイル表示で崩れてないか確認して」

AI: 各ビューポートでチェックします...
    
    【デスクトップ (1920x1080)】
    get_page_info()
    ✅ レイアウト正常
    
    【タブレット (768x1024)】
    execute_javascript('
      document.querySelector("meta[name=viewport]").content = "width=768"
    ')
    get_element_box_model(node_id)
    ⚠️ サイドバーがメインコンテンツと重なっています
    
    【モバイル (375x667)】
    ❌ ナビゲーションメニューが画面外
    
    【修正が必要なCSS】
    @media (max-width: 768px) {
      .sidebar { display: none; }
      .mobile-menu { display: block; }
    }
```

### ユースケース13: A/Bテストの実装確認

**シナリオ:** A/Bテストが正しく動作しているか確認

**手順:**

```
あなた: 「A/Bテストでバリアントが正しく表示される？」

AI: バリアント切り替えをテストします...
    
    【バリアントA】
    set_cookie("ab_test", "variant_a", "localhost")
    navigate_to_url("localhost:3000")
    inspect_console_object("window.abTest")
    → { variant: "A", feature: "blue_button" }
    ✅ 青いボタンが表示されています
    
    【バリアントB】
    set_cookie("ab_test", "variant_b", "localhost")
    navigate_to_url("localhost:3000")
    inspect_console_object("window.abTest")
    → { variant: "B", feature: "green_button" }
    ✅ 緑のボタンが表示されています
    
    【計測確認】
    get_network_requests(filter_domain="analytics.example.com")
    ✅ アナリティクスイベントが正しく送信されています
```

### ユースケース14: サードパーティスクリプトの影響調査

**シナリオ:** 外部スクリプトがパフォーマンスに与える影響を測定

**手順:**

```
あなた: 「Google Analyticsを外すとどれくらい速くなる？」

AI: スクリプト有無でパフォーマンスを比較します...
    
    【GAあり】
    navigate_to_url("localhost:3000")
    get_performance_metrics()
    - DOMContentLoaded: 1.8秒
    - Load: 3.2秒
    - JSヒープ: 42MB
    
    【GAなし（ブロック）】
    execute_javascript('
      window["ga-disable-UA-XXXXX"] = true;
    ')
    navigate_to_url("localhost:3000")
    get_performance_metrics()
    - DOMContentLoaded: 1.5秒 (300ms改善)
    - Load: 2.6秒 (600ms改善)
    - JSヒープ: 38MB (4MB削減)
    
    【結論】
    GAによるオーバーヘッド: 約600ms
    遅延読み込みを検討してください
```

---

## CVW (Creative Vibe Writing) ワークフロー統合

### ユースケース15: 執筆環境のパフォーマンス最適化

**シナリオ:** Web上の執筆エディタの動作を改善

```
あなた: 「noteのエディタで長文書くと重くなる」

AI: エディタのパフォーマンスを分析します...
    navigate_to_url("note.com/your_article/edit")
    
    【初期状態】
    get_performance_metrics()
    - メモリ: 85MB
    
    【5000文字入力後】
    - メモリ: 220MB (増加: 135MB)
    - リフロー回数: 1200回/秒
    
    【ボトルネック】
    - 文字入力ごとにDOM全体を再計算
    - 自動保存が頻繁すぎる (2秒ごと)
    
    【改善提案】
    - ローカルMarkdownエディタの使用
    - または、入力デバウンスの実装
```

---

## まとめ

Chrome DevTools MCPを使うことで：

✅ **デバッグ時間を大幅短縮**  
✅ **パフォーマンス問題を素早く特定**  
✅ **セキュリティ問題を事前に発見**  
✅ **開発ワークフローを自動化**

これらのユースケースを参考に、あなたの開発スタイルに合わせてカスタマイズしてください！

---

🐱 Created by hantani - AI時代の創作技術研究者

**関連リンク:**
- [Reactアプリデバッグの詳細例](../examples/debug-react-app.md)
- [パフォーマンス分析の詳細例](../examples/performance-analysis.md)

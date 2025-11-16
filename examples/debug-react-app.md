# 🔍 Reactアプリケーションのデバッグ実践例

Chrome DevTools MCPを使ったReactアプリケーションの実践的なデバッグ方法を紹介します。

## 📋 シナリオ

あなたはReactでユーザー管理アプリを開発中です。以下の問題が発生しています：

1. ユーザーリストが表示されない
2. APIリクエストが失敗している
3. コンソールにエラーが出ている

## 🚀 ステップバイステップデバッグ

### ステップ1: 環境のセットアップ

```bash
# 開発サーバーを起動
npm run dev
# → http://localhost:3000 で起動
```

AIエージェントに指示：
```
「localhost:3000のReactアプリをデバッグして」
```

AIの実行:
```javascript
start_chrome_and_connect("localhost:3000")
```

### ステップ2: コンソールエラーの確認

AIの実行:
```javascript
get_console_error_summary()
```

結果:
```
【エラーサマリー】

🔴 Errors (2):
  1. TypeError: Cannot read property 'map' of undefined
     at UserList.jsx:45:28
     at renderWithHooks (react-dom.js:1234)
     
  2. NetworkError: Failed to fetch
     at fetch (UserService.js:12)

⚠️ Warnings (1):
  1. Warning: Each child in a list should have a unique "key" prop.
     at UserItem.jsx:8
```

### ステップ3: ネットワークリクエストの調査

AIの実行:
```javascript
get_network_requests(filter_domain="api.example.com")
```

結果:
```
【ネットワークリクエスト】

GET /api/users
Status: 500 Internal Server Error
Response Time: 245ms
Response:
{
  "error": "Database connection failed",
  "detail": "Connection timeout after 5000ms"
}
```

### ステップ4: 詳細なレスポンスデータの取得

AIの実行:
```javascript
get_network_response("request-123")
```

結果:
```
【リクエスト詳細】

Headers:
  Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
  Content-Type: application/json

Response Headers:
  Content-Type: application/json
  X-Request-ID: abc-123-def

Response Body:
{
  "error": "Database connection failed",
  "timestamp": "2025-11-16T10:30:00Z",
  "path": "/api/users"
}
```

### ステップ5: Reactコンポーネントの状態確認

AIの実行:
```javascript
inspect_console_object("window.__REACT_DEVTOOLS_GLOBAL_HOOK__")
```

または、コンポーネントの状態を直接確認:
```javascript
execute_javascript(`
  const userListComponent = document.querySelector('[data-component="UserList"]');
  console.log('Component state:', userListComponent.__reactInternalInstance$);
`)

get_console_logs(limit=5)
```

## 🔧 問題の特定と修正

### 問題1: データがundefined

**原因:** APIリクエストが失敗しているため、`users`がundefinedのまま

**現在のコード (UserList.jsx):**
```jsx
function UserList() {
  const [users, setUsers] = useState();
  
  useEffect(() => {
    fetch('/api/users')
      .then(res => res.json())
      .then(data => setUsers(data));
  }, []);
  
  return (
    <div>
      {users.map(user => (  // ❌ usersがundefinedの時にエラー
        <UserItem key={user.id} user={user} />
      ))}
    </div>
  );
}
```

**修正後:**
```jsx
function UserList() {
  const [users, setUsers] = useState([]);  // ✅ 初期値を空配列に
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    fetch('/api/users')
      .then(res => {
        if (!res.ok) throw new Error('API request failed');
        return res.json();
      })
      .then(data => {
        setUsers(data);
        setLoading(false);
      })
      .catch(err => {
        setError(err.message);
        setLoading(false);
      });
  }, []);
  
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  
  return (
    <div>
      {users.map(user => (
        <UserItem key={user.id} user={user} />
      ))}
    </div>
  );
}
```

### 問題2: APIエラーの根本原因

**MCPで確認:**
```javascript
get_network_requests(filter_status=500)
```

**サーバー側の問題:** データベース接続タイムアウト

**一時的な回避策（開発環境）:**
```javascript
// モックデータを使用
const mockUsers = [
  { id: 1, name: 'Alice', email: 'alice@example.com' },
  { id: 2, name: 'Bob', email: 'bob@example.com' }
];

// APIが失敗した場合の fallback
.catch(err => {
  console.warn('API failed, using mock data');
  setUsers(mockUsers);
});
```

## 📊 修正後の動作確認

### ステップ1: ページをリロード

AIの実行:
```javascript
navigate_to_url("localhost:3000")
```

### ステップ2: エラーが解消されたか確認

AIの実行:
```javascript
get_console_error_summary()
```

期待される結果:
```
【エラーサマリー】

✅ No errors found!

⚠️ Warnings (1):
  1. Warning: Each child in a list should have a unique "key" prop.
     at UserItem.jsx:8
     → これは既にkey propを追加済みなので解消
```

### ステップ3: パフォーマンスの確認

AIの実行:
```javascript
get_performance_metrics()
```

結果:
```
【パフォーマンス】

Page Load:
  - DOMContentLoaded: 450ms
  - Load Complete: 820ms

Resources:
  - Total Scripts: 3 (245KB)
  - Total Stylesheets: 2 (45KB)
  - Total Images: 5 (180KB)

Memory:
  - JS Heap: 12.5MB
  - DOM Nodes: 245
```

## 🎯 追加の最適化

### React DevTools統合

**自動的にReact特有の問題を検出:**

```javascript
// Reactの不要な再レンダリングを検出
monitor_console_live(10)

// ユーザーリストを操作...

// 検出された警告:
// "UserList re-rendered 5 times in 2 seconds"
```

**修正: React.memoを使用**
```jsx
const UserItem = React.memo(({ user }) => {
  return (
    <div className="user-item">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
    </div>
  );
});
```

### Network Request のキャッシング

**問題:** 同じAPIを何度もリクエストしている

**MCPで検出:**
```javascript
get_network_requests(filter_domain="api.example.com")

// 結果: 同じURLへのリクエストが3回
// GET /api/users - 10:30:00
// GET /api/users - 10:30:05
// GET /api/users - 10:30:10
```

**修正: SWRまたはReact Queryを使用**
```jsx
import useSWR from 'swr';

function UserList() {
  const { data: users, error } = useSWR('/api/users', fetcher, {
    revalidateOnFocus: false,
    dedupingInterval: 60000  // 60秒間はキャッシュを使用
  });
  
  if (error) return <div>Error: {error.message}</div>;
  if (!users) return <div>Loading...</div>;
  
  return (
    <div>
      {users.map(user => (
        <UserItem key={user.id} user={user} />
      ))}
    </div>
  );
}
```

## 🧪 テスト確認

### エラーハンドリングのテスト

**シナリオ:** APIが500エラーを返す場合

```javascript
// MCPでネットワークをシミュレート
execute_javascript(`
  // Fetchをモック
  window.fetch = () => Promise.reject(new Error('Network error'));
`)

// ページをリロード
navigate_to_url("localhost:3000")

// エラー表示を確認
get_page_info()
```

期待される表示:
```
✅ エラーメッセージが表示されている
"Error: Network error"
```

## 📝 デバッグチェックリスト

### 完了すべき項目

- [x] コンソールエラーを確認
- [x] ネットワークリクエストを分析
- [x] APIレスポンスの詳細を確認
- [x] Reactコンポーネントの状態を確認
- [x] エラーハンドリングを実装
- [x] 初期値を適切に設定
- [x] パフォーマンスを確認
- [x] 不要な再レンダリングを削減
- [x] ネットワークリクエストを最適化
- [x] エラーケースをテスト

## 🎓 学んだベストプラクティス

1. **初期値の重要性**
   - `useState([])`で空配列を初期値に
   - undefinedエラーを防ぐ

2. **エラーハンドリング**
   - try-catchまたは.catch()を必ず追加
   - ユーザーにわかりやすいエラーメッセージ

3. **ローディング状態**
   - データ取得中の表示を提供
   - UX向上

4. **MCPの活用**
   - リアルタイムでブラウザを監視
   - 手動デバッグより効率的

5. **パフォーマンス最適化**
   - React.memoで不要な再レンダリング防止
   - データキャッシングで無駄なリクエスト削減

---

## 🔗 関連リソース

- [Chrome DevTools MCP公式ドキュメント](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [Reactデバッグのベストプラクティス](https://react.dev/learn/debugging)
- [ユースケース集](../docs/use-cases.md)

---

🐱 Created by hantani - AI時代の創作技術研究者

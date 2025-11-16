# ⚡ Webパフォーマンス分析の実践例

Chrome DevTools MCPを使った実践的なパフォーマンス分析と最適化の方法を紹介します。

## 📋 シナリオ

あなたのECサイトで以下の問題が報告されています：

- トップページの読み込みが遅い（5秒以上）
- スクロールがカクつく
- モバイルでのパフォーマンスが特に悪い

目標: ページ読み込み時間を2秒以下に改善

## 🔍 初期分析

### ステップ1: ベースラインの測定

AIに指示:
```
「localhost:3000のパフォーマンスを分析して」
```

AIの実行:
```javascript
start_chrome_and_connect("localhost:3000")
get_page_info()
```

結果:
```
【ページ情報】

Load Times:
  - First Paint: 2.8秒
  - DOMContentLoaded: 3.5秒
  - Load Complete: 5.2秒

Resources:
  - Scripts: 12個 (合計: 2.8MB)
  - Stylesheets: 8個 (合計: 450KB)
  - Images: 35個 (合計: 4.2MB)
  - Fonts: 6個 (合計: 320KB)

DOM:
  - Total Nodes: 1,842
  - Depth: 18
```

### ステップ2: 詳細なパフォーマンスメトリクス

AIの実行:
```javascript
get_performance_metrics()
```

結果:
```
【パフォーマンスメトリクス】

Core Web Vitals:
  - LCP (Largest Contentful Paint): 4.2秒 ❌ (目標: 2.5秒以下)
  - FID (First Input Delay): 180ms ⚠️ (目標: 100ms以下)
  - CLS (Cumulative Layout Shift): 0.25 ❌ (目標: 0.1以下)

Network:
  - Total Transfer: 7.8MB
  - Total Requests: 61
  - Cache Hit Rate: 23%

JavaScript:
  - Parse Time: 850ms
  - Compile Time: 420ms
  - Execution Time: 1,200ms

Memory:
  - JS Heap Size: 45MB
  - DOM Size: 8MB
```

## 🎯 ボトルネックの特定

### 問題1: 巨大なJavaScriptバンドル

AIの実行:
```javascript
get_network_requests(filter_domain="localhost")
```

検出された問題:
```
【大きなリソース】

1. bundle.js - 2.4MB (gzip前)
   - 読み込み時間: 1.8秒
   - 内容: React, ルーター, 全ページコンポーネント

2. vendor.js - 580KB
   - 読み込み時間: 450ms
   - 内容: lodash全体, moment.js, その他

3. analytics.js - 120KB
   - 読み込み時間: 150ms
   - ブロッキング: Yes
```

### 問題2: 最適化されていない画像

```
【画像の問題】

1. hero-image.jpg - 1.8MB (3000x2000px)
   - 表示サイズ: 800x533px
   - 形式: JPEG
   - 圧縮: なし

2. product-*.jpg - 平均 250KB
   - 35個の商品画像
   - 合計: 8.75MB
   - 遅延読み込み: なし
```

### 問題3: CSS肥大化

AIの実行:
```javascript
start_css_coverage_tracking()
// ページを操作
stop_css_coverage_tracking()
```

結果:
```
【CSS使用状況】

- 全CSS: 450KB
- 実際に使用: 130KB (29%)
- 未使用: 320KB (71%) ❌

未使用の主な原因:
1. Bootstrap全体をインポート
2. 旧デザインのCSS残存
3. 未使用のユーティリティクラス
```

## 🔧 最適化の実装

### 最適化1: コード分割 (Code Splitting)

**Before:**
```jsx
// App.jsx - すべてを一度に読み込み
import Home from './pages/Home';
import Products from './pages/Products';
import Cart from './pages/Cart';
import Checkout from './pages/Checkout';
// ... 他にも10個以上

function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/products" element={<Products />} />
      <Route path="/cart" element={<Cart />} />
      {/* ... */}
    </Routes>
  );
}
```

**After:**
```jsx
// App.jsx - 必要な時だけ読み込み
import { lazy, Suspense } from 'react';

const Home = lazy(() => import('./pages/Home'));
const Products = lazy(() => import('./pages/Products'));
const Cart = lazy(() => import('./pages/Cart'));
const Checkout = lazy(() => import('./pages/Checkout'));

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/products" element={<Products />} />
        <Route path="/cart" element={<Cart />} />
        {/* ... */}
      </Routes>
    </Suspense>
  );
}
```

**結果の確認:**
```javascript
get_network_requests()
```

```
✅ 改善後:
- 初期バンドル: 450KB (削減: 1.95MB)
- Home用チャンク: 180KB
- Products用チャンク: 220KB
- 初回読み込み: 630KB (73%削減)
```

### 最適化2: 画像の最適化

**画像変換スクリプト:**
```bash
# WebP形式に変換 + 圧縮
npm install sharp

# optimize-images.js
const sharp = require('sharp');

async function optimizeImage(input, output) {
  await sharp(input)
    .resize(800, null, { withoutEnlargement: true })
    .webp({ quality: 80 })
    .toFile(output);
}
```

**遅延読み込みの実装:**
```jsx
// Before
<img src={product.image} alt={product.name} />

// After - Native lazy loading
<img 
  src={product.image} 
  alt={product.name}
  loading="lazy"
  width="400"
  height="300"
/>

// さらに最適化: WebP + fallback
<picture>
  <source srcSet={product.imageWebP} type="image/webp" />
  <img 
    src={product.imageJPG} 
    alt={product.name}
    loading="lazy"
  />
</picture>
```

**結果の確認:**
```javascript
get_network_requests()
get_performance_metrics()
```

```
✅ 改善後:
- hero-image.webp: 180KB (削減: 90%)
- product画像: 平均35KB (削減: 86%)
- 初回読み込み画像: 3枚のみ (遅延読み込み)
- LCP: 2.1秒 (改善: 2.1秒)
```

### 最適化3: CSS最適化

**PurgeCSSの導入:**
```javascript
// postcss.config.js
module.exports = {
  plugins: [
    require('@fullhuman/postcss-purgecss')({
      content: ['./src/**/*.{js,jsx,ts,tsx}'],
      defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
    })
  ]
}
```

**Critical CSSの抽出:**
```javascript
// インライン化するCSSを最小限に
<style>{criticalCSS}</style>
<link rel="stylesheet" href="main.css" media="print" onload="this.media='all'" />
```

**結果の確認:**
```javascript
start_css_coverage_tracking()
navigate_to_url("localhost:3000")
stop_css_coverage_tracking()
```

```
✅ 改善後:
- CSS合計: 85KB (削減: 81%)
- 使用率: 95%
- Critical CSS: 12KB (インライン)
- First Paint: 0.8秒 (改善: 2.0秒)
```

### 最適化4: サードパーティスクリプトの最適化

**Before:**
```html
<head>
  <!-- ブロッキング -->
  <script src="https://www.google-analytics.com/analytics.js"></script>
  <script src="https://connect.facebook.net/en_US/sdk.js"></script>
</head>
```

**After:**
```html
<head>
  <!-- 遅延読み込み -->
  <script async src="https://www.google-analytics.com/analytics.js"></script>
  
  <!-- さらに遅延 -->
  <script>
    window.addEventListener('load', () => {
      setTimeout(() => {
        const script = document.createElement('script');
        script.src = 'https://connect.facebook.net/en_US/sdk.js';
        script.async = true;
        document.body.appendChild(script);
      }, 3000);
    });
  </script>
</head>
```

## 📊 最終結果の測定

### パフォーマンス再測定

AIの実行:
```javascript
navigate_to_url("localhost:3000")
get_performance_metrics()
```

結果:
```
【最終パフォーマンス】

Core Web Vitals:
  - LCP: 1.8秒 ✅ (改善: 2.4秒 / 57%削減)
  - FID: 45ms ✅ (改善: 135ms / 75%削減)
  - CLS: 0.05 ✅ (改善: 0.20 / 80%削減)

Load Times:
  - First Paint: 0.8秒 (改善: 2.0秒)
  - DOMContentLoaded: 1.2秒 (改善: 2.3秒)
  - Load Complete: 1.9秒 ✅ (改善: 3.3秒 / 63%削減)

Resources:
  - Total Transfer: 1.2MB (削減: 6.6MB / 85%削減)
  - Total Requests: 18 (削減: 43 / 70%削減)

JavaScript:
  - Initial Bundle: 630KB (削減: 2.4MB / 74%削減)
  - Parse + Compile: 180ms (改善: 1,090ms)

Memory:
  - JS Heap: 18MB (削減: 27MB / 60%削減)
```

### モバイルパフォーマンス

**Lighthouse スコア（シミュレート）:**
```javascript
execute_javascript(`
  // モバイル環境をシミュレート
  Object.defineProperty(navigator, 'connection', {
    value: { effectiveType: '4g', downlink: 10 }
  });
`)
```

結果:
```
Before:
  - Performance: 42/100 ❌
  - Accessibility: 88/100
  - Best Practices: 79/100
  - SEO: 92/100

After:
  - Performance: 94/100 ✅
  - Accessibility: 95/100
  - Best Practices: 95/100
  - SEO: 98/100
```

## 📝 最適化チェックリスト

### 完了した最適化

- [x] コード分割（React.lazy）
- [x] 画像最適化（WebP、遅延読み込み）
- [x] CSS最適化（PurgeCSS、Critical CSS）
- [x] サードパーティスクリプトの遅延読み込み
- [x] Gzip/Brotli圧縮の有効化
- [x] ブラウザキャッシュの設定
- [x] CDNの活用
- [x] 不要なライブラリの削除

### 追加で検討すべき最適化

- [ ] Service Workerによるオフライン対応
- [ ] HTTP/2 Server Push
- [ ] Prefetch/Preload の最適化
- [ ] Web Workersでの重い処理の分離

## 🎓 学んだベストプラクティス

1. **測定は最適化の基本**
   - まず現状を正確に把握
   - MCPで簡単にメトリクスを取得

2. **低コストの最適化から着手**
   - 画像圧縮、遅延読み込み
   - 効果が大きく実装が簡単

3. **段階的な改善**
   - 一度にすべてやらない
   - 各最適化の効果を測定

4. **Core Web Vitalsを重視**
   - LCP、FID、CLS
   - SEOとUXに直結

5. **実際のユーザー環境をシミュレート**
   - モバイル、遅いネットワーク
   - MCPで簡単に再現可能

## 🚀 次のステップ

1. **継続的な監視**
   ```javascript
   // 定期的にパフォーマンスチェック
   setInterval(() => {
     get_performance_metrics();
   }, 3600000); // 1時間ごと
   ```

2. **リアルユーザーモニタリング（RUM）**
   - Google Analytics 4
   - New Relic Browser

3. **A/Bテストで効果測定**
   - 最適化前後のコンバージョン率比較

---

## 🔗 関連リソース

- [Core Web Vitals](https://web.dev/vitals/)
- [Chrome DevTools MCP](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [ユースケース集](../docs/use-cases.md)

---

🐱 Created by hantani - AI時代の創作技術研究者

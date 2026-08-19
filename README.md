# 酒店後勤系統 (boh)

酒店後勤物料與設備管理系統。GitHub Pages 部署，Supabase 後端。
- **repo**：`github.com/Build-0/boh` → 網址 `build-0.github.io/boh/`
- **與 hqms（房務品質）分開**：獨立的 GitHub repo 與獨立的 Supabase 專案，互不影響。

## 模組

| 模組 | 內容 | 狀態 |
|------|------|------|
| 清潔劑目錄 | 名稱、庫存、停用/啟用、新增/編輯/刪除 | ✅ 完成 |
| 吸塵機 | 每台獨立（型號、樓層代號、狀態）+ 保養記錄歷史 | ✅ 完成 |
| 清潔工具 | 庫存數量、停用/啟用、新增/編輯/刪除 | ✅ 完成 |
| 設備 | 每台獨立（類型/型號/樓層/狀態）+ 保養記錄，按類型分組 | ✅ 完成 |
| 配件更換 | 型號、更換記錄 | 規劃中 |

> SQL 執行順序（都在 Supabase SQL Editor 各跑一次）：
> 1. `supabase/schema.sql`（含設定密碼）→ 2. `supabase/seed.sql`（清潔劑資料）
> 3. `supabase/schema_modules.sql`（吸塵機＋清潔工具）
> 4. `supabase/schema_equipment.sql`（設備）
> 5. `supabase/schema_batches.sql`（清潔劑批次效期＋用量統計；會把現有庫存轉成初始批次）

### 清潔劑批次效期 + 用量報表
- 每個清潔劑 = 多個批次（數量＋到期日）。總庫存＝批次剩餘加總，卡片列出效期明細（快到期橘、過期紅）。
- **進貨**：新增批次。**盤點**：填實際剩餘，系統推算用量（原總數−實數）並自最早到期批次扣（FEFO）。
- **📊 用量報表** 分頁：分產品＋總計，可切月／季／年。資料來自 `stock_movements`（kind='out'）。

---

## 清潔劑目錄模組 — Supabase 版

把原本用 Google Sheet + Apps Script 的庫存管理，改成 Supabase。

- **普通用戶**：只能瀏覽產品與庫存（透過 anon key + RLS 只讀）。
- **管理員**：輸入共用密碼後，可修改庫存、停用/啟用產品，以及新增/編輯/刪除產品。
- **密碼驗證**：保留「單一共用密碼」的體驗，但改成在伺服器端（Postgres 函式）比對 bcrypt 雜湊，比舊版把密碼放在網址安全很多。

## 檔案

| 檔案 | 用途 |
|------|------|
| `index.html` | 新版前端（動態從 Supabase 讀取並渲染）。填入你的專案網址與金鑰即可用。GitHub Pages 直接發佈這個。 |
| `supabase/schema.sql` | 資料表、RLS 政策、密碼驗證與寫入用的 RPC 函式。**先跑這個。** |
| `supabase/seed.sql` | 34 筆產品 + 4 個分類的初始資料（含真實庫存與圖片）。**第二個跑。** |
| `tools/extract_products.mjs` | 從舊 HTML 抽資料的腳本（已跑過，一般不用再跑）。 |
| `tools/products_seed.json` | 抽出的原始資料（備份/檢視用）。 |

---

## 設定步驟

### 1. 建立 Supabase 專案
到 <https://supabase.com> 建一個新專案（免費方案即可），記下：
- **Project URL**：`https://xxxx.supabase.co`
- **anon public key**：Project Settings → API Keys → `anon` `public`

> anon key 是設計成可以公開的（會嵌在 HTML 裡）。真正保護資料的是 RLS 政策 + 密碼函式，不是把金鑰藏起來。

### 2. 建立資料表與函式
Supabase Dashboard → **SQL Editor** → New query，貼上整個 `schema.sql`，按 **Run**。

⚠️ **設定密碼**：`schema.sql` 最後一段有一行：
```sql
insert into app_config (key, value)
values ('admin_password_hash', crypt('CHANGE_ME_NOW', gen_salt('bf')))
on conflict (key) do update set value = excluded.value;
```
把 `CHANGE_ME_NOW` 換成你要的管理員密碼再跑。**日後要改密碼，重跑這一行即可。**

### 3. 匯入產品資料
SQL Editor → New query，貼上整個 `seed.sql`，按 **Run**。
（`seed.sql` 有 44 萬字，主要是 34 張 base64 圖片，正常。）

### 4. 設定前端
打開 `index.html`，最上面的 `<script>` 裡：
```js
var SUPABASE_URL = "https://YOUR-PROJECT-ref.supabase.co";
var SUPABASE_ANON_KEY = "YOUR-ANON-PUBLIC-KEY";
```
換成步驟 1 記下的兩個值，存檔。

### 5. 上線
`index.html` 是純靜態檔，直接丟到任何靜態主機都可以：
- Netlify / Vercel / Cloudflare Pages（拖曳上傳即可）
- GitHub Pages
- 或 Supabase Storage 的公開 bucket

打開網頁，右下角「🔒 管理員」→ 輸入密碼即可管理。

---

## 安全說明

- **只讀保護**：`products` / `categories` 只有 `SELECT` 的 RLS 政策，沒有寫入政策，所以用 anon key 無法直接改資料。
- **寫入**：只能透過 `update_stock` / `update_status` / `upsert_product` / `delete_product` 這幾個 `SECURITY DEFINER` 函式，函式內部會先用 `_require_admin()` 比對密碼雜湊，密碼錯就直接丟例外。
- **密碼雜湊**：存在 `app_config` 表，該表 RLS 開啟但沒有任何政策 → anon key 完全讀不到雜湊值。
- **限制（與舊版相同）**：這是「共用密碼」模型，任何知道密碼的人都能管理。若日後想要多位管理員、可個別撤銷、稽核紀錄，可改用 Supabase Auth（email 登入），屆時把寫入政策改成「僅 authenticated 可寫」即可。

## 之後想擴充

- **圖片改用 Supabase Storage**：目前圖片以 data URI 存在資料表的 `image` 欄位（沿用舊版做法，簡單但每次載入較重）。日後可改成上傳到 Storage bucket，`image` 改存公開 URL，前端讀取更快。
- **新增分類**：目前分類固定 4 個。要新增分類，可在 `categories` 表加一列（或再寫一個 RPC）。

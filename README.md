# ローカルSQL練習環境

## 前提条件

- Docker Desktop がインストールされていること

## ディレクトリ構成

```
psql/
├── docker-compose.yml
└── init/
    └── 01_schema.sql   # 初回起動時に自動実行されるスキーマ＆サンプルデータ
```

## 起動・停止

```bash
# コンテナ起動
docker compose up -d

# 起動確認
docker compose ps

# 停止
docker compose down

# データも含めて完全リセット（やり直したいとき）
docker compose down -v
docker compose up -d
```

> `init/` フォルダの `.sql` ファイルはコンテナ**初回起動時**に自動実行されます。
> `docker compose down -v` でボリュームごと削除すると、次回 `up` 時にinitスクリプトが再実行されてリセットできます。

## DB接続

### psql（CLIツール）

```bash
docker compose exec db psql -U student -d practice
```

### GUIツール（TablePlus / DBeaver など）

| 項目 | 値 |
|---|---|
| Host | localhost |
| Port | 5432 |
| User | student |
| Password | student |
| Database | practice |

## psql 基本コマンド

| コマンド | 説明 |
|---|---|
| `\dt` | テーブル一覧 |
| `\d テーブル名` | テーブル構造確認 |
| `\q` | 終了 |

## テーブル構成

### users（ユーザー）

| カラム | 型 | 説明 |
|---|---|---|
| id | SERIAL | 主キー |
| name | TEXT | 名前 |
| email | TEXT | メールアドレス |

### products（商品）

| カラム | 型 | 説明 |
|---|---|---|
| id | SERIAL | 主キー |
| name | TEXT | 商品名 |
| price | INTEGER | 価格（円） |

### orders（注文）

| カラム | 型 | 説明 |
|---|---|---|
| id | SERIAL | 主キー |
| user_id | INTEGER | ユーザーID（外部キー） |
| product_id | INTEGER | 商品ID（外部キー） |
| quantity | INTEGER | 数量 |
| ordered_at | TIMESTAMP | 注文日時 |

## 練習クエリ例

### 各ユーザーの合計注文金額（JOIN練習）

```sql
SELECT
  u.name,
  SUM(p.price * o.quantity) AS total_amount
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN products p ON p.id = o.product_id
GROUP BY u.id, u.name
ORDER BY total_amount DESC;
```

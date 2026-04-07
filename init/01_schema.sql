-- ユーザーテーブル
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL
);

-- 商品テーブル
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price INTEGER NOT NULL
);

-- 注文テーブル
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  product_id INTEGER REFERENCES products(id),
  quantity INTEGER NOT NULL,
  ordered_at TIMESTAMP DEFAULT NOW()
);

-- サンプルデータ
INSERT INTO users (name, email) VALUES
  ('田中 太郎', 'tanaka@example.com'),
  ('鈴木 花子', 'suzuki@example.com'),
  ('佐藤 次郎', 'sato@example.com');

INSERT INTO products (name, price) VALUES
  ('ノートPC', 120000),
  ('マウス', 3000),
  ('キーボード', 8000);

INSERT INTO orders (user_id, product_id, quantity) VALUES
  (1, 1, 1),
  (1, 2, 2),
  (2, 3, 1),
  (3, 1, 1),
  (3, 2, 3);

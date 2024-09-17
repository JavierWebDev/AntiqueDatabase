# Antique Database

## Diagrama Conceptual

![](/img/antiques.png)

---

## Diagrama DER

![](/img/antique_market.png)

---

## Consultas SQL

**1. Lista de antigüedades disponibles para la venta:**

```sql
SELECT 
    a.name AS piece_name,
    a.category AS category,
    a.price AS price,
    ac.condition_name AS condition_name
FROM 
    antiques a
JOIN 
    antique_conditions ac ON a.condition_id = ac.id
WHERE 
    a.status_id = (SELECT id FROM antique_status WHERE status_name = 'Available');
+---------------+-----------+---------+----------------+
| piece_name    | category  | price   | condition_name |
+---------------+-----------+---------+----------------+
| Antique Chair | Furniture | 1500.00 | Antique        |
| Vintage Lamp  | Lighting  |  800.00 | Used           |
+---------------+-----------+---------+----------------+
```

**2. Buscar antigüedades por categoría y rango de precio:**

```sql
SELECT 
    name, category, price
FROM 
    antiques
WHERE 
    category = 'Furniture' 
    AND price BETWEEN 500 AND 2000;

+---------------+-----------+---------+
| name          | category  | price   |
+---------------+-----------+---------+
| Antique Chair | Furniture | 1500.00 |
+---------------+-----------+---------+
```

**3. Mostrar historial de ventas de un cliente específico:**

```sql
SELECT 
    a.name AS piece_name,
    t.transaction_date,
    t.sale_price,
    u.username AS buyer
FROM 
    transactions t
JOIN 
    antiques a ON t.antique_id = a.id
JOIN 
    users u ON t.buyer_id = u.id
WHERE 
    u.username = 'johndoe';

+---------------+---------------------+------------+---------+
| piece_name    | transaction_date    | sale_price | buyer   |
+---------------+---------------------+------------+---------+
| Antique Chair | 2024-08-15 00:00:00 |    1500.00 | johndoe |
| Vintage Lamp  | 2024-09-01 00:00:00 |     800.00 | johndoe |
+---------------+---------------------+------------+---------+

```

**4. Obtener el total de ventas realizadas en un periodo específico:**

```sql
SELECT 
    SUM(sale_price) AS total_sales
FROM 
    transactions
WHERE 
    transaction_date BETWEEN '2024-08-01' AND '2024-08-31';
+-------------+
| total_sales |
+-------------+
|     1500.00 |
+-------------+
```

**5. Encontrar los clientes más activos (con más compras realizadas):**

```sql
SELECT 
    u.username,
    COUNT(t.id) AS number_of_purchases
FROM 
    transactions t
JOIN 
    users u ON t.buyer_id = u.id
GROUP BY 
    u.username
ORDER BY 
    number_of_purchases DESC;
+----------+---------------------+
| username | number_of_purchases |
+----------+---------------------+
| johndoe  |                   2 |
+----------+---------------------+

```


**7. Listar las antigüedades vendidas en un rango de fechas específico:**

```sql
SELECT 
    a.name AS piece_name,
    t.transaction_date,
    u_seller.username AS seller,
    u_buyer.username AS buyer
FROM 
    transactions t
JOIN 
    antiques a ON t.antique_id = a.id
JOIN 
    users u_seller ON t.seller_id = u_seller.id
JOIN 
    users u_buyer ON t.buyer_id = u_buyer.id
WHERE 
    t.transaction_date BETWEEN '2024-08-01' AND '2024-08-31';

+---------------+---------------------+---------+---------+
| piece_name    | transaction_date    | seller  | buyer   |
+---------------+---------------------+---------+---------+
| Antique Chair | 2024-08-15 00:00:00 | janedoe | johndoe |
+---------------+---------------------+---------+---------+

```

**8. Obtener un informe de inventario actual:**

```sql
SELECT 
    a.category,
    COUNT(i.id) AS quantity
FROM 
    inventory i
JOIN 
    antiques a ON i.antique_id = a.id
WHERE 
    i.status_id = (SELECT id FROM inventory_status WHERE status_name = 'In Stock')
GROUP BY 
    a.category;
+-----------+----------+
| category  | quantity |
+-----------+----------+
| Furniture |        1 |
| Lighting  |        1 |
+-----------+----------+

```

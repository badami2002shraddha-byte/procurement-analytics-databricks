
-- Procurement Analytics Dashboard
-- Bronze, Silver, and Gold data warehouse

-- 1. Validate Silver purchase order records
SELECT *
FROM procurement.silver_purchase_orders;

-- 2. Total procurement spend, purchase orders, and vendors
SELECT
    SUM(f.total_amount) AS total_procurement_spend,
    COUNT(DISTINCT f.po_number) AS total_purchase_orders,
    COUNT(DISTINCT f.vendor_key) AS total_vendors
FROM procurement.silver_purchase_orders f
JOIN procurement.dim_date d
    ON f.date_key = d.date_key
WHERE d.full_date BETWEEN DATE '2026-09-01'
                      AND DATE '2026-09-30';

-- 3. Procurement spend by vendor
SELECT
    v.vendor_name,
    SUM(f.total_amount) AS total_spend
FROM procurement.silver_purchase_orders f
JOIN procurement.dim_vendor v
    ON f.vendor_key = v.vendor_key
GROUP BY v.vendor_name
ORDER BY total_spend DESC;

-- 4. Procurement spend by product category
SELECT
    p.category,
    SUM(f.total_amount) AS total_spend
FROM procurement.silver_purchase_orders f
JOIN procurement.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_spend DESC;

-- 5. Procurement spend by department
SELECT
    dep.department_name,
    SUM(f.total_amount) AS total_spend
FROM procurement.silver_purchase_orders f
JOIN procurement.dim_department dep
    ON f.department_key = dep.department_key
GROUP BY dep.department_name
ORDER BY total_spend DESC;

-- 6. Daily procurement spend
SELECT
    d.full_date,
    SUM(f.total_amount) AS daily_spend
FROM procurement.silver_purchase_orders f
JOIN procurement.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;

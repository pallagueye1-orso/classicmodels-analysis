-- PARTIE 2 : (4) Analyse temporelle avec SOUS-REQUÊTES CORRÉLÉES (nouveaux clients, rétention)

-- Sélectionner la base de données
USE classicmodels;

-- on trouve d abord la première année d achat de chaque client.

SELECT 
    c.customerNumber,
    c.customerName,
    MIN(YEAR(o.orderDate)) AS first_year
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName;

-- on compte aprés combien de clients ont fait leur premier achat dans une année donnée.
SELECT 
    first_year AS year,
    COUNT(*) AS new_customers
FROM (
    SELECT 
        c.customerNumber,
        MIN(YEAR(o.orderDate)) AS first_year
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    GROUP BY c.customerNumber
) AS t
GROUP BY first_year
ORDER BY first_year;


-- Clients récurrents : Un client est “récurrent” s’il a commandé au moins une fois l’année précédente.
SELECT 
    YEAR(o.orderDate) AS year,
    COUNT(DISTINCT o.customerNumber) AS returning_customers
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM orders o2
    WHERE o2.customerNumber = o.customerNumber
      AND YEAR(o2.orderDate) = YEAR(o.orderDate) - 1
)
GROUP BY YEAR(o.orderDate)
ORDER BY year;

-- comparaison année N vs année N‑1 (croissance)
SELECT 
    this.year,
    this.revenue AS revenue_this_year,
    prev.revenue AS revenue_last_year,
    (this.revenue - prev.revenue) AS growth,
    ROUND((this.revenue - prev.revenue) / prev.revenue * 100, 2) AS growth_pct
FROM (
    SELECT YEAR(orderDate) AS year,
           SUM(quantityOrdered * priceEach) AS revenue
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY YEAR(orderDate)
) this
LEFT JOIN (
    SELECT YEAR(orderDate) AS year,
           SUM(quantityOrdered * priceEach) AS revenue
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY YEAR(orderDate)
) prev ON prev.year = this.year - 1
ORDER BY this.year;
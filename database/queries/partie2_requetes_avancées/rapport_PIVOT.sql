-- PARTIE 2 : (5) Rapport PIVOT ventes par gamme et trimestre.

-- Sélectionner la base de données
USE classicmodels;

#  rapport PIVOT manuel des ventes par gamme de produits et par trimestre.
SELECT 
    p.productLine,

    -- Trimestre 1
    SUM(
        CASE 
            WHEN QUARTER(o.orderDate) = 1 
            THEN od.quantityOrdered * od.priceEach 
            ELSE 0 
        END
    ) AS Q1,

    -- Trimestre 2
    SUM(
        CASE 
            WHEN QUARTER(o.orderDate) = 2 
            THEN od.quantityOrdered * od.priceEach 
            ELSE 0 
        END
    ) AS Q2,

    -- Trimestre 3
    SUM(
        CASE 
            WHEN QUARTER(o.orderDate) = 3 
            THEN od.quantityOrdered * od.priceEach 
            ELSE 0 
        END
    ) AS Q3,

    -- Trimestre 4
    SUM(
        CASE 
            WHEN QUARTER(o.orderDate) = 4 
            THEN od.quantityOrdered * od.priceEach 
            ELSE 0 
        END
    ) AS Q4

FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber

GROUP BY p.productLine
ORDER BY p.productLine;
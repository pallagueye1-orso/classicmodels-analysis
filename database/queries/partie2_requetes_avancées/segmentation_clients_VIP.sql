-- PARTIE 2 : (3) Segmentation clients VIP avec JOINTURES MULTIPLES (5+ tables).

-- Sélectionner la base de données
USE classicmodels;

SELECT 
    c.customerNumber,
    c.customerName,
    c.country,

    CONCAT(e.firstName, ' ', e.lastName) AS salesRep,
    off.city AS officeCity,
    off.country AS officeCountry,

    -- Chiffre d'affaires total
    SUM(od.quantityOrdered * od.priceEach) AS total_revenue,

    -- Nombre de commandes
    COUNT(DISTINCT o.orderNumber) AS total_orders,

    -- Valeur moyenne par commande
    SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber) AS avg_order_value,

    -- Total des paiements
    SUM(p.amount) AS total_payments

FROM customers c
JOIN employees e 
    ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices off 
    ON e.officeCode = off.officeCode
JOIN orders o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
LEFT JOIN payments p 
    ON c.customerNumber = p.customerNumber

GROUP BY 
    c.customerNumber, c.customerName, c.country,
    salesRep, officeCity, officeCountry

HAVING total_revenue > 100000
ORDER BY total_revenue DESC;

-- Sélectionner la base de données
USE classicmodels;


-- On utilise UNION pour avoir tous nos résultats dans un seul tableau propre
SELECT 'Clients' AS Categorie, COUNT(*) AS Total FROM customers
UNION
SELECT 'Employés', COUNT(*) FROM employees
UNION
SELECT 'Bureaux', COUNT(*) FROM offices
UNION
SELECT 'Commandes', COUNT(*) FROM orders
UNION
SELECT 'Produits', COUNT(*) FROM products
UNION
SELECT 'Gammes de produits', COUNT(*) FROM productlines;


-- Répartition géographique des clients (par pays)
SELECT country, COUNT(*) AS nb_clients
FROM customers
GROUP BY country
ORDER BY nb_clients DESC;


-- Nombre de commandes par statut  (shipped, cancelled, etc.) ?
SELECT status, COUNT(*) AS nb_commandes
FROM orders
GROUP BY status
ORDER BY nb_commandes DESC;


-- Montant total des ventes et le panier moyen (les ventes sont dans orderdetails (quantityOrdered et priceEach)
SELECT 
    SUM(quantityOrdered * priceEach) AS total_ventes,
    AVG(quantityOrdered * priceEach) AS panier_moyen
FROM orderdetails;


-- Les 10 des produits les plus vendus
SELECT 
    p.productName,
    SUM(od.quantityOrdered) AS quantite_totale
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productName
ORDER BY quantite_totale DESC
LIMIT 10;


-- Les 5 des meilleurs clients par chiffre d'affaires
SELECT 
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS chiffre_affaires
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY chiffre_affaires DESC
LIMIT 5;


-- L'Employé qui a réalisé le plus de ventes
SELECT 
    e.firstName,
    e.lastName,
    SUM(od.quantityOrdered * od.priceEach) AS total_ventes
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY e.employeeNumber
ORDER BY total_ventes DESC
LIMIT 1;


-- Gamme de produits la plus rentable
SELECT 
    pl.productLine,
    SUM(od.quantityOrdered * od.priceEach) AS total_ventes
FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine
ORDER BY total_ventes DESC
LIMIT 1;


-- La gamme de produits la plus rentable
SELECT 
    pl.productLine,
    SUM(od.quantityOrdered * od.priceEach) AS total_ventes
FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine
ORDER BY total_ventes DESC
LIMIT 1;
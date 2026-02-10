-- PARTIE 2 : (1) Analyse des ventes avec WINDOW FUNCTIONS

-- Sélectionner la base de données
USE classicmodels;

SELECT 
    p.productName,
    SUM(od.quantityOrdered * od.priceEach) AS revenue,

    -- Classement des produits par chiffre d'affaires
    ## RANK() classe les produits du plus rentable au moins rentable.
    RANK() OVER (ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS revenue_rank,

    -- Moyenne mobile sur 3 produits
       ## AVG() OVER (…) calcule une moyenne mobile sur les 3 produits les plus proches.
    AVG(SUM(od.quantityOrdered * od.priceEach)) 
        OVER (ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC
              ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg,

    -- Pourcentage du total des ventes
    ## SUM() OVER () calcule le total global des ventes pour obtenir un pourcentage.
    SUM(od.quantityOrdered * od.priceEach) * 100.0 /
        SUM(SUM(od.quantityOrdered * od.priceEach)) OVER () AS pct_total

FROM products p
JOIN orderdetails od USING (productCode)
GROUP BY p.productName
ORDER BY revenue DESC;
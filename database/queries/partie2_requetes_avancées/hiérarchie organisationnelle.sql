-- Sélectionner la base de données
USE classicmodels;

WITH RECURSIVE hierarchy AS (
    
    -- 1) Point de départ : les managers qui n'ont personne au-dessus d'eux
    SELECT 
        employeeNumber,
        lastName,
        firstName,
        reportsTo,
        jobTitle,
        1 AS level
    FROM employees
    WHERE reportsTo IS NULL

    UNION ALL

    -- 2) Récursion : on ajoute les employés qui reportent aux précédents
    SELECT 
        e.employeeNumber,
        e.lastName,
        e.firstName,
        e.reportsTo,
        e.jobTitle,
        h.level + 1 AS level
    FROM employees e
    JOIN hierarchy h ON e.reportsTo = h.employeeNumber
)

SELECT *
FROM hierarchy
ORDER BY level, lastName;
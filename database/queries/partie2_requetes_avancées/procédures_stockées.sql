-- 2 procédures stockées (calcul commission employé, gestion stocks). 

-- calcul commission employé.
DELIMITER $$

CREATE PROCEDURE calc_commission (
    IN empNumber INT,
    IN commissionRate DECIMAL(5,2),
    OUT commissionTotal DECIMAL(15,2)
)
BEGIN
    SELECT 
        SUM(od.quantityOrdered * od.priceEach) * commissionRate
    INTO commissionTotal
    FROM employees e
    JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE e.employeeNumber = empNumber;
END $$

DELIMITER ;

-- on exécute 
SET @result = 0;

CALL calc_commission(1504, 0.05, @result);

SELECT @result AS commission;


-- gestion stocks.
DELIMITER $$

CREATE PROCEDURE manage_stock (
    IN p_productCode VARCHAR(15),
    IN p_quantityRequested INT,
    OUT p_quantityRemaining INT
)
BEGIN
    DECLARE currentStock INT;

    -- 1) Récupérer le stock actuel
    SELECT quantityInStock 
    INTO currentStock
    FROM products
    WHERE productCode = p_productCode;

    -- 2) Vérifier si le stock est suffisant
    IF currentStock < p_quantityRequested THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuffisant pour ce produit';
    END IF;

    -- 3) Mettre à jour le stock
    UPDATE products
    SET quantityInStock = quantityInStock - p_quantityRequested
    WHERE productCode = p_productCode;

    -- 4) Retourner la quantité restante
    SELECT quantityInStock 
    INTO p_quantityRemaining
    FROM products
    WHERE productCode = p_productCode;

END $$

DELIMITER ;

-- on exécute
SET @remaining = 0;

CALL manage_stock('S10_1678', 5, @remaining);

SELECT @remaining AS stock_restant;
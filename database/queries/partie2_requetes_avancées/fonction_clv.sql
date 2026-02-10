-- PARTIE 2 : Fonction (customer lifetime value)
DELIMITER $$

CREATE FUNCTION customer_clv (custNumber INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE totalValue DECIMAL(15,2);

    SELECT 
        SUM(od.quantityOrdered * od.priceEach)
    INTO totalValue
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE c.customerNumber = custNumber;

    RETURN IFNULL(totalValue, 0);
END $$

DELIMITER ;

SELECT customer_clv(103) AS lifetime_value;
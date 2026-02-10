-- PARTIE 2 : Triggers

-- Trigger 1 Audit des commandes (orders)
-- Avant de créer un trigger, il faut une table où stocker les logs.
CREATE TABLE orders_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    orderNumber INT,
    customerNumber INT,
    orderDate DATETIME,
    action_type VARCHAR(20),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- on crée maintenant le trigger. 
DELIMITER $$

CREATE TRIGGER trg_orders_audit
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO orders_audit (orderNumber, customerNumber, orderDate, action_type)
    VALUES (NEW.orderNumber, NEW.customerNumber, NEW.orderDate, 'INSERT');
END $$

DELIMITER ;

-- on test le trigger. 
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, customerNumber)
VALUES (99999, '2024-01-10', '2024-01-15', NULL, 'In Process', 103);

SELECT * FROM orders_audit;


-- Triggers 2 Validation du stock

-- on crée le trigger.
DELIMITER $$

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON orderdetails
FOR EACH ROW
BEGIN
    DECLARE currentStock INT;

    -- 1) Récupérer le stock actuel du produit
    SELECT quantityInStock
    INTO currentStock
    FROM products
    WHERE productCode = NEW.productCode;

    -- 2) Vérifier si le stock est suffisant
    IF currentStock < NEW.quantityOrdered THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuffisant pour ce produit';
    END IF;
END $$

DELIMITER ;

-- on test le trigger avec stock suffisant. 
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (10100, 'S10_1678', 2, 95.00, 1);

-- on test le trigger avec stock insuffisant. 
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (10100, 'S10_1678', 99999, 95.00, 1);
-- MySQL me renvoie ERROR 1644 (45000): Stock insuffisant pour ce produit, donc c'est bien.

-- Triggers 3 mise à jour du statut client. 

-- on ajoute une colonne customerStatus dans customers.
ALTER TABLE customers
ADD COLUMN customerStatus VARCHAR(20) DEFAULT 'Standard';

-- on crée le trigger.
DELIMITER $$

CREATE TRIGGER trg_update_customer_status
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
    DECLARE totalRevenue DECIMAL(15,2);

    -- 1) Calculer le chiffre d'affaires total du client
    SELECT 
        SUM(od.quantityOrdered * od.priceEach)
    INTO totalRevenue
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE o.customerNumber = (
        SELECT customerNumber 
        FROM orders 
        WHERE orderNumber = NEW.orderNumber
    );

    -- 2) Mettre à jour le statut du client
    UPDATE customers
    SET customerStatus = 
        CASE 
            WHEN totalRevenue >= 100000 THEN 'VIP'
            ELSE 'Standard'
        END
    WHERE customerNumber = (
        SELECT customerNumber 
        FROM orders 
        WHERE orderNumber = NEW.orderNumber
    );
END $$

DELIMITER ;

-- on test le trigger en cas d une commande normale.

INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (10100, 'S10_1678', 5, 95.00, 3);

SELECT customerNumber, customerStatus FROM customers;

-- on test le trigger en cas d une commande massive (pour passer VIP)
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (10100, 'S10_1678', 2000, 95.00, 4);

SELECT customerNumber, customerStatus FROM customers;
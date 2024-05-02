DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(quantity) as "Max Quantity in Order" from orderitems;
END // 
DELIMITER ;

Call GetMaxQuantity();
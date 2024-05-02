REPLACE INTO orders (idOrders, CustomerID, DeliveryID, OrderPlaced) VALUES (5,2,2,NOW());
DELIMITER //
CREATE PROCEDURE CancelOrder(IN orderNo INT)
BEGIN
DELETE FROM Orders where idOrders = orderNo;
Select concat("Order ",orderNo," is cancelled") as confirmation;
END // 
DELIMITER ;
Call CancelOrder(5);
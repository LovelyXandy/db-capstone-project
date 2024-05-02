PREPARE GetOrderDetail FROM 'SELECT idOrders as OrderID, SUM(quantity) as TotalQuantity, SUM(quantity*price) as TotalCost from orderitems left join orders on orderitems.orderId = orders.idOrders left join menuItems on orderitems.MenuItemID = menuItems.idMenuItems group by idOrders having idOrders = ?';
Set @id = 1;
EXECUTE GetOrderDetail using @id;
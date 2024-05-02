Select idCustomer, CustomerName, OrderID, quantity, quantity*price as TotalCost, Course.course as Course, menuItems.Name from orderitems left join orders on orderitems.orderId = orders.idOrders left join menuItems on orderitems.MenuItemID = menuItems.idMenuItems left join course on course.idCourse = menuItems.courseID left join customer on customer.idcustomer = orders.customerID;
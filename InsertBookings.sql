truncate bookings;
START TRANSACTION;
INSERT INTO bookings (idbookings, bookings.When, TableNo, CustomerID) values
(1,"2022-10-10",5,1),
(2,"2022-11-12",3,3),
(3,"2022-10-11",2,2),
(4,"2022-10-13",2,1); 
COMMIT;
select idbookings as BookingID, date_format(bookings.when, '%Y-%m-%d') as bookingDate, TableNo as TableNumber, CustomerID from bookings;
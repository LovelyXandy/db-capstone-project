Drop procedure IF EXISTS AddBooking;
Delimiter //
CREATE PROCEDURE AddBooking(In bookid INT, in custid INT, in tableCheck int, IN BookingCheck Date)
BEGIN
Declare noBookings INT;
START TRANSACTION;
INSERT INTO bookings (idbookings, bookings.When, TableNo, CustomerID) values (bookid, BookingCheck,tableCheck,custid);
Select count(*) into noBookings
from Bookings
WHERE DATE_FORMAT(BookingCheck, '%Y-%m-%d') = DATE_FORMAT(Bookings.When, '%Y-%m-%d') and Bookings.TableNo = tableCheck;
If noBookings > 1 then
ROLLBACK;
select CONCAT("Table ", tableCheck," is already booked - booking cancelled") as 'Error';
ELSE 
COMMIT;
select CONCAT("New Booking added") as 'Confirmation';
END IF;
END //
DELIMITER ;
Call AddBooking(9,3,4,"2022-12-30");
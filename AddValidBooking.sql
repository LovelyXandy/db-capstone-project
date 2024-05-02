Drop procedure IF EXISTS AddValidBooking;
Delimiter //
CREATE PROCEDURE AddValidBooking(IN BookingCheck Date, in tableCheck int)
BEGIN
Declare noBookings INT;
START TRANSACTION;
INSERT INTO bookings (bookings.When, TableNo, CustomerID) values (BookingCheck,tableCheck,1);
Select count(*) into noBookings
from Bookings
WHERE DATE_FORMAT(BookingCheck, '%Y-%m-%d') = DATE_FORMAT(Bookings.When, '%Y-%m-%d') and Bookings.TableNo = tableCheck;
If noBookings > 1 then
ROLLBACK;
select CONCAT("Table ", tableCheck," is already booked - booking cancelled") as 'Booking status';
ELSE 
COMMIT;
select CONCAT("Table ", tableCheck," has been booked successfully") as 'Booking status';
END IF;
END //
DELIMITER ;
Call AddValidBooking("2022-12-17",6);
Drop procedure IF EXISTS UpdateBooking;
Delimiter //
CREATE PROCEDURE UpdateBooking(In bookid INT, IN BookingCheck Date)
BEGIN
START TRANSACTION;
UPDATE bookings set bookings.When = BookingCheck where bookings.idbookings = bookid;
COMMIT;
select CONCAT("Booking ", bookid, " updated") as 'Confirmation';
END //
DELIMITER ;
Call UpdateBooking(9,"2022-12-17");
Drop procedure IF EXISTS CancelBooking;
Delimiter //
CREATE PROCEDURE CancelBooking(In bookid INT)
BEGIN
START TRANSACTION;
DELETE FROM bookings where bookings.idbookings = bookid;
COMMIT;
select CONCAT("Booking ", bookid, " updated") as 'Confirmation';
END //
DELIMITER ;
Call CancelBooking(9);
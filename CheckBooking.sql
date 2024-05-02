Drop procedure IF EXISTS checkbooking;
Delimiter //
CREATE PROCEDURE CheckBooking(IN BookingCheck Date, in tableCheck int)
BEGIN
Declare noBookings INT;
Select count(*) into noBookings
from Bookings
WHERE DATE_FORMAT(BookingCheck, '%Y-%m-%d') = DATE_FORMAT(Bookings.When, '%Y-%m-%d') and Bookings.TableNo = tableCheck;
If noBookings > 0 then select CONCAT("Table ", tableCheck," is already booked") as 'Booking status';
ELSE select CONCAT("Table ", tableCheck," is available for booking") as 'Booking status';
END IF;
END //
DELIMITER ;

Call CheckBooking("2022-11-12",3);
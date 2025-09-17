SELECT * FROM Booking
INNER JOIN Users ON Booking.user_id = User.user_id;

SELECT * FROM Property
LEFT JOIN Review ON Property.property_id = Review.property_id;

SELECT * FROM User
FULL OUTER JOIN Booking ON User.user_id = Booking.user_id;

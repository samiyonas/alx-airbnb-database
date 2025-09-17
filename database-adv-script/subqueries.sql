SELECT * FROM Property
WHERE property_id IN (
    SELECT property_id FROM Review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

SELECT * FROM User u
WHERE (
    SELECT COUNT(*) FROM Booking b
    WHERE u.user_id = b.user_id
) > 3;

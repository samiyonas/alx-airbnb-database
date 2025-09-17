SELECT COUNT(*) AS total_bookings_by_user FROM Booking
GROUP BY user_id;

SELECT
    p.*,
    RANK() OVER(
        ORDER BY (
            SELECT COUNT(*) FROM Booking
            WHERE p.property_id = Booking.property_id
        ) DESC
    ) AS Rank
FROM Property p;

SELECT COUNT(*) AS total_bookings_by_user FROM Booking
GROUP BY user_id;

EXPLAIN ANALYZE
SELECT
    p.*,
    RANK() OVER(
        ORDER BY (
            SELECT COUNT(*) FROM Booking
            WHERE p.property_id = Booking.property_id
        ) DESC
    ) AS ra,
    ROW_NUMBER() OVER(
        ORDER BY (
            SELECT COUNT(*) FROM Booking
            WHERE p.property_id = Booking.property_id
        ) DESC
    ) AS row_num
FROM Property p;


-- JOIN VERSION (MORE EFFICIENT)

SELECT
   p.*,
   RANK() OVER (ORDER BY COALESCE(t.cnt, 0)  DESC) AS ra
FROM Property p
LEFT JOIN (
    SELECT property_id, COUNT(*) AS cnt FROM Booking
    GROUP BY property_id
) t ON p.property_id = t.property_id

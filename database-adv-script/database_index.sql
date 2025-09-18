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

CREATE INDEX property_id_index ON Property (property_id);
CREATE INDEX booking_property_id_index ON Booking (property_id);

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

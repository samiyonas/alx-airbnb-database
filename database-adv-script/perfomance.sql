EXPLAIN ANALYZE

SELECT
    b.booking_id,
    b.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name       AS property_name,
    p.location   AS property_location,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM Booking b,
     "User" u,
     Property p,
     Payment pay
WHERE b.user_id = u.user_id
  AND b.property_id = p.property_id
  AND pay.booking_id = b.booking_id;


CREATE INDEX IF NOT EXISTS idx_booking_booking_id ON Booking (booking_id); 
CREATE INDEX IF NOT EXISTS idx_peroperty_host_id ON Property (host_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment (booking_id);

EXPLAIN ANALYZE
SELECT b.*, u.*, p.*, pay.*
FROM "User" u
LEFT JOIN Booking b ON b.user_id = u.user_id
LEFT JOIN Property p ON p.host_id = u.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id

EXPLAIN ANALYZE
SELECT b.*, u.*, p.*, pay.*
FROM "User" u
LEFT JOIN Booking b ON b.user_id = u.user_id
LEFT JOIN Property p ON p.host_id = u.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;

CREATE INDEX IF NOT EXISTS idx_booking_booking_id ON Booking (booking_id); 
CREATE INDEX IF NOT EXISTS idx_peroperty_host_id ON Property (host_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment (booking_id);

EXPLAIN ANALYZE
SELECT b.*, u.*, p.*, pay.*
FROM "User" u
LEFT JOIN Booking b ON b.user_id = u.user_id
LEFT JOIN Property p ON p.host_id = u.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id

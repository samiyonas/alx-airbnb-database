CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(gen_random_uuid(),'Alice','Johnson','alice@example.com','hash1','123-456-7890','guest'),
(gen_random_uuid(),'Bob','Smith','bob@example.com','hash2','234-567-8901','host'),
(gen_random_uuid(),'Carol','Williams','carol@example.com','hash3','345-678-9012','admin'),
(gen_random_uuid(),'David','Brown','david@example.com','hash4','456-789-0123','guest');

-- Get Bob’s user_id first:
-- SELECT user_id FROM "User" WHERE email='bob@example.com';

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='bob@example.com'),
 'Cozy Apartment','A nice and cozy apartment downtown','New York',120.00),
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='bob@example.com'),
 'Beach House','Beautiful beachside property with ocean view','Miami',250.00);

-- Alice books Cozy Apartment
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(gen_random_uuid(),
 (SELECT property_id FROM Property WHERE name='Cozy Apartment'),
 (SELECT user_id FROM "User" WHERE email='alice@example.com'),
 '2025-09-20','2025-09-25',600.00,'confirmed');

-- David books Beach House
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(gen_random_uuid(),
 (SELECT property_id FROM Property WHERE name='Beach House'),
 (SELECT user_id FROM "User" WHERE email='david@example.com'),
 '2025-10-05','2025-10-10',1250.00,'pending');

INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
(gen_random_uuid(),
 (SELECT booking_id FROM Booking WHERE total_price=600.00),
 600.00,'credit_card');

INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(gen_random_uuid(),
 (SELECT property_id FROM Property WHERE name='Cozy Apartment'),
 (SELECT user_id FROM "User" WHERE email='alice@example.com'),
 5,'Amazing stay, highly recommended!'),

(gen_random_uuid(),
 (SELECT property_id FROM Property WHERE name='Beach House'),
 (SELECT user_id FROM "User" WHERE email='david@example.com'),
 4,'Beautiful location but still needs some improvements.');

INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(gen_random_uuid(),
 (SELECT user_id FROM "User" WHERE email='alice@example.com'),
 (SELECT user_id FROM "User" WHERE email='bob@example.com'),
 'Hi Bob, I have a question about the apartment.'),

(gen_random_uuid(),
 (SELECT user_id FROM "User" WHERE email='bob@example.com'),
 (SELECT user_id FROM "User" WHERE email='alice@example.com'),
 'Sure Alice, what would you like to know?');
CREATE TABLE source_bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    booking_date DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    booking_channel VARCHAR(10) NOT NULL -- 'DIRECT' or 'OTA' (Online Travel Agency)
);

INSERT INTO source_bookings (user_id, booking_date, booking_status, total_price, booking_channel) VALUES
(101, '2026-01-15', 'CONFIRMED', 3500.00, 'OTA'),
(102, '2026-01-18', 'CONFIRMED', 4200.00, 'DIRECT'),
(103, '2026-01-22', 'CONFIRMED', 3800.00, 'OTA'),
(104, '2026-01-25', 'CANCELLED', 5000.00, 'OTA'),
(101, '2026-02-10', 'CONFIRMED', 4000.00, 'DIRECT'), -- User 101 switched to direct!
(102, '2026-02-14', 'CONFIRMED', 4500.00, 'DIRECT'),
(201, '2026-02-05', 'CONFIRMED', 3100.00, 'OTA'),
(202, '2026-02-20', 'CONFIRMED', 3200.00, 'DIRECT'),
(101, '2026-03-05', 'CONFIRMED', 4200.00, 'DIRECT'),
(201, '2026-03-12', 'CONFIRMED', 3500.00, 'DIRECT'), -- User 201 switched to direct!
(301, '2026-03-01', 'CONFIRMED', 5100.00, 'DIRECT'),
(302, '2026-03-18', 'CONFIRMED', 4800.00, 'OTA');

SELECT 'Database successfully initialized with ' || COUNT(*) || ' bookings.' AS status 
FROM source_bookings;
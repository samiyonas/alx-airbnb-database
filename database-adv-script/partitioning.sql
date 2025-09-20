CREATE TABLE IF NOT EXISTS Booking (
    booking_id PRIMARY KEY UUID,
    property_id UUID,
    user_id UUID,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_property_id FOREIGN KEY references Property(property_id),
    CONSTRAINT fk_user_id FOREIGN KEY references User(user_id)
) PARTITION BY RANGE(start_date);

CREATE TABLE booking_before_2025 PARTITION OF Booking
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_after_2025 PARTITION OF Booking
FOR VALUES FROM ('2025-01-01') TO (MAXVALUE);

CREATE TYPE user_role AS ENUM('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method AS ENUM('credit_card', 'paypal', 'stripe');


CREATE TABLE IF NOT EXISTS User (
    user_id PRIMARY KEY UUID,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR NULL,
    role user_role NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFALULT NOW()
    );

CREATE TABLE IF NOT EXISTS Property (
    property_id PRIMARY KEY UUID,
    host_id UUID,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_user_id FOREIGN KEY (host_id) references User(user_id),
);

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
);

CREATE TABLE IF NOT EXISTS Payment (
    payment_id PRIMARY KEY UUID,
    booking_id UUID,
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    payment_method payment_method NOT NULL,

    CONSTRAINT fk_booking_id FOREIGN KEY references Booking(booking_id)
);

CREATE TABLE IF NOT EXISTS Review (
    review_id PRIMARY KEY UUID,
    property_id UUID,
    user_id UUID,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_property_id FOREIGN KEY references Property(property_id),
    CONSTRAINT fk_user_id FOREIGN KEY references User(user_id)
);

CREATE TABLE IF NOT EXISTS Message (
    message_id PRIMARY KEY UUID,
    sender_id UUID,
    recipient_id UUID,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_sender_id FOREIGN KEY references User(user_id),
    CONSTRAINT fk_recipient_id FOREIGN KEY references User(user_id)
);
-- =============================================
-- 1. DOMAINE : UTILISATEUR
-- =============================================
CREATE TABLE USERS (
    id UUID PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100)
);

-- =============================================
-- 2. DOMAINE : AGENCE
-- =============================================
CREATE TABLE AGENCIES (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    opening_hours VARCHAR(255)
);

-- =============================================
-- 3. DOMAINE : VEHICULE
-- =============================================
CREATE TABLE VEHICLE_CATEGORIES (
    id UUID PRIMARY KEY,
    acriss_code CHAR(4) NOT NULL UNIQUE
);

CREATE TABLE VEHICLES (
    id UUID PRIMARY KEY,
    license_plate VARCHAR(50) NOT NULL UNIQUE,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year INT,
    seats INT,
    agency_id UUID NOT NULL,
    category_id UUID NOT NULL,
    CONSTRAINT fk_vehicles_agency FOREIGN KEY (agency_id) REFERENCES AGENCIES(id),
    CONSTRAINT fk_vehicles_category FOREIGN KEY (category_id) REFERENCES VEHICLE_CATEGORIES(id)
);

-- =============================================
-- 4. DOMAINE : OFFRE
-- =============================================
CREATE TABLE RENTAL_OFFERS (
    id UUID PRIMARY KEY,
    departure_at TIMESTAMP NOT NULL,
    return_at TIMESTAMP NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    departure_agency_id UUID NOT NULL,
    return_agency_id UUID NOT NULL,
    category_id UUID NOT NULL,
    CONSTRAINT fk_offers_departure_agency FOREIGN KEY (departure_agency_id) REFERENCES AGENCIES(id),
    CONSTRAINT fk_offers_return_agency FOREIGN KEY (return_agency_id) REFERENCES AGENCIES(id),
    CONSTRAINT fk_offers_category FOREIGN KEY (category_id) REFERENCES VEHICLE_CATEGORIES(id)
);

-- =============================================
-- 5. DOMAINE : RESERVATION
-- =============================================
CREATE TABLE RESERVATIONS (
    id UUID PRIMARY KEY,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    user_id UUID NOT NULL,
    rental_offer_id UUID NOT NULL,
    vehicle_id UUID NOT NULL,
    CONSTRAINT fk_reservations_user FOREIGN KEY (user_id) REFERENCES USERS(id),
    CONSTRAINT fk_reservations_offer FOREIGN KEY (rental_offer_id) REFERENCES RENTAL_OFFERS(id),
    CONSTRAINT fk_reservations_vehicle FOREIGN KEY (vehicle_id) REFERENCES VEHICLES(id)
);

-- =============================================
-- 6. DOMAINE : PAIEMENT
-- =============================================
CREATE TABLE PAYMENTS (
    id UUID PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    refund_amount DECIMAL(10,2),
    reservation_id UUID NOT NULL UNIQUE,
    CONSTRAINT fk_payments_reservation FOREIGN KEY (reservation_id) REFERENCES RESERVATIONS(id)
);

-- =============================================
-- 7. DOMAINE : SUPPORT
-- =============================================
CREATE TABLE SUPPORT_THREADS (
    id UUID PRIMARY KEY,
    subject VARCHAR(255),
    channel VARCHAR(50),
    status VARCHAR(50),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    user_id UUID NOT NULL,
    CONSTRAINT fk_threads_user FOREIGN KEY (user_id) REFERENCES USERS(id)
);

CREATE TABLE SUPPORT_MESSAGES (
    id UUID PRIMARY KEY,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    support_thread_id UUID NOT NULL,
    CONSTRAINT fk_messages_thread FOREIGN KEY (support_thread_id) REFERENCES SUPPORT_THREADS(id)
);
-- users table create
CREATE TABLE Users (
    user_id INT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(50),
    phone_number VARCHAR(20),
    CONSTRAINT users_pk PRIMARY KEY (user_id),
    CONSTRAINT users_email_unique UNIQUE (email),
    CONSTRAINT users_role_check 
    CHECK (role IN ('Football Fan', 'Ticket Manager'))
);

-- matches table create
CREATE TABLE Matches (
    match_id INT,
    fixture VARCHAR(150),
    tournament_category VARCHAR(100),
    base_ticket_price DECIMAL(10,2),
    match_status VARCHAR(50),
    CONSTRAINT matches_pk PRIMARY KEY (match_id),
    CONSTRAINT ticket_price_check 
    CHECK (base_ticket_price >= 0),
    CONSTRAINT match_status_check
    CHECK (match_status IN 
    ('Available', 'Selling Fast', 'Sold Out'))

);

-- booking table create
CREATE TABLE Bookings (
    booking_id INT,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(20),
    payment_status VARCHAR(50),
    total_cost DECIMAL(10,2),
    CONSTRAINT bookings_pk 
    PRIMARY KEY (booking_id),
    CONSTRAINT bookings_user_fk
    FOREIGN KEY (user_id)
    REFERENCES Users(user_id),
    CONSTRAINT bookings_match_fk
    FOREIGN KEY (match_id)
    REFERENCES Matches(match_id),
    CONSTRAINT total_cost_check
    CHECK (total_cost >= 0),
    CONSTRAINT payment_status_check
    CHECK (payment_status IN 
    ('Confirmed','Pending','Cancelled'))
);

-- users insert like them assignment requrement
INSERT INTO Users 
(user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- matches insert like them assignment requrement
INSERT INTO Matches
(match_id, fixture, tournament_category, base_ticket_price, match_status)
VALUES
(101, 'Real Madrid vs Barcelona',
'Champions League',150.00,'Available'),
(102, 'Man City vs Liverpool',
'Premier League',120.00,'Selling Fast'),
(103, 'Bayern Munich vs PSG',
'Champions League',130.00,'Available'),
(104, 'AC Milan vs Inter Milan',
'Serie A',90.00,'Sold Out'),
(105, 'Juventus vs Roma',
'Serie A',80.00,'Available');

-- bookings insert like them assignment requrement
INSERT INTO Bookings
(booking_id,user_id,match_id,seat_number,payment_status,total_cost)
VALUES
(501,1,101,'A-12','Confirmed',150.00),
(502,1,102,'B-04','Confirmed',120.00),
(503,2,101,'A-13','Confirmed',150.00),
(504,2,101,NULL,NULL,150.00),
(505,3,102,'C-20','Pending',120.00);

-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.
select * from bookings
SELECT 
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
FROM Matches
WHERE tournament_category = 'Champions League'
AND match_status = 'Available';

-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
SELECT
    user_id,
    full_name,
    email
FROM Users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';

-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;

-- Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.
SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM Bookings b
INNER JOIN Users u
    ON b.user_id = u.user_id
INNER JOIN Matches m
    ON b.match_id = m.match_id;

-- Query 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have never bought a ticket are still listed.
SELECT
    u.user_id,
    u.full_name,
    b.booking_id
FROM Users u
LEFT JOIN Bookings b
    ON u.user_id = b.user_id
ORDER BY u.user_id, b.booking_id;

-- Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.
SELECT
    booking_id,
    match_id,
    total_cost
FROM Bookings
WHERE total_cost > (
    SELECT AVG(total_cost)
    FROM Bookings
);

-- Query 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;

create table hotelLogin(
username VARCHAR2(20),
password VARCHAR2(20));

create table hotel(
hotel_id INT,
hotel_name VARCHAR2(20),
hotel_address VARCHAR2(40),
PRIMARY KEY(hotel_id));

CREATE TABLE branch (
branch_id VARCHAR2(10) PRIMARY KEY,
branch_name VARCHAR2(20),
branch_address VARCHAR2(50),
hotel_id INT,
capacity INT,
FOREIGN KEY(hotel_id) REFERENCES hotel(hotel_id)
);

CREATE TABLE room (
room_id INT PRIMARY KEY,
room_type VARCHAR2(20),
cleaning_check VARCHAR2(20),
booking_check VARCHAR2(20),
room_price int,
branch_id VARCHAR2(10),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);

CREATE TABLE facility (
facility_id INT PRIMARY KEY,
facility_name VARCHAR2(20),
room_type VARCHAR2(20)
);

create table HotelEmployee(
HotelEmployee_id int PRIMARY KEY,
HotelEmployee_name VARCHAR2(20),
HotelEmployee_age int,
HotelEmployee_salary int,
branch_id VARCHAR2(10),
HotelEmployee_role VARCHAR2(20),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id));


create table HotelCustomer(
HotelCustomer_id int PRIMARY KEY,
HotelCustomer_name VARCHAR2(20),
room_id int,
branch_id VARCHAR2(10),
HotelCustomer_deposit int,
HotelCustomer_Address VARCHAR2(20),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id),
FOREIGN KEY(room_id) REFERENCES room(room_id) ON DELETE CASCADE
);

create table reservation(
room_id int,
branch_id VARCHAR2(10),
HotelCustomer_id int,
reservation_id int PRIMARY KEY,
check_in date,
check_out date,
FOREIGN KEY(branch_id) REFERENCES branch(branch_id));

create table service(
service_id int PRIMARY KEY,
service_name VARCHAR2(20),
service_price int);

create table customersService(
HotelCustomer_id int,
service_id int,
FOREIGN KEY(service_id) REFERENCES service (service_id) ON DELETE CASCADE,
FOREIGN KEY(HotelCustomer_id) REFERENCES HotelCustomer (HotelCustomer_id) ON DELETE CASCADE
);

create table discount(
discount_type VARCHAR2(20),
discount_value int);

create table HotelCustomersBill(
HotelCustomersBill_id int PRIMARY KEY,
HotelCustomersBill_totalAmount int,
HotelCustomersBill_status VARCHAR2(20),
billing_date date,
HotelCustomer_id int,
FOREIGN KEY(HotelCustomer_id) REFERENCES HotelCustomer (HotelCustomer_id) ON DELETE CASCADE
);

CREATE TABLE Customer_Feedback (
  feedback_id INT PRIMARY KEY,
  HotelCustomer_id INT,
  feedback_date DATE,
  roomFeedback INT,
  facilityFeedback INT,
  servicesFeedback INT,
  feedback_comment VARCHAR2(100),
  FOREIGN KEY(HotelCustomer_id) REFERENCES HotelCustomer(HotelCustomer_id) ON DELETE CASCADE,
  CONSTRAINT unique_customer_feedback UNIQUE (HotelCustomer_id)
);

create table RoomTypePrice(
room_type VARCHAR2(20) PRIMARY KEY,
room_price int
);

DESC hotelLogin
DESC hotel
DESC branch
desc rooms;
desc facilties
desc employeeHotelEmployee;
desc HotelCustomer;
desc reservation;
desc services;
desc HotelCustomersBill
desc discount
desc branch;
desc customersService
desc Customer_Feedback

ALTER TABLE reservation DROP COLUMN room_id;
ALTER TABLE reservation DROP COLUMN HotelCustomer_id;
ALTER TABLE reservation ADD HotelCustomer_id INT;

DROP TABLE HotelCustomersBill;
DROP TABLE customersService;
DROP TABLE reservation;
DROP TABLE HotelCustomer;
DROP TABLE HotelEmployee;
DROP TABLE room;
DROP TABLE branch;
DROP TABLE hotelLogin;
DROP TABLE hotel;
DROP TABLE discount;
DROP TABLE service;
DROP TABLE facility;
DROP TABLE Customer_Feedback;

TRUNCATE TABLE HOTELLOGIN;

--dhairyashil@IH_P1
--Prasad@SH_M1
--Sohel@WH_P1
--Vaishnavi@LH_M1

INSERT INTO hotelLogin (username, password) VALUES ('dhairyashil@IH_P1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Kunal@IH_P2', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Aniket@IH_M1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Manoharika@IH_G1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Vishal@SH_P1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Prasad@SH_M1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Pratik@SH_G1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Omkar@FH_P1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Hrishi@FH_M1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Sohel@WH_P1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Ratnesh@WH_G1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Vaishnavi@LH_M1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Ruturaj@LH_G1', 'pass');
INSERT INTO hotelLogin (username, password) VALUES ('Satyajit@LH_G2', 'pass');

INSERT INTO hotel (hotel_id, hotel_name, hotel_address) VALUES (1, 'Light Hotel', 'Apollo Bunder, pune');
INSERT INTO hotel (hotel_id, hotel_name, hotel_address) VALUES (2, 'Water Hotel', 'Santacruz East, Mumbai');
INSERT INTO hotel (hotel_id, hotel_name, hotel_address) VALUES (3, 'Food Hotel', 'Miramar, Panaji, Goa');
INSERT INTO hotel (hotel_id, hotel_name, hotel_address) VALUES (4, 'Sleep Hotel', 'Sahar, Andheri East, Mumbai');
INSERT INTO hotel (hotel_id, hotel_name, hotel_address) VALUES (5, 'Internet Hotel', 'Koregaon Park, Pune');

TRUNCATE TABLE hotel;

SELECT * FROM reservation;

SELECT * FROM room;

SELECT * FROM hotelcustomer;

Select * from hotel;

--Sparklinglight
--Brightlight
--Moonlight
--Sunlight
--Starlight

INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('IH_P1', 'Internet Hotel Pune', '1234 Main Street, Pune, Maharashtra, India', 5);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('IH_P2', 'Internet Hotel Pune', '5678 Common Street, Pune, Maharashtra, India', 5);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('IH_M1', 'Internet Hotel Mumbai', '5678 2nd Street, Mumbai, Maharashtra, India', 5);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('IH_G1', 'Internet Hotel Goa', '9012 Beach Road, Goa, India', 5);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('SH_P1', 'Sleep Hotel Pune', '3456 East Avenue, Pune, Maharashtra, India', 4);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('SH_M1', 'Sleep Hotel Mumbai', '7890 West Boulevard, Mumbai, Maharashtra, India', 4);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('SH_G1', 'Sleep Hotel Goa', '1234 Sea View Drive, Goa, India', 4);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('FH_P1', 'Food Hotel Pune', '5678 North Avenue, Pune, Maharashtra, India', 3);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('FH_M1', 'Food Hotel Mumbai', '9012 South Boulevard, Mumbai, Maharashtra, India', 3);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('WH_P1', 'Water Hotel Pune', '7890 West Drive, Pune, Maharashtra, India', 2);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('WH_G1', 'Water Hotel Goa', '5678 Beach Drive, Goa, India', 2);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('LH_M1', 'Light Hotel Mumbai', '3456 North Road, Mumbai, Maharashtra, India', 1);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('LH_G1', 'Light Hotel Goa', '7890 Main Boulevard, Goa, India', 1);
INSERT INTO branch(branch_id, branch_name, branch_address, hotel_id) VALUES ('LH_G2', 'Light Hotel Goa', '1234 East Boulevard, Goa, India', 1);

UPDATE branch SET capacity = 100 WHERE branch_id = 'IH_P1';
UPDATE branch SET capacity = 150 WHERE branch_id = 'IH_P2';
UPDATE branch SET capacity = 125 WHERE branch_id = 'IH_M1';
UPDATE branch SET capacity = 200 WHERE branch_id = 'IH_G1';
UPDATE branch SET capacity = 50 WHERE branch_id = 'SH_P1';
UPDATE branch SET capacity = 75 WHERE branch_id = 'SH_M1';
UPDATE branch SET capacity = 100 WHERE branch_id = 'SH_G1';
UPDATE branch SET capacity = 150 WHERE branch_id = 'FH_P1';
UPDATE branch SET capacity = 150 WHERE branch_id = 'FH_M1';
UPDATE branch SET capacity = 500 WHERE branch_id = 'WH_P1';
UPDATE branch SET capacity = 500 WHERE branch_id = 'WH_G1';
UPDATE branch SET capacity = 350 WHERE branch_id = 'LH_M1';
UPDATE branch SET capacity = 300 WHERE branch_id = 'LH_G1';
UPDATE branch SET capacity = 450 WHERE branch_id = 'LH_G2';


SELECT * FROM HOTELLOGIN;
SELECT * FROM HOTEL;
SELECT * FROM BRANCH;
SELECT * FROM ROOM;

SELECT * FROM HotelCustomersBill;

SELECT * FROM service;
SELECT * FROM customersService;

SELECT * FROM reservation;
SELECT * FROM HotelCustomer;

SELECT * FROM HotelEmployee;
SELECT * FROM discount;
SELECT * FROM facility;
SELECT * FROM Customer_Feedback;
SELECT * FROM RoomTypePrice;

INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (101, 'Standard', 'Yes', 'NO', 2000, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (102, 'Luxury', 'No', 'NO', 3000, 'IH_P2');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (103, 'LuxuryGOLD', 'Yes', 'NO', 5000, 'IH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (104, 'Standard', 'Yes', 'NO', 2500, 'IH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (105, 'Luxury', 'No', 'NO', 3500, 'IH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (106, 'Standard', 'Yes', 'NO', 2200, 'IH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (107, 'Luxury', 'No', 'NO', 3200, 'IH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (108, 'LuxuryGOLD', 'Yes', 'NO', 5500, 'SH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (109, 'Standard', 'Yes', 'NO', 2300, 'SH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (110, 'Luxury', 'No', 'NO', 3300, 'SH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (111, 'Standard', 'Yes', 'No', 2400, 'SH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (112, 'Luxury', 'No', 'Yes', 3400, 'SH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (113, 'Standard', 'Yes', 'No', 2100, 'SH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (114, 'Luxury', 'No', 'Yes', 3100, 'FH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (115, 'LuxuryGOLD', 'Yes', 'NO', 5200, 'FH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (116, 'Standard', 'Yes', 'NO', 2600, 'FH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (117, 'Luxury', 'No', 'NO', 3600, 'FH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (118, 'Standard', 'Yes', 'No', 2300, 'FH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (119, 'Luxury', 'No', 'Yes', 3300, 'FH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (120, 'Standard', 'Yes', 'No', 2000, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (121, 'Luxury', 'No', 'NO', 3000, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (122, 'LuxuryGOLD', 'Yes', 'NO', 5000, 'WH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (123, 'Standard', 'Yes', 'No', 2500, 'WH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (124, 'Luxury', 'No', 'NO', 3500, 'WH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (125, 'Standard', 'Yes', 'No', 2200, 'WH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (126, 'Luxury', 'No', 'NO', 3200, 'WH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (127, 'Standard', 'Yes', 'No', 2100, 'LH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (128, 'Luxury', 'No', 'Yes', 3100, 'LH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (129, 'Standard', 'Yes', 'No', 2400, 'LH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (130, 'Luxury', 'No', 'Yes', 3400, 'LH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (131, 'LuxuryGOLD', 'Yes', 'Yes', 5500, 'LH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (132, 'Standard', 'Yes', 'No', 2300, 'LH_G2');

INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (133, 'Standard', 'Yes', 'No', 2000, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (134, 'Luxury', 'No', 'Yes', 3000, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (135, 'LuxuryGOLD', 'Yes', 'NO', 5000, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (136, 'Standard', 'Yes', 'No', 2500, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (137, 'Luxury', 'No', 'NO', 3500, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (138, 'Standard', 'Yes', 'No', 2200, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (139, 'Luxury', 'No', 'Yes', 3200, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (140, 'LuxuryGOLD', 'Yes', 'NO', 5500, 'IH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (141, 'Standard', 'Yes', 'No', 2300, 'SH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (142, 'Luxury', 'No', 'Yes', 3300, 'SH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (143, 'Standard', 'Yes', 'No', 2400, 'SH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (144, 'Luxury', 'No', 'NO', 3400, 'SH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (145, 'Standard', 'Yes', 'No', 2100, 'SH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (146, 'Luxury', 'No', 'NO', 3100, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (147, 'LuxuryGOLD', 'Yes', 'NO', 5200, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (148, 'Standard', 'Yes', 'No', 2600, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (149, 'Luxury', 'No', 'NO', 3600, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (150, 'Standard', 'Yes', 'No', 2300, 'FH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (151, 'Luxury', 'No', 'NO', 3300, 'FH_G1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (152, 'Standard', 'Yes', 'No', 2000, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (153, 'Luxury', 'No', 'NO', 3000, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (154, 'LuxuryGOLD', 'Yes', 'NO', 5000, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (155, 'Standard', 'Yes', 'No', 2500, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (156, 'Luxury', 'No', 'NO', 3500, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (157, 'Standard', 'Yes', 'No', 2200, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (158, 'Luxury', 'No', 'NO', 3200, 'WH_P1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (159, 'Standard', 'Yes', 'No', 2100, 'LH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (160, 'Luxury', 'No', 'NO', 3100, 'LH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (161, 'Standard', 'Yes', 'No', 2400, 'LH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (162, 'Luxury', 'No', 'NO', 3400, 'LH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (163, 'LuxuryGOLD', 'Yes', 'NO', 5500, 'LH_M1');
INSERT INTO room (room_id, room_type, cleaning_check, booking_check, room_price, branch_id) VALUES  (164, 'Standard', 'Yes', 'No', 2300, 'LH_M1');

UPDATE room SET booking_check = 'NO' WHERE room_id = 158;
UPDATE room SET booking_check = 'NO' WHERE room_id = 157;
UPDATE room SET booking_check = 'NO' WHERE room_id = 155;

TRUNCATE TABLE HotelCustomer;
TRUNCATE TABLE service;
TRUNCATE TABLE reservation;
TRUNCATE TABLE HotelCustomer;
TRUNCATE TABLE room;

INSERT INTO facility (facility_id, facility_name, room_type)VALUES (1, 'Gym', 'Standard');
INSERT INTO facility (facility_id, facility_name, room_type)VALUES (2, 'Restaurant', 'Luxury');
INSERT INTO facility (facility_id, facility_name, room_type)VALUES (3, 'Swimming Pool', 'LuxuryGOLD');
INSERT INTO facility (facility_id, facility_name, room_type)VALUES (4, 'Spa', 'LuxuryGOLD');

ALTER TABLE facility RENAME COLUMN facility_type TO facility_name;

SELECT facility_name FROM facility where room_type = 'Standard';
SELECT facility_name FROM facility where room_type = 'Standard' AND room_type = 'Luxury';
SELECT facility_type FROM facility WHERE room_type IN ('Standard', 'Luxury');
SELECT facility_type FROM facility WHERE room_type = 'Standard' OR room_type = 'Luxury';
    
INSERT INTO HotelCustomer (HotelCustomer_id, HotelCustomer_name, room_id, branch_id, HotelCustomer_deposit, HotelCustomer_Address) VALUES (1, 'Dhairyashil Shinde', 101, 'IH_P1', 5000, '123 Main St');
INSERT INTO HotelCustomer (HotelCustomer_id, HotelCustomer_name, room_id, branch_id, HotelCustomer_deposit, HotelCustomer_Address) VALUES (2, 'Kunal Malhotra', 115, 'FH_P1', 7000, '456 Second St');
INSERT INTO HotelCustomer (HotelCustomer_id, HotelCustomer_name, room_id, branch_id, HotelCustomer_deposit, HotelCustomer_Address) VALUES (3, 'Aniket Fand', 130, 'LH_M1', 9000, '789 Third St');

UPDATE HotelCustomer SET HotelCustomer_name = 'New Name', room_id = 123, branch_id = 'New Branch ID', HotelCustomer_deposit = 456, HotelCustomer_Address = 'New Address' WHERE HotelCustomer_id = 1;

INSERT INTO HotelCustomersBill (HotelCustomersBill_id, HotelCustomersBill_totalAmount, HotelCustomersBill_status, billing_date, HotelCustomer_id) VALUES (1, 100, 'paid', SYSDATE, 1);
INSERT INTO HotelCustomersBill VALUES (1, 100, 'paid', SYSDATE, 1);

INSERT INTO service (service_id, service_name, service_price) VALUES (1, 'Airport pick-up/drop', 50);
INSERT INTO service (service_id, service_name, service_price) VALUES (2, 'Cab', 20);
INSERT INTO service (service_id, service_name, service_price) VALUES (3, 'Tour guide', 100);
INSERT INTO service (service_id, service_name, service_price) VALUES (4, 'Customised tour', 200);
INSERT INTO service (service_id, service_name, service_price) VALUES (5, 'Business services', 50);

INSERT INTO customersService (HotelCustomer_id, service_id) VALUES (1, 3);
INSERT INTO customersService (HotelCustomer_id, service_id) VALUES (2, 5);
INSERT INTO customersService (HotelCustomer_id, service_id) VALUES (3, 2);
INSERT INTO customersService (HotelCustomer_id, service_id) VALUES (1, 2);
INSERT INTO customersService (HotelCustomer_id, service_id) VALUES (2, 3);

INSERT INTO HotelEmployee (HotelEmployee_id, HotelEmployee_name, HotelEmployee_age, HotelEmployee_salary, branch_id, HotelEmployee_role) VALUES (1, 'John Smith', 30, 50000, 'IH_P1', 'Manager');
INSERT INTO HotelEmployee (HotelEmployee_id, HotelEmployee_name, HotelEmployee_age, HotelEmployee_salary, branch_id, HotelEmployee_role) VALUES (2, 'Jane Doe', 28, 45000, 'FH_P1', 'Assistant Manager');
INSERT INTO HotelEmployee (HotelEmployee_id, HotelEmployee_name, HotelEmployee_age, HotelEmployee_salary, branch_id, HotelEmployee_role) VALUES (3, 'Bob Johnson', 35, 60000, 'LH_M1', 'Director of Sales');
INSERT INTO HotelEmployee (HotelEmployee_id, HotelEmployee_name, HotelEmployee_age, HotelEmployee_salary, branch_id, HotelEmployee_role) VALUES (4, 'Alice Thompson', 22, 35000, 'SH_M1', 'Receptionist');
INSERT INTO HotelEmployee (HotelEmployee_id, HotelEmployee_name, HotelEmployee_age, HotelEmployee_salary, branch_id, HotelEmployee_role) VALUES (5, 'Tom Wilson', 27, 40000, 'WH_G1', 'Supervisor');

INSERT INTO discount VALUES ('off_season',30);
INSERT INTO discount VALUES ('on_season',10);

INSERT INTO RoomTypePrice(room_type, room_price) VALUES ('Standard', 2000);
INSERT INTO RoomTypePrice(room_type, room_price) VALUES ('Luxury', 5000);
INSERT INTO RoomTypePrice(room_type, room_price) VALUES ('LuxuryGOLD', 10000);


select * from room where branch_id='WH_P1' AND booking_check='Yes';

COMMIT;

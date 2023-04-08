CREATE TABLE students (id INTEGER, name VARCHAR(20), age INTEGER);

INSERT INTO students values(101, 'Dhairyashil Shinde', 21);
INSERT INTO students values(102, 'Pratik Tanawade', 100);
INSERT INTO students values(103, 'Prasad Gosavi', 40);

SELECT * FROM students;

DELETE FROM students WHERE id = 21;

DELETE FROM students
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM students
    GROUP BY id, name, age -- replace with your criteria for uniqueness
);

CREATE SEQUENCE my_sequence START WITH 1 INCREMENT BY 1;

CREATE FUNCTION string_length (str VARCHAR2)
RETURN INTEGER
IS
BEGIN
    RETURN LENGTH(str);
END;

DROP FUNCTION string_length;


commit;


-- ########################################################################

create table Memes (
memeId int primary key ,memeCategory varchar(20),memeImage blob
);


SELECT * FROM Memes;

-- ########################################################################

-- Que1
CREATE TABLE country (country_id INTEGER, country_name VARCHAR(20), region_id INTEGER);

select * from country;

-- Que2
CREATE TABLE countries  (country_id INTEGER PRIMARY KEY, country_name VARCHAR(20), region_id INTEGER);

-- Que3
INSERT INTO countries VALUES (1, 'India', NULL);
INSERT INTO countries (country_id, country_name, region_id) VALUES (1, 'United States', NULL);

SELECT * FROM countries;
-- Que4

CREATE TABLE employees (
  employee_id NUMBER(6) PRIMARY KEY,
  first_name VARCHAR2(20),
  last_name VARCHAR2(25) NOT NULL,
  email VARCHAR2(50) NOT NULL,
  job_department VARCHAR2(10) NOT NULL,
  salary NUMBER(8, 2) NOT NULL,
  commission_pct NUMBER(2, 2)
);

DROP TABLE employees;

SELECT * FROM employees;

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (101, 'Dhairyashil', 'Shinde', 'd.s@mail.com', 'SDE', 50000);

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (102, 'Prasad', 'Gosavi', 'p.g@mail.com', 'SDE', 50000);

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (103, 'Pratik', 'Tanawade', 'p.t@mail.com', 'HR', 2000);

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (104, 'Vishal', 'Gade', 'v.g@mail.com', 'HR', 4000);

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (105, 'Vaishnavi', 'Manoharika', 'v.m@mail.com', 'Consultant', 4999);

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (106, 'Gabbar', 'Singh', 'g.b@mail.com', 'Security', 500);

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (107, 'Cabbar', 'Singh', 'c.b@mail.com', 'Security', 500);

INSERT INTO employees (employee_id, first_name, last_name, email, job_department, salary)
VALUES (108, 'abcd', 'Singh', 'a.d@mail.com', 'Security', 500);

UPDATE employees SET email = 'not available', commission_pct = 0.10;

UPDATE employees
SET salary = 8000
WHERE employee_id = 105 AND salary < 5000;

-- Que 6

CREATE TABLE locations (
  location_id NUMBER(4),
  address VARCHAR2(40),
  postal_code VARCHAR2(12),
  city VARCHAR2(30),
  stateName VARCHAR2(25)
);

INSERT INTO locations (location_id, address, postal_code, city, stateName) 
VALUES (1000, '17/175 Pujari Mala', '416115', 'Ichalkaranji', 'Maharashtra');
INSERT INTO locations (location_id, address, postal_code, city, stateName) 
VALUES (1100, 'Bhagya nagar', '403203', 'Jalna', 'Maharashtra');
INSERT INTO locations (location_id, address, postal_code, city, stateName) 
VALUES (1200, 'Shivaji nagar', '403203', 'Jalna', 'Maharashtra');

SELECT * FROM locations;
DROP TABLE locations;

-- Que 6
ALTER TABLE locations ADD region_id NUMBER(4);

-- Que 7
ALTER TABLE locations ADD CONSTRAINT loc_pk PRIMARY KEY (location_id);

-- Que 8
SELECT first_name, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000;

-- Que 9
SELECT first_name
FROM employees
WHERE first_name LIKE '%b%' AND first_name LIKE '%c%';

-- Que 10
SELECT COUNT(DISTINCT job_department) as num_jobs FROM employees;

-- Que 11
SELECT job_department, COUNT(*) as num_employees
FROM employees
GROUP BY job_department;

-- Que 12
CREATE TABLE departments (
  department_id NUMBER(4) PRIMARY KEY,
  department_name VARCHAR2(30) NOT NULL,
  manager_id NUMBER(6),
  location_id NUMBER(4)
);

INSERT INTO departments VALUES (10, 'SDE', 200, 1700);
INSERT INTO departments VALUES (20, 'HR', 201, 1800);
INSERT INTO departments VALUES (30, 'Consultant', 114, 1700);
INSERT INTO departments VALUES (40, 'Security', 203, 2400);
INSERT INTO departments VALUES (50, 'Public Relations', 204, 2700);
INSERT INTO departments VALUES (60, 'Sales', 145, 2500);
INSERT INTO departments VALUES (70, 'Executive', 100, 1700);
INSERT INTO departments VALUES (80, 'Finance', 108, 1700);
INSERT INTO departments VALUES (90, 'Accounting', 205, 1700);


-- Que 12
SELECT e.first_name, e.last_name, d.department_id
FROM employees e
INNER JOIN departments d ON d.department_name = e.job_department;

-- Que 13
SELECT *
FROM employees e
LEFT JOIN departments d ON d.department_name = e.job_department;

-- Que 14
SELECT *
FROM employees e
RIGHT JOIN departments d ON d.department_name = e.job_department;

commit;


-- ##########################################################################################

-- query to show all tables from the current schema:
SELECT table_name FROM user_tables;

CREATE TABLE Customer (
  Cust_Id NUMBER PRIMARY KEY,
  Cust_Name VARCHAR2(50),
  Phone VARCHAR2(20),
  Address VARCHAR2(100),
  Credit_points NUMBER
);

SELECT * FROM Customer;

ALTER TABLE Customer ADD Cust_Type VARCHAR(15);

DROP TABLE Customer;

INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (1, 'Dhairyashil Shinde', '9172171393', '1 Katraj', 550);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (2, 'Pratik Tanawade', '9689080578', '1 Katraj', 420);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (3, 'Vishal Gade', '9999999999', '2 Katraj', 275);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (4, 'Prasad Gosavi', '8888888888', '2 Katraj', 280);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (5, 'Vaishnavi Manoharika', '1431431431', '3 Katraj', 150);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (6, 'Omkar Shinde', '7777777777', 'Hinjawadi', 625);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (7, 'Hrishikesh Galgale', '5555555555', 'Hinjawadi', 400);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (8, 'Sohel Shedbale', '9096211986', 'Pimpri Chinchwad', 500);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (9, 'Gabbar Singh', '00000000', 'Daku Nagar', 0);
INSERT INTO Customer (Cust_Id, Cust_Name, Phone, Address, Credit_points) VALUES (10, 'Chabbar Singh', '1111110000', 'Daku Nagar', 0);

UPDATE Customer SET Cust_Type = 'PLATINUM' WHERE Cust_Id = 1;
UPDATE Customer SET Cust_Type = 'GOLD' WHERE Cust_Id = 2;
UPDATE Customer SET Cust_Type = 'PLATINUM' WHERE Cust_Id = 3;
UPDATE Customer SET Cust_Type = 'GOLD' WHERE Cust_Id = 4;
UPDATE Customer SET Cust_Type = 'SILVER' WHERE Cust_Id = 5;
UPDATE Customer SET Cust_Type = 'PLATINUM' WHERE Cust_Id = 6;
UPDATE Customer SET Cust_Type = 'PLATINUM' WHERE Cust_Id = 7;
UPDATE Customer SET Cust_Type = 'GOLD' WHERE Cust_Id = 8;

UPDATE Customer SET Cust_Type = 'DEFAULT' WHERE Cust_Type IS NULL;

DELETE FROM Customer WHERE Cust_Id = 9;

CREATE TABLE Bill (
  Cust_id NUMBER,
  Bill_id NUMBER PRIMARY KEY,
  Amount NUMBER,
  Status VARCHAR2(20),
  Due_date DATE,
  Billing_date DATE,
  CONSTRAINT fk_bill_customer FOREIGN KEY (Cust_id)
    REFERENCES Customer(Cust_Id)
);

SELECT * FROM Customer WHERE Cust_id NOT IN ( SELECT Cust_id FROM Bill WHERE Status = 'pending');

SELECT * FROM Bill WHERE Status = 'pending';

SELECT * FROM Customer;
SELECT * FROM Bill;

COMMIT;

DROP TABLE Bill;

DELETE FROM Bill WHERE Bill_Id = 13;

INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (1, 1, 100, 'Paid', Date '2023-02-20', Date '2023-01-01');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (2, 1, 75, 'pending', Date '2023-02-15', Date'2023-02-01');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (3, 2, 50, 'Paid', Date '2023-02-22',Date '2023-01-15');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (4, 3, 150, 'pending', Date '2023-02-19', Date'2023-02-15');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (5, 4, 200, 'pending', Date '2023-02-28',Date '2023-02-15');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (6, 5, 125, 'Paid', Date '2023-02-15',Date '2023-02-01');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (7, 5, 172, 'pending', Date '2023-02-15',Date '2023-03-01');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (8, 6, 50, 'Paid', Date '2023-02-28',Date '2023-02-15');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (9, 7, 300, 'pending', Date '2023-03-31',Date '2023-03-01');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (10, 7, 150, 'pending', Date '2023-02-15',Date '2023-02-01');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (11, 7, 100, 'pending', Date '2023-04-01',Date '2023-03-15');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (12, 8, 220, 'Paid', Date '2023-05-02',Date '2023-04-16');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (13, 9, 150, 'pending', Date '2023-02-15',Date '2023-02-01');
INSERT INTO Bill (Bill_Id, Cust_Id, Amount, Status, Due_Date, Billing_Date) VALUES (14, 10, 150, 'Paid', Date '2023-02-15',Date '2023-02-01');

SELECT c.Cust_Id, c.Credit_points FROM Customer c WHERE NOT EXISTS (SELECT b.Cust_id FROM Bill b WHERE b.Cust_id = c.Cust_Id AND b.Status = 'pending');

CREATE TABLE PanaltyRate (
  Cust_Type VARCHAR(15) PRIMARY KEY,
  Rate NUMBER(2,2)
);

ALTER TABLE PanaltyRate MODIFY Rate NUMBER(5,3);

SELECT * FROM Customer;
SELECT * FROM Bill;
SELECT * FROM PanaltyRate;

INSERT INTO PanaltyRate (Cust_Type, Rate) VALUES ('PLATINUM', 1);
INSERT INTO PanaltyRate (Cust_Type, Rate) VALUES ('GOLD', 2.5);
INSERT INTO PanaltyRate (Cust_Type, Rate) VALUES ('SILVER', 4);
INSERT INTO PanaltyRate (Cust_Type, Rate) VALUES ('DEFAULT', 5);

COMMIT;

-- #############################################################################################

CREATE TABLE PaymentData (
    Payment_Id NUMBER PRIMARY KEY,
    Payer_Name VARCHAR2(50),
    Payment_Status VARCHAR2(20),
    Payment_Date DATE
);

SELECT * FROM PaymentData;

TRUNCATE TABLE PaymentData;

DROP TABLE PaymentData;

COMMIT;

INSERT INTO PaymentData (Payment_Id, Payer_Name, Payment_Status, Payment_Date) VALUES (1, 'John Smith', 'Paid', TO_DATE('2022-12-31', 'YYYY-MM-DD'));
INSERT INTO PaymentData (Payment_Id, Payer_Name, Payment_Status, Payment_Date) VALUES (2, 'Jane Doe', 'Unpaid', TO_DATE('2022-11-30', 'YYYY-MM-DD'));

-- #####################################################################################################

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
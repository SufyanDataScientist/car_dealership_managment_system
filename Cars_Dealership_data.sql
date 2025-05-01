create database cars;
use cars;
CREATE TABLE manufacturers (
    manufacturer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    country VARCHAR(30) NOT NULL,
    founded_year INT,
    headquarters VARCHAR(50)
);
INSERT INTO manufacturers VALUES
(1, 'Toyota', 'Japan', 1937, 'Toyota City, Aichi'),
(2, 'Honda', 'Japan', 1948, 'Minato, Tokyo'),
(3, 'Ford', 'USA', 1903, 'Dearborn, Michigan'),
(4, 'BMW', 'Germany', 1916, 'Munich, Bavaria'),
(5, 'Mercedes-Benz', 'Germany', 1926, 'Stuttgart, Baden-Württemberg'),
(6, 'Hyundai', 'South Korea', 1967, 'Seoul'),
(7, 'Tesla', 'USA', 2003, 'Palo Alto, California');
CREATE TABLE cars (
    car_id INT PRIMARY KEY,
    manufacturer_id INT,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    color VARCHAR(30),
    price DECIMAL(10,2) NOT NULL,
    fuel_type VARCHAR(20),
    transmission VARCHAR(20),
    engine_capacity INT,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id)
);
INSERT INTO cars VALUES
(101, 1, 'Camry', 2023, 'Silver', 24999.99, 'Gasoline', 'Automatic', 2500),
(102, 1, 'RAV4', 2023, 'Blue', 28999.99, 'Hybrid', 'Automatic', 2500),
(103, 2, 'Civic', 2023, 'Red', 22999.99, 'Gasoline', 'Automatic', 1800),
(104, 2, 'Accord', 2023, 'Black', 27999.99, 'Hybrid', 'Automatic', 2000),
(105, 3, 'Mustang', 2023, 'Yellow', 35999.99, 'Gasoline', 'Manual', 5000),
(106, 3, 'F-150', 2023, 'White', 38999.99, 'Gasoline', 'Automatic', 3500),
(107, 4, 'X5', 2023, 'Black', 59999.99, 'Diesel', 'Automatic', 3000),
(108, 5, 'E-Class', 2023, 'Silver', 54999.99, 'Diesel', 'Automatic', 2200),
(109, 6, 'Tucson', 2023, 'Gray', 31999.99, 'Gasoline', 'Automatic', 2400),
(110, 7, 'Model 3', 2023, 'White', 45999.99, 'Electric', 'Automatic', 0),
(111, 7, 'Model S', 2023, 'Blue', 89999.99, 'Electric', 'Automatic', 0),
(112, 4, '3 Series', 2023, 'Black', 42999.99, 'Gasoline', 'Automatic', 2000);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    phone VARCHAR(20),
    address VARCHAR(100),
    city VARCHAR(30),
    state VARCHAR(30),
    zip_code VARCHAR(20)
);
INSERT INTO customers VALUES
(1001, 'John', 'Smith', 'john.smith@email.com', '555-123-4567', '123 Main St', 'New York', 'NY', '10001'),
(1002, 'Emily', 'Johnson', 'emily.j@email.com', '555-234-5678', '456 Oak Ave', 'Los Angeles', 'CA', '90001'),
(1003, 'Michael', 'Williams', 'michael.w@email.com', '555-345-6789', '789 Pine Rd', 'Chicago', 'IL', '60601'),
(1004, 'Sarah', 'Brown', 'sarah.b@email.com', '555-456-7890', '321 Elm St', 'Houston', 'TX', '77001'),
(1005, 'David', 'Jones', 'david.j@email.com', '555-567-8901', '654 Maple Ave', 'Phoenix', 'AZ', '85001'),
(1006, 'Jessica', 'Garcia', 'jessica.g@email.com', '555-678-9012', '987 Cedar Ln', 'Philadelphia', 'PA', '19101'),
(1007, 'Robert', 'Miller', 'robert.m@email.com', '555-789-0123', '159 Birch Blvd', 'San Antonio', 'TX', '78201');

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    car_id INT,
    customer_id INT,
    sale_date DATE NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,
    salesperson VARCHAR(50),
    payment_method VARCHAR(30),
    salesperson_id int,
    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (salesperson_id) REFERENCES salespersons(salesperson_id)
);
INSERT INTO sales VALUES
(5001, 101, 1001, '2023-01-15', 24500.00, 'Alex Turner', 'Loan',1),
(5002, 105, 1002, '2023-02-20', 35500.00, 'Jamie Wilson', 'Cash',2),
(5003, 110, 1003, '2023-03-10', 45000.00, 'Taylor Smith', 'Lease',1),
(5004, 107, 1004, '2023-04-05', 59000.00, 'Alex Turner', 'Loan',4),
(5005, 103, 1005, '2023-05-12', 22500.00, 'Jamie Wilson', 'Cash',3),
(5006, 108, 1006, '2023-06-18', 54000.00, 'Taylor Smith', 'Loan',1),
(5007, 111, 1007, '2023-07-22', 89000.00, 'Alex Turner', 'Cash',4),
(5008, 102, 1001, '2023-08-30', 28500.00, 'Jamie Wilson', 'Loan',1);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    car_id INT,
    arrival_date DATE,
    current_status VARCHAR(20) CHECK (current_status IN ('Available', 'Sold', 'Reserved', 'In Service')),
    showroom_location VARCHAR(50),
    FOREIGN KEY (car_id) REFERENCES cars(car_id)
);
INSERT INTO inventory VALUES
(2001, 101, '2022-12-10', 'Sold', 'Main Showroom'),
(2002, 102, '2022-12-15', 'Sold', 'Main Showroom'),
(2003, 103, '2023-01-05', 'Sold', 'Downtown Showroom'),
(2004, 104, '2023-01-10', 'Available', 'Main Showroom'),
(2005, 105, '2023-01-15', 'Sold', 'Downtown Showroom'),
(2006, 106, '2023-02-01', 'Available', 'Main Showroom'),
(2007, 107, '2023-02-10', 'Sold', 'Main Showroom'),
(2008, 108, '2023-02-15', 'Sold', 'Downtown Showroom'),
(2009, 109, '2023-03-01', 'Available', 'Main Showroom'),
(2010, 110, '2023-03-05', 'Sold', 'Downtown Showroom'),
(2011, 111, '2023-03-10', 'Sold', 'Main Showroom'),
(2012, 112, '2023-03-15', 'Available', 'Downtown Showroom');


CREATE TABLE maintenance (
    maintenance_id INT PRIMARY KEY,
    car_id INT,
    service_date DATE NOT NULL,
    service_type VARCHAR(50) NOT NULL,
    description VARCHAR(200),
    cost DECIMAL(10,2) NOT NULL,
    service_center VARCHAR(50),
    next_service_date DATE,
    FOREIGN KEY (car_id) REFERENCES cars(car_id)
);
INSERT INTO maintenance VALUES
(3001, 101, '2023-03-15', 'Oil Change', 'Synthetic oil change and filter replacement', 89.99, 'Main Service Center', '2023-09-15'),
(3002, 105, '2023-04-20', 'Tire Rotation', 'Tire rotation and pressure check', 49.99, 'Downtown Service', '2023-10-20'),
(3003, 110, '2023-05-10', 'Battery Check', 'EV battery health inspection', 129.99, 'Electric Vehicle Center', '2024-05-10'),
(3004, 107, '2023-06-05', 'Brake Service', 'Brake pad replacement and fluid flush', 349.99, 'Main Service Center', '2023-12-05'),
(3005, 103, '2023-07-12', 'Annual Inspection', 'Complete 30-point inspection', 99.99, 'Downtown Service', '2024-07-12'),
(3006, 108, '2023-08-18', 'Transmission Service', 'Transmission fluid change', 199.99, 'Main Service Center', '2024-08-18'),
(3007, 111, '2023-09-22', 'Software Update', 'Vehicle system software upgrade', 0.00, 'Electric Vehicle Center', '2024-03-22'),
(3008, 102, '2023-10-30', 'Oil Change', 'Hybrid system oil change', 119.99, 'Main Service Center', '2024-04-30');


CREATE TABLE salespersons (
    salesperson_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    phone VARCHAR(20),
    hire_date DATE,
    commission_rate DECIMAL(5,2) NOT NULL,
    manager_id INT
);
INSERT INTO salespersons VALUES
(1, 'Alex Turner', 'alex.turner@showroom.com', '555-111-2222', '2020-03-15', 0.10, NULL),
(2, 'Jamie Wilson', 'jamie.wilson@showroom.com', '555-222-3333', '2021-05-20', 0.12, 1),
(3, 'Taylor Smith', 'taylor.smith@showroom.com', '555-333-4444', '2022-01-10', 0.08, 1),
(4, 'Morgan Lee', 'morgan.lee@showroom.com', '555-444-5555', '2023-02-15', 0.15, 2);

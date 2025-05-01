-- Basic Queries
-- List all car models along with their manufacturers' names and countries.
SELECT 
    name, country
FROM
    manufacturers;

-- Show all customers from Texas (TX) sorted by last name.
SELECT 
    first_name, last_name, state
FROM
    customers
WHERE
    state = 'TX';


-- Display all electric cars (fuel_type = 'Electric') with their prices.
SELECT 
    car_id, name, fuel_type
FROM
    cars AS c
        JOIN
    manufacturers AS m ON m.manufacturer_id = c.manufacturer_id
WHERE
    fuel_type = 'Electric';



-- Find all sales made in the first quarter of 2023 (January to March).

SELECT 
    sale_date, first_name, sale_price, payment_method
FROM
    sales AS s
        JOIN
    customers AS c ON c.customer_id = s.customer_id
WHERE
    sale_date BETWEEN '2023-1-1' AND '2023-4-1';


-- Intermediate Queries
-- Calculate the total sales amount for each salesperson.
SELECT 
    first_name, SUM(sale_price) AS sale
FROM
    sales AS s
        JOIN
    customers AS c ON s.customer_id = c.customer_id
GROUP BY first_name;



-- Find the average price of cars by manufacturer, ordered from highest to lowest.
SELECT 
    AVG(sale_price) AS average_price
FROM
    sales;

-- Show all cars that are currently available in inventory (current_status = 'Available').
SELECT 
    name, current_status
FROM
    inventory AS i
        JOIN
    cars AS c ON i.car_id = c.car_id
        JOIN
    manufacturers AS m ON m.manufacturer_id = c.manufacturer_id
WHERE
    current_status = 'Available';

-- List customers who purchased more than one car (appear more than once in sales table).
SELECT 
    s.customer_id,
    cu.first_name,
    SUM(s.sale_price) AS total_spent,
    COUNT(s.customer_id) AS purchase_count
FROM sales AS s 
JOIN cars AS c ON s.car_id = c.car_id 
JOIN customers AS cu ON cu.customer_id = s.customer_id 
JOIN manufacturers AS m ON m.manufacturer_id = c.manufacturer_id 
GROUP BY s.customer_id, cu.first_name;
-- Advanced Queries
-- Find the top 3 most expensive cars sold, including customer information.
SELECT 
    s.customer_id,
    cu.first_name,
    cu.last_name,
    name,
    sale_price,
    cu.email,
    cu.phone,
    cu.address,
    cu.city,
    cu.state
FROM
    sales AS s
        JOIN
    cars AS c ON s.car_id = c.car_id
        JOIN
    customers AS cu ON cu.customer_id = s.customer_id
        JOIN
    manufacturers AS m ON m.manufacturer_id = c.manufacturer_id
ORDER BY sale_price DESC
LIMIT 3;


-- Find all hybrid cars that haven't been sold yet (exist in inventory but not in sales).
SELECT 
    m.name ,i.car_id
FROM 
    cars AS c 
JOIN 
    sales AS s ON c.car_id = s.car_id 
JOIN 
    inventory AS i ON i.car_id = c.car_id 
JOIN 
    manufacturers AS m ON m.manufacturer_id = c.manufacturer_id
    WHERE 
    c.fuel_type = 'Hybrid'
    AND i.current_status = 'Available'
    AND s.car_id IS NULL;


-- Find salespersons who have sold cars with prices above the average car price.
SELECT 
    ROUND(AVG(price), 2) as avg_price
FROM
    cars;
SELECT 
    name, s.sale_price
FROM
    salespersons AS sp
        JOIN
    sales AS s ON sp.salesperson_id = s.salesperson_id
WHERE
    s.sale_price > 42166.66;
-- Show customers who bought cars from manufacturers based in their same country.
SELECT 
    c.first_name, city
FROM
    sales AS s
        JOIN
    customers AS c ON s.customer_id = c.customer_id
        JOIN
    cars ON cars.car_id = s.car_id
        JOIN
    manufacturers AS m ON m.manufacturer_id = cars.manufacturer_id
WHERE
    cars.manufacturer_id = m.manufacturer_id;
-- Aggregation and Grouping
-- Calculate the total commission earned by each salesperson.
SELECT 
    sp.salesperson_id,
    sp.name AS salesperson_name,
    sp.commission_rate,
    (SELECT 
            COUNT(*)
        FROM
            sales s
        WHERE
            s.salesperson_id = sp.salesperson_id) AS total_sales,
    (SELECT 
            COALESCE(SUM(sale_price), 0)
        FROM
            sales s
        WHERE
            s.salesperson_id = sp.salesperson_id) AS total_sales_amount,
    ROUND((SELECT 
                    COALESCE(SUM(sale_price * sp.commission_rate), 0)
                FROM
                    sales s
                WHERE
                    s.salesperson_id = sp.salesperson_id),
            2) AS total_commission
FROM
    salespersons sp
ORDER BY total_commission DESC;

-- Find the most popular car color among sold vehicles.
SELECT 
    color, COUNT(color) AS puplor_color
FROM
    cars AS c
        JOIN
    sales AS s ON c.car_id = s.car_id
GROUP BY color
ORDER BY puplor_color DESC
LIMIT 2;
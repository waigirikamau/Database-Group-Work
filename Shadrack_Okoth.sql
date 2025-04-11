-- creating DB
CREATE DATABASE BookstoreDB;
USE BookstoreDB;

--  Table Schemas and SQL Creation
-- 1. book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    publisher_id INT,
    language_id INT,
    price DECIMAL(10,2),
    publication_year YEAR,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);
-- 2. book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 3. author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    bio TEXT
);

-- 4. book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100)
);

-- 5. publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address TEXT
);

-- 6. customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20)
);

-- 7. customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 8.address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100)
);

-- 9. address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 10. country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- 11.cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    shipping_method_id INT,
    order_status_id INT,
    order_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- 12. order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 13. shipping_method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100)
);

-- 14. order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);

-- 15. order_status
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100)
);
-- Creating User Roles
CREATE USER 'store_admin'@'localhost' IDENTIFIED BY '1978';
GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'store_admin'@'localhost';

CREATE USER 'store_staff'@'localhost' IDENTIFIED BY 'S1978';
GRANT SELECT, INSERT, UPDATE ON BookstoreDB.* TO 'store_staff'@'localhost';
SELECT user, host FROM mysql.user WHERE user = 'store_staff';


-- Book Language
INSERT INTO book_language (language_name) VALUES
('English'), ('French'), ('Swahili');
-- Publisher
INSERT INTO publisher (name, address) VALUES
('Penguin Random House', '1745 Broadway, New York'),
('Macmillan Publishers', '120 Broadway, New York'),
('East African Educational Publishers', 'Nairobi, Kenya');
-- Author
INSERT INTO author (name, bio) VALUES
('Chinua Achebe', 'Nigerian novelist, best known for Things Fall Apart.'),
('Ngũgĩ wa Thiong''o', 'Kenyan writer and academic known for literature in Gikuyu.'),
('J.K. Rowling', 'British author best known for the Harry Potter series.');

-- Book
INSERT INTO book (title, publisher_id, language_id, price, publication_year) VALUES
('Things Fall Apart', 3, 1, 12.99, 1958),
('Wizard of the Crow', 3, 1, 15.00, 2006),
('Harry Potter and the Sorcerer''s Stone', 1, 1, 20.00, 1997);

-- Book Author
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), (2, 2), (3, 3);

-- Country
INSERT INTO country (country_name) VALUES
('Kenya'), ('United States'), ('United Kingdom'),('Canada'), ('India');
-- Address
INSERT INTO address (street, city, postal_code, country_id) VALUES
 ('Kenyatta Ave', 'Nairobi', '00100', 1),
 ('5th Avenue', 'New York', '10011', 2),
 ('699 David Throughway Apt. 869', 'East Ruben', '87662', 1),
 ('5867 Wagner Wells Apt. 304', 'Lake Jessicaside', '78805', 2),
 ('528 Gonzalez Brook Suite 134', 'New Robert', '79502', 1),
 ('746 Williams Plaza Suite 141', 'West Jeffreyhaven', '85329', 1),
 ('7761 Mccarty Isle', 'Edwardston', '47544', 5),
 ('96770 Thompson Shoals Apt. 742', 'Medinaborough', '38101', 2),
 ('034 Jonathan Port', 'Flemingfort', '69698', 1),
 ('029 Rivera Plaza', 'Port Michael', '39424', 3),
 ('946 Karen Glens', 'South Stephen', '56516', 3),
 ('54539 Lewis Row', 'Alexanderland', '98480', 3),
 ('22285 Daniel Corner', 'Millerhaven', '98547', 1),
 ('6436 Burns Tunnel', 'Brooksbury', '97021', 4),
 ('06880 Davis Rue Suite 971', 'Lisaberg', '61752', 4),
 ('284 Rodgers Flat Apt. 628', 'Katherineview', '99761', 3),
 ('013 Mays Field Suite 654', 'Maryville', '98833', 2),
 ('2749 Brown Burg Apt. 187', 'South George', '35629', 1),
 ('65491 Shawn Landing Apt. 933', 'West Patricia', '38943', 5),
 ('269 Richardson Orchard Suite 052', 'North Tiffany', '47938', 4),
 ('01444 Wilson Crest Suite 893', 'New Juliaport', '76625', 5),
 ('991 Jeffrey Ports', 'Carrollborough', '22096', 3),
 ('Baker Street', 'London', 'NW1', 3);
-- Address Status
INSERT INTO address_status (status_name) VALUES
('Current'), ('Old');
-- Customer
INSERT INTO customer (name, email, phone) VALUES
('John Doe', 'john@example.com', '0700123456'),
('Robert Morales', 'amanda67@robinson-deleon.com', '001-999-741'),
('Kevin Wright', 'brivas@benson.com', '+1-517-786-0026'),
('Cheryl Osborne', 'theresaarcher@yahoo.com', '658-665-669696'),
('Brent Arias', 'zfitzpatrick@hotmail.com', '(595)645-371743'),
('Bryan Reyes', 'donna94@melendez.com', '(414)029-8217'),
('Cheryl Ortega', 'anne38@gmail.com', '(388)182-59716'),
('Brandon Torres', 'ivalencia@donaldson-mack.info', '001-240-331'),
('Terry Sims', 'erin87@gmail.com', '707.731.00887'),
('Amanda Stein', 'wagnerrobin@hunt.com', '250.510.1825'),
('Brad Harvey', 'ijohnson@hernandez.com', '(398-183594'),
('Robin Cruz', 'robertmercado@castillo.com', '467-328-83541'),
('Melissa Robinson', 'alexanderhebert@hotmail.com', '+1-180-054-0027'),
('Jasmine Ford', 'alyssa78@roberts.com', '416-663-1566x512'),
('David Jones', 'rebekahburns@woodward-dixon.com', '+1-851-985-578'),
('Timothy Craig', 'kyle57@cooper.com', '+1-424-654-07011'),
('Michael Lee', 'wwright@barton.biz', '214.182.359'),
('Taylor Williams', 'keithshepherd@kerr.com', '078.649.4303'),
('John Ellis', 'angelaanderson@gmail.com', '868-680-2796'),
('Michael Waters', 'spearsbenjamin@gmail.com', '(227)749-3568'),
('Ryan Turner', 'dcooper@alexander.org', '+1-427-749-77324'),
('Mary Wanjiku', 'mary@example.com', '0720987654');
-- Customer Address
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
 (1, 1, 1),
 (2, 2, 1),
 (3, 3, 1),
 (4, 4, 1),
 (5, 5, 1),
 (6, 6, 1),
 (7, 7, 1),
 (8, 8, 1),
 (9, 9, 1),
 (10, 10, 1),
 (11, 11, 1),
 (12, 12, 1),
 (13, 13, 1),
 (14, 14, 1),
 (15, 15, 1),
 (16, 16, 1),
 (17, 17, 1),
 (18, 18, 1),
 (19, 19, 1),
 (20, 20, 1);
 -- Shipping Method
 INSERT INTO shipping_method (method_name) VALUES
('Courier'), ('Pickup'), ('Postal Service');
-- Order Status
INSERT INTO order_status (status_name) VALUES
('Pending'), ('Shipped'), ('Delivered'), ('Cancelled');
-- Customer Order
INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id, order_date) VALUES
(1, 1, 1, '2025-04-10 10:30:00'),
(2, 2, 2, '2025-04-09 14:45:00'),
(1, 3, 4, '2024-10-04 16:24:14'),
(2, 2, 3, '2024-09-10 05:41:59'),
(3, 3, 3, '2025-03-18 11:59:17'),
(4, 1, 3, '2024-12-16 08:50:18'),
(5, 3, 4, '2024-10-01 10:54:42'),
(6, 3, 2, '2024-08-29 05:06:38'),
(7, 2, 3, '2024-04-29 17:22:53'),
(8, 1, 3, '2024-12-25 08:40:09'),
(9, 2, 1, '2024-09-26 12:42:10'),
(10, 3, 1, '2025-01-30 10:54:18'),
(11, 2, 4, '2025-01-16 06:24:36'),
(12, 3, 2, '2024-07-29 11:11:11'),
(13, 1, 2, '2024-10-17 19:28:34'),
(14, 3, 3, '2024-06-03 19:41:30'),
(15, 3, 3, '2024-06-22 21:16:55'),
(16, 3, 3, '2024-09-20 05:46:36'),
(17, 2, 3, '2024-11-12 19:55:18'),
(18, 1, 3, '2024-10-28 06:47:39'),
(19, 2, 1, '2024-09-29 04:21:39'),
(20, 3, 2, '2024-11-04 16:48:08');

-- Order Line
INSERT INTO order_line (order_id, book_id, quantity) VALUES
 (1, 1, 2),
 (2, 2, 1),
 (1, 3, 1),
 (6, 1, 4),
 (11, 3, 1),
 (7, 1, 1),
 (19, 1, 3),
 (11, 1, 1),
 (20, 2, 3),
 (15, 3, 1),
 (9, 1, 5),
 (14, 1, 4),
 (17, 3, 4),
 (8, 3, 3),
 (8, 2, 2),
 (9, 3, 2),
 (11, 1, 2),
 (17, 2, 4),
 (19, 1, 2),
 (15, 1, 1),
 (8, 1, 1),
 (13, 2, 5),
 (7, 1, 5),
 (14, 2, 4),
 (12, 3, 1),
 (8, 3, 4),
 (1, 1, 1),
 (20, 1, 5),
 (14, 3, 3),
 (4, 3, 1),
 (7, 3, 3),
 (7, 2, 5),
 (2, 3, 3),
 (12, 1, 2),
 (11, 3, 4),
 (15, 3, 4),
 (18, 3, 1),
 (9, 2, 5),
 (8, 2, 2),
 (18, 1, 4),
 (15, 3, 2),
 (17, 2, 1) AS new
ON DUPLICATE KEY UPDATE quantity = quantity + new.quantity;
 
-- Order History
INSERT INTO order_history (order_id, status_id, status_date) VALUES
(1, 1, '2025-04-10 10:30:00'),
(2, 1, '2025-04-09 14:45:00'),
(13, 4, '2024-06-04 15:29:11'),
(2, 4, '2024-05-26 22:31:30'),
(5, 2, '2024-05-23 06:24:42'),
(17, 4, '2024-11-28 15:31:04'),
(1, 4, '2024-10-14 06:48:23'),
(18, 2, '2024-07-10 09:02:34'),
(19, 2, '2024-09-08 23:55:01'),
(2, 4, '2024-07-04 21:04:25'),
(18, 4, '2024-10-29 07:07:54'),
(16, 4, '2025-02-04 13:09:24'),
(2, 4, '2024-06-11 14:49:39'),
(17, 4, '2024-08-11 10:10:14'),
(15, 2, '2024-09-21 03:29:26'),
(2, 4, '2025-02-12 15:24:26'),
(4, 1, '2024-10-04 22:08:40'),
(12, 1, '2025-04-06 09:26:02'),
(17, 1, '2024-11-13 16:13:16'),
(6, 2, '2024-10-15 08:21:30'),
(16, 2, '2024-12-25 12:45:59'),
(3, 4, '2024-08-24 22:32:14'),
(13, 2, '2024-10-25 09:08:51'),
(4, 3, '2024-06-22 18:06:53'),
(18, 2, '2024-12-09 05:38:34'),
(4, 2, '2025-01-31 20:57:15'),
(1, 4, '2024-08-14 00:44:27'),
(3, 3, '2024-08-25 14:40:54'),
(16, 3, '2024-05-04 16:56:16'),
(6, 1, '2024-07-31 05:43:44'),
(16, 4, '2024-10-28 20:50:16'),
(19, 2, '2025-02-28 08:22:14'),
(7, 2, '2024-05-05 03:44:15'),
(7, 2, '2025-02-19 15:29:07'),
(8, 4, '2024-09-28 02:34:35'),
(9, 3, '2024-08-05 02:52:16'),
(2, 3, '2024-06-05 23:27:13'),
(18, 3, '2024-04-27 05:09:41'),
(17, 3, '2025-03-12 05:07:46'),
(8, 3, '2024-08-31 23:14:12'),
(17, 1, '2024-09-01 01:45:28'),
(6, 2, '2024-07-28 19:50:00'),
(2, 2, '2025-04-10 09:00:00');

show tables;
select* from address;
select* from address_status;
select* from author;
select* from book;
select* from book_author;
select* from book_language;
select* from country;
select* from cust_order;
select* from customer;
select* from customer_address;
select* from order_history;
select* from order_line;
select* from order_status;
select* from publisher;
select* from shipping_method;
























create database LMS;

use LMS;

INSERT INTO Book (isbn, title, author, genre, publication_Year, available) 
VALUES 
(9780143039439, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, true),
(9780735219090, 'Where the Crawdads Sing', 'Delia Owens', 'Mystery', 2018, true),
(9780385341672, 'The Girl on the Train', 'Paula Hawkins', 'Thriller', 2015, true),
(9780739341163, 'The Help', 'Kathryn Stockett', 'Historical Fiction', 2009, true),
(9781400033416, 'The Kite Runner', 'Khaled Hosseini', 'Historical Fiction', 2003, true),
(9781594634024, 'All the Light We Cannot See', 'Anthony Doerr', 'Historical Fiction', 2014, true),
(9780670030553, 'The Goldfinch', 'Donna Tartt', 'Fiction', 2013, true),
(9780385504201, 'A Thousand Splendid Suns', 'Khaled Hosseini', 'Historical Fiction', 2007, true),
(9780307271342, 'The Night Circus', 'Erin Morgenstern', 'Fantasy', 2011, true),
(9780307248435, 'The Book Thief', 'Markus Zusak', 'Historical Fiction', 2005, true),
(9780307271326, 'Think and Grow Rich', 'Napoleon Hill', 'Motivation', 1937, true),
(9780307271327, 'Think and Grow Rich', 'Napoleon Hill', 'Motivation', 1937, true),
(9780307271328, 'Think and Grow Rich', 'Napoleon Hill', 'Motivation', 1937, true),
(9780307271329, 'Think and Grow Rich', 'Napoleon Hill', 'Motivation', 1937, true);


INSERT INTO User (userID, emailID, user_Name, password, contact_Number, is_Admin) 
VALUES 
(1, 'admin@example.com', 'Admin', '123', '+1 (123) 456-7890', true),
(2, 'bob@example.com', 'Bob Johnson', 'password456', '+1 (234) 567-8901', false),
(3, 'charlie@example.com', 'Charlie Brown', 'password789', '+1 (345) 678-9012', false),
(4, 'david@example.com', 'David Wilson', 'passwordabc', '+1 (456) 789-0123', false),
(5, 'emily@example.com', 'Emily Davis', 'passworddef', '+1 (567) 890-1234', false),
(6, 'frank@example.com', 'Frank Miller', 'passwordghi', '+1 (678) 901-2345', false),
(7, 'grace@example.com', 'Grace Taylor', 'passwordjkl', '+1 (789) 012-3456', false),
(8, 'henry@example.com', 'Henry Clark', 'passwordmno', '+1 (890) 123-4567', false),
(9, 'isabel@example.com', 'Isabel Martinez', 'passwordpqr', '+1 (901) 234-5678', false),
(10, 'jack@example.com', 'Jack Robinson', 'passwordstu', '+1 (012) 345-6789', false);


-- ** This data cannot be added using the below query because of dependencies
-- We can only add this using the UI of the application

INSERT INTO Borrowing_Transaction (id, borrowing_Date, return_Date, user_id, book_isbn)
VALUES
('1', '2024-03-01', NULL, '9780062315007', '1'),
('2', '2024-03-08', '2024-03-30', '9780739341163', '2'),
('3', '2024-03-08', '2024-03-30', '9781594634024', '8'),
('4', '2024-03-09', '2024-03-30', '9780670030553', '8'),
('5', '2024-03-31', NULL, '9781594634024', '4'),
('6', '2024-03-31', NULL, '9780739341163', '8');


show tables;

describe user;
select * from user;

describe book;
select * from book;

describe Borrowing_Transaction;
select * from Borrowing_Transaction;

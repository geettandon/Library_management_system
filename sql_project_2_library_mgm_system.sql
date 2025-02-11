-- Project 2 
-- Library Management System

-- Creating Table branch
DROP TABLE IF EXISTS branch;
CREATE TABLE branch (
	branch_id		VARCHAR(20) PRIMARY KEY,	
	manager_id		VARCHAR(20),
	branch_address	VARCHAR(100),
	contact_no		VARCHAR(20)
);

-- Creating Table employees
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	emp_id		VARCHAR(10) PRIMARY KEY,
	emp_name	VARCHAR(50),
	position	VARCHAR(20),
	salary		INT,
	branch_id 	VARCHAR(20)
);

-- Creating Table books
DROP TABLE IF EXISTS books;
CREATE TABLE books (
	isbn			VARCHAR(50) PRIMARY KEY,
	book_title		VARCHAR(200),
	category		VARCHAR(50),
	rental_price	DECIMAL(10,2),
	status			VARCHAR(10),
	author			VARCHAR(50),
	publisher 		VARCHAR(50) 
);

-- Creating Table members
DROP TABLE IF EXISTS members;
CREATE TABLE members (
	member_id		VARCHAR(10) PRIMARY KEY,
	member_name		VARCHAR(50),
	member_address	VARCHAR(50),
	reg_date		DATE
);

-- Creating Table issued_status
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status (
	issued_id			VARCHAR(10) PRIMARY KEY,
	issued_member_id	VARCHAR(10),
	issued_book_name	VARCHAR(200),
	issued_date			DATE,
	issued_book_isbn	VARCHAR(50),
	issued_emp_id		VARCHAR(10)
);

-- Creating Table return_status
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status (
	return_id			VARCHAR(10) PRIMARY KEY,
	issued_id			VARCHAR(10),
	return_book_name	VARCHAR(200),
	return_date			DATE,
	return_book_isbn	VARCHAR(50)
);

-- Adding Foreign Key Constraints
-- issued_status member_id
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

-- issued_status books
ALTER TABLE issued_status
ADD CONSTRAINT fk_issued_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

-- issued_status employee
ALTER TABLE issued_status
ADD CONSTRAINT fk_employee
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

-- return_status issue_status
ALTER TABLE return_status
ADD CONSTRAINT fk_issue_status
FOREIGN KEY (issue_id)
REFERENCES issue_status(issue_id);

-- return_status books
ALTER TABLE return_status
ADD CONSTRAINT fk_return_books
FOREIGN KEY (return_book_isbn)
REFERENCES books(isbn);

-- employee branch
ALTER TABLE employees
ADD CONSTRAINT fk_emp_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

-- Inserting values
INSERT INTO members(member_id, member_name, member_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');
SELECT * FROM members;


-- Insert values into each branch table
INSERT INTO branch(branch_id, manager_id, branch_address, contact_no) 
VALUES
('B001', 'E109', '123 Main St', '+919099988676'),
('B002', 'E109', '456 Elm St', '+919099988677'),
('B003', 'E109', '789 Oak St', '+919099988678'),
('B004', 'E110', '567 Pine St', '+919099988679'),
('B005', 'E110', '890 Maple St', '+919099988680');
SELECT * FROM branch;


-- Insert values into each employees table
INSERT INTO employees(emp_id, emp_name, position, salary, branch_id) 
VALUES
('E101', 'John Doe', 'Clerk', 60000.00, 'B001'),
('E102', 'Jane Smith', 'Clerk', 45000.00, 'B002'),
('E103', 'Mike Johnson', 'Librarian', 55000.00, 'B001'),
('E104', 'Emily Davis', 'Assistant', 40000.00, 'B001'),
('E105', 'Sarah Brown', 'Assistant', 42000.00, 'B001'),
('E106', 'Michelle Ramirez', 'Assistant', 43000.00, 'B001'),
('E107', 'Michael Thompson', 'Clerk', 62000.00, 'B005'),
('E108', 'Jessica Taylor', 'Clerk', 46000.00, 'B004'),
('E109', 'Daniel Anderson', 'Manager', 57000.00, 'B003'),
('E110', 'Laura Martinez', 'Manager', 41000.00, 'B005'),
('E111', 'Christopher Lee', 'Assistant', 65000.00, 'B005');
SELECT * FROM employees;


-- Inserting into books table 
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES
('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
('978-0-330-25864-8', 'Animal Farm', 'Classic', 5.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-118776-1', 'One Hundred Years of Solitude', 'Literary Fiction', 6.50, 'yes', 'Gabriel Garcia Marquez', 'Penguin Books'),
('978-0-525-47535-5', 'The Great Gatsby', 'Classic', 8.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-141-44171-6', 'Jane Eyre', 'Classic', 4.00, 'yes', 'Charlotte Bronte', 'Penguin Classics'),
('978-0-307-37840-1', 'The Alchemist', 'Fiction', 2.50, 'yes', 'Paulo Coelho', 'HarperOne'),
('978-0-679-76489-8', 'Harry Potter and the Sorcerers Stone', 'Fantasy', 7.00, 'yes', 'J.K. Rowling', 'Scholastic'),
('978-0-7432-4722-4', 'The Da Vinci Code', 'Mystery', 8.00, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-09-957807-9', 'A Game of Thrones', 'Fantasy', 7.50, 'yes', 'George R.R. Martin', 'Bantam'),
('978-0-393-05081-8', 'A Peoples History of the United States', 'History', 9.00, 'yes', 'Howard Zinn', 'Harper Perennial'),
('978-0-19-280551-1', 'The Guns of August', 'History', 7.00, 'yes', 'Barbara W. Tuchman', 'Oxford University Press'),
('978-0-307-58837-1', 'Sapiens: A Brief History of Humankind', 'History', 8.00, 'no', 'Yuval Noah Harari', 'Harper Perennial'),
('978-0-375-41398-8', 'The Diary of a Young Girl', 'History', 6.50, 'no', 'Anne Frank', 'Bantam'),
('978-0-14-044930-3', 'The Histories', 'History', 5.50, 'yes', 'Herodotus', 'Penguin Classics'),
('978-0-393-91257-8', 'Guns, Germs, and Steel: The Fates of Human Societies', 'History', 7.00, 'yes', 'Jared Diamond', 'W. W. Norton & Company'),
('978-0-7432-7357-1', '1491: New Revelations of the Americas Before Columbus', 'History', 6.50, 'no', 'Charles C. Mann', 'Vintage Books'),
('978-0-679-64115-3', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-143951-8', 'Pride and Prejudice', 'Classic', 5.00, 'yes', 'Jane Austen', 'Penguin Classics'),
('978-0-452-28240-7', 'Brave New World', 'Dystopian', 6.50, 'yes', 'Aldous Huxley', 'Harper Perennial'),
('978-0-670-81302-4', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Knopf'),
('978-0-385-33312-0', 'The Shining', 'Horror', 6.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52993-5', 'Fahrenheit 451', 'Dystopian', 5.50, 'yes', 'Ray Bradbury', 'Ballantine Books'),
('978-0-345-39180-3', 'Dune', 'Science Fiction', 8.50, 'yes', 'Frank Herbert', 'Ace'),
('978-0-375-50167-0', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Vintage'),
('978-0-06-025492-6', 'Where the Wild Things Are', 'Children', 3.50, 'yes', 'Maurice Sendak', 'HarperCollins'),
('978-0-06-112241-5', 'The Kite Runner', 'Fiction', 5.50, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
('978-0-06-440055-8', 'Charlotte''s Web', 'Children', 4.00, 'yes', 'E.B. White', 'Harper & Row'),
('978-0-679-77644-3', 'Beloved', 'Fiction', 6.50, 'yes', 'Toni Morrison', 'Knopf'),
('978-0-14-027526-3', 'A Tale of Two Cities', 'Classic', 4.50, 'yes', 'Charles Dickens', 'Penguin Books'),
('978-0-7434-7679-3', 'The Stand', 'Horror', 7.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52994-2', 'Moby Dick', 'Classic', 6.50, 'yes', 'Herman Melville', 'Penguin Books'),
('978-0-06-112008-4', 'To Kill a Mockingbird', 'Classic', 5.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-553-57340-1', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-7432-4722-5', 'Angels & Demons', 'Mystery', 7.50, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-7432-7356-4', 'The Hobbit', 'Fantasy', 7.00, 'yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt');


-- inserting into issued table
INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');


-- inserting into return table
INSERT INTO return_status(return_id, issued_id, return_date) 
VALUES
('RS101', 'IS101', '2023-06-06'),
('RS102', 'IS105', '2023-06-07'),
('RS103', 'IS103', '2023-08-07'),
('RS104', 'IS106', '2024-05-01'),
('RS105', 'IS107', '2024-05-03'),
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
SELECT * FROM issued_status;


-- Project Tasks

-- CRUD Tasks

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 
-- 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Querying books to check the update
SELECT *
FROM books;

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '001 Main St'
WHERE member_id = 'C101';

SELECT *
FROM members;

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id = 'IS121'; 

SELECT * FROM issued_status;

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'
SELECT *
FROM issued_status 
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_member_id
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(1) > 1;

-- CTAS Tasks
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt.
CREATE TABLE book_issue_cnt AS
SELECT b.isbn,	
	b.book_title,
	COUNT(1) AS issue_count
FROM issued_status AS issue
JOIN books AS b
ON issue.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

-- Data Analysis Tasks
-- Task 7: Retrieve All Books in a Specific Category:
SELECT *
FROM books
WHERE category = 'Fiction';

-- Task 8: Find Total Rental Income by Category:
SELECT category,
	SUM(b.rental_price),
	COUNT(1) AS quantity_sold
FROM books AS b
JOIN issued_status AS issue ON b.isbn = issue.issued_book_isbn
GROUP BY category;

-- Task 9: List Members Who Registered in the Last 180 Days:
-- Select the current date as maxo of reg_date
SELECT *
FROM members
WHERE reg_date BETWEEN 
	(SELECT MAX(reg_date) - INTERVAL '180 days'
	FROM members)
	AND
	(SELECT MAX(reg_date)
	FROM members);

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT e1.emp_id,
	e1.emp_name,
	e2.emp_name,
	b.branch_id,
	b.branch_address,
	b.contact_no
FROM employees AS e1
JOIN branch as b ON e1.branch_id = b.branch_id
JOIN employees AS e2 ON b.manager_id = e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE expensive_books AS 
SELECT * 
FROM books
WHERE rental_price > 7.00;

-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT *
FROM books
WHERE book_title NOT IN (
	SELECT issued_book_name
	FROM issued_status 
	WHERE issued_id IN (SELECT issued_id FROM return_status)
	);

-- Advanced Data Analysis
-- Task 13: Identify Members with Overdue Books:
-- Write a query to identify members who have overdue books (assume a 30-day return period). 
-- Display the member's_id, member's name, book title, issue date, and days overdue.

-- Letting current date as '2024-05-20'
SELECT m.member_id,
	m.member_name,
	b.book_title,
	isd.issued_date,
	'2024-05-20' - (isd.issued_date + INTERVAL '30 days')  AS days_overdue
FROM issued_status AS isd
JOIN books AS b ON isd.issued_book_isbn = b.isbn
JOIN members AS m ON isd.issued_member_id = m.member_id
WHERE isd.issued_id NOT IN (SELECT issued_id FROM return_status)
AND '2024-05-20' > isd.issued_date + INTERVAL '30 days'
ORDER BY days_overdue;

-- Task 14: Update Book Status on Return
-- Write a query to update the status of books in the books table to "Yes" when they are returned 
-- (based on entries in the return_status table).

CREATE OR REPLACE PROCEDURE add_return_records(p_return_id VARCHAR(10), p_issued_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
	v_isbn	VARCHAR(50);
	v_book_title VARCHAR(200);
	
BEGIN
	INSERT INTO return_status(return_id, issued_id, return_date)
	VALUES (p_return_id, p_issued_id, CURRENT_DATE);

	SELECT issued_book_isbn,
		issued_book_name
		INTO 
		v_isbn,
		v_book_title
	FROM issued_status
	WHERE issued_id = p_issued_id;
	
	UPDATE books
	SET status = 'yes'
	WHERE isbn = v_isbn;

	RAISE NOTICE 'Thank you for returning the book: %', v_book_title;
	
END;
$$

-- TESTING FUNCTION
SELECT *
FROM issued_status;

SELECT *
FROM return_status
WHERE issued_id = 'IS140';

SELECT *
FROM books
WHERE isbn = '978-0-330-25864-8';

CALL add_return_records('RS119', 'IS140');

-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch,
-- showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

WITH emp_sales AS (
	SELECT e.emp_id,
		e.branch_id,
		COUNT(isd.issued_id) AS issued_books,
		COUNT(r.return_id) AS return_books,
		SUM(rental_price) AS rental_income
	FROM employees AS e
	LEFT JOIN issued_status AS isd ON e.emp_id = isd.issued_emp_id
	LEFT JOIN books AS b ON isd.issued_book_isbn = b.isbn
	LEFT JOIN return_status AS r ON isd.issued_id = r.issued_id 
	GROUP BY e.emp_id, e.branch_id
	)

SELECT br.branch_id,
	br.manager_id,
	br.branch_address,
	SUM(es.issued_books) AS num_books_issued,
	SUM(es.return_books) AS num_books_returned,
	SUM(es.rental_income) AS revenue_generated
FROM emp_sales AS es
JOIN branch AS br ON es.branch_id = br.branch_id
GROUP BY br.branch_id, br.manager_id, br.branch_address
ORDER BY revenue_generated DESC;

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
-- containing members who have issued at least one book in the last 2 months.
-- letting current date as '2024-05-20'

CREATE TABLE active_members AS 
SELECT DISTINCT(m.member_id),
	m.member_name,
	m.member_address,
	m.reg_date
FROM issued_status AS isd
JOIN members AS m ON isd.issued_member_id = m.member_id
WHERE issued_date BETWEEN '2024-05-20'::DATE - INTERVAL '2 months' AND '2024-05-20';


-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. 
-- Display the employee name, number of books processed, and their branch.

SELECT emp_id,
	issued_books,
	branch_id
FROM (
	SELECT e.emp_id,
		COUNT(isd.issued_id) AS issued_books,
		b.branch_id,
		DENSE_RANK() OVER(ORDER BY COUNT(isd.issued_id) DESC) AS rank
	FROM issued_status AS isd
	JOIN employees AS e ON isd.issued_emp_id = e.emp_id
	JOIN branch AS b on e.branch_id = b.branch_id
	GROUP BY e.emp_id, b.branch_id
	) AS emp_sales
WHERE rank < 4;

-- Task 18: Identify Members Issuing High-Risk Books
-- Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. 
-- Display the member name, book title, and the number of times they've issued damaged books.

WITH book_condition AS (
	SELECT isd.issued_book_isbn,
		rn.book_condition
	FROM issued_status AS isd
	INNER JOIN return_status AS rn ON isd.issued_id = rn.issued_id
	),
	
	issued_books_condition AS (
	SELECT m.member_name,
		isd.issued_book_name,
		CASE 
			WHEN bk.book_condition IS NULL THEN 'Good'
			ELSE bk.book_condition
		END AS book_condition,
		COUNT(1) AS num_of_books
	FROM issued_status AS isd
	LEFT JOIN book_condition AS bk ON isd.issued_book_isbn = bk.issued_book_isbn
	JOIN members AS m ON isd.issued_member_id = m.member_id
	GROUP BY m.member_name, isd.issued_book_name, book_condition
	)

SELECT *
FROM issued_books_condition
WHERE book_condition = 'Damaged' 
	AND num_of_books = 2;

-- Task 19: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. 
-- Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
-- The procedure should function as follows: The stored procedure should take the book_id as an input parameter. 
-- The procedure should first check if the book is available (status = 'yes'). 
-- If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 
-- If the book is not available (status = 'no'), 
-- the procedure should return an error message indicating that the book is currently not available.

CREATE OR REPLACE PROCEDURE issue_book(p_issued_id VARCHAR(10), p_issued_member_id VARCHAR(10), p_issued_book_isbn VARCHAR(50), 
p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
	v_book_status VARCHAR(10);
	v_book_title VARCHAR(200);
BEGIN
	SELECT status,
		book_title
		INTO 
		v_book_status,
		v_book_title
	FROM books
	WHERE isbn = p_issued_book_isbn;

	IF v_book_status = 'yes' THEN
		INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
		VALUES (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

		UPDATE books
			SET status = 'no'
		WHERE isbn = p_issued_book_isbn;

		RAISE NOTICE '% has been issued. Thank you.', v_book_title;

	ELSE 
		RAISE NOTICE 'Sorry, % is currently not available.', v_book_title;
	END IF;
	
END;
$$

-- Testing Function

SELECT * FROM books;
SELECT * FROM issued_status;

CALL issue_book('IS141', 'C108', '978-0-7432-7357-1', 'E105');

-- Task 20: Create Table As Select (CTAS) Objective: 
-- Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.
-- Description: Write a CTAS query to create a new table that lists each member 
-- and the books they have issued but not returned within 30 days. 
-- The table should include: The number of overdue books. 
-- The total fines, with each day's fine calculated at $0.50. 
-- The number of books issued by each member. The resulting table should show: Member ID, Number of overdue books, Total fines.

-- letting current date as 2024-06-05;
CREATE TABLE member_fines AS 
WITH books_overdue AS (
	SELECT member_id,
		isd.issued_id,
		CASE 
			WHEN r.return_id IS NULL THEN EXTRACT (DAY FROM (CAST('2024-06-05' AS DATE) - (isd.issued_date + INTERVAL '30 days')))
			ELSE r.return_date - isd.issued_date
		END AS days_overdue
	FROM issued_status AS isd
	LEFT JOIN return_status AS r ON isd.issued_id = r.issued_id 
	JOIN members AS m ON isd.issued_member_id = m.member_id
	)

SELECT member_id,
	COUNT(issued_id) AS number_of_overdue_books,
	SUM(days_overdue) * 0.50 AS total_fines
FROM books_overdue
GROUP BY member_id
ORDER BY total_fines DESC;
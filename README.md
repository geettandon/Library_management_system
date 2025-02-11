# Library Management System Using SQL Project

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It covers creating tables, executing CRUD operations, performing advanced SQL queries, and generating insights using CTAS queries.

## Objectives

1. **Database Setup:** Establish tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations:** Execute Create, Read, Update, and Delete operations on the data.
3. **Data Analysis:** Perform complex queries to analyze and retrieve data.
4. **CTAS (Create Table As Select):** Create tables based on query results for efficient reporting.

## Tasks and Solutions

### CRUD Operations

#### **Task 1: Create a New Book Record**
```sql
INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;
```

#### **Task 2: Update an Existing Member's Address**
```sql
UPDATE members
SET member_address = '001 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;
```

#### **Task 3: Delete a Record from the Issued Status Table**
```sql
DELETE FROM issued_status
WHERE issued_id = 'IS121';
SELECT * FROM issued_status;
```

#### **Task 4: Retrieve All Books Issued by a Specific Employee**
```sql
SELECT *
FROM issued_status
WHERE issued_emp_id = 'E101';
```

#### **Task 5: List Members Who Have Issued More Than One Book**
```sql
SELECT issued_member_id
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(1) > 1;
```

### CTAS (Create Table As Select) Tasks

#### **Task 6: Create Summary Table for Book Issues**
```sql
CREATE TABLE book_issue_cnt AS
SELECT b.isbn, b.book_title, COUNT(1) AS issue_count
FROM issued_status AS issue
JOIN books AS b ON issue.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;
```

#### **Task 11: Create Table of Expensive Books**
```sql
CREATE TABLE expensive_books AS
SELECT *
FROM books
WHERE rental_price > 7.00;
```

#### **Task 16: Create Table of Active Members (Last 2 Months)**
```sql
CREATE TABLE active_members AS
SELECT DISTINCT(m.member_id), m.member_name, m.member_address, m.reg_date
FROM issued_status AS isd
JOIN members AS m ON isd.issued_member_id = m.member_id
WHERE issued_date BETWEEN '2024-05-20'::DATE - INTERVAL '2 months' AND '2024-05-20';
```

#### **Task 20: Create Table for Overdue Books and Fines Calculation**
```sql
CREATE TABLE member_fines AS
WITH books_overdue AS (
    SELECT member_id, isd.issued_id,
           CASE WHEN r.return_id IS NULL THEN EXTRACT (DAY FROM (CAST('2024-06-05' AS DATE) - (isd.issued_date + INTERVAL '30 days')))
                ELSE r.return_date - isd.issued_date END AS days_overdue
    FROM issued_status AS isd
    LEFT JOIN return_status AS r ON isd.issued_id = r.issued_id
    JOIN members AS m ON isd.issued_member_id = m.member_id
)
SELECT member_id, COUNT(issued_id) AS number_of_overdue_books, SUM(days_overdue) * 0.50 AS total_fines
FROM books_overdue
GROUP BY member_id
ORDER BY total_fines DESC;
```

### Data Analysis Tasks

#### **Task 7: Retrieve All Books in a Specific Category**
```sql
SELECT *
FROM books
WHERE category = 'Fiction';
```

#### **Task 8: Find Total Rental Income by Category**
```sql
SELECT category, SUM(b.rental_price), COUNT(1) AS quantity_sold
FROM books AS b
JOIN issued_status AS issue ON b.isbn = issue.issued_book_isbn
GROUP BY category;
```

#### **Task 9: List Members Who Registered in the Last 180 Days**
```sql
SELECT *
FROM members
WHERE reg_date BETWEEN 
    (SELECT MAX(reg_date) - INTERVAL '180 days' FROM members) 
    AND (SELECT MAX(reg_date) FROM members);
```

#### **Task 10: List Employees with Their Branch Manager's Name**
```sql
SELECT e1.emp_id, e1.emp_name, e2.emp_name AS manager, b.branch_id, b.branch_address, b.contact_no
FROM employees AS e1
JOIN branch AS b ON e1.branch_id = b.branch_id
JOIN employees AS e2 ON b.manager_id = e2.emp_id;
```

#### **Task 12: Retrieve the List of Books Not Yet Returned**
```sql
SELECT *
FROM books
WHERE book_title NOT IN (
    SELECT issued_book_name
    FROM issued_status
    WHERE issued_id IN (SELECT issued_id FROM return_status)
);
```

#### **Task 13: Identify Members with Overdue Books**
```sql
SELECT m.member_id, m.member_name, b.book_title, isd.issued_date, '2024-05-20' - (isd.issued_date + INTERVAL '30 days') AS days_overdue
FROM issued_status AS isd
JOIN books AS b ON isd.issued_book_isbn = b.isbn
JOIN members AS m ON isd.issued_member_id = m.member_id
WHERE isd.issued_id NOT IN (SELECT issued_id FROM return_status)
AND '2024-05-20' > isd.issued_date + INTERVAL '30 days'
ORDER BY days_overdue;
```

#### **Task 15: Branch Performance Report**
```sql
WITH emp_sales AS (
    SELECT e.emp_id, e.branch_id, COUNT(isd.issued_id) AS issued_books,
           COUNT(r.return_id) AS return_books, SUM(rental_price) AS rental_income
    FROM employees AS e
    LEFT JOIN issued_status AS isd ON e.emp_id = isd.issued_emp_id
    LEFT JOIN books AS b ON isd.issued_book_isbn = b.isbn
    LEFT JOIN return_status AS r ON isd.issued_id = r.issued_id
    GROUP BY e.emp_id, e.branch_id
)
SELECT br.branch_id, br.manager_id, br.branch_address, SUM(es.issued_books) AS num_books_issued,
       SUM(es.return_books) AS num_books_returned, SUM(es.rental_income) AS revenue_generated
FROM emp_sales AS es
JOIN branch AS br ON es.branch_id = br.branch_id
GROUP BY br.branch_id, br.manager_id, br.branch_address
ORDER BY revenue_generated DESC;
```

#### **Task 17: Find Employees with the Most Book Issues Processed**
```sql
SELECT emp_id, issued_books, branch_id
FROM (
    SELECT e.emp_id, COUNT(isd.issued_id) AS issued_books, b.branch_id,
           DENSE_RANK() OVER(ORDER BY COUNT(isd.issued_id) DESC) AS rank
    FROM issued_status AS isd
    JOIN employees AS e ON isd.issued_emp_id = e.emp_id
    JOIN branch AS b ON e.branch_id = b.branch_id
    GROUP BY e.emp_id, b.branch_id
) AS emp_sales
WHERE rank < 4;
```

## Advanced Operations

#### **Task 14: Update Book Status on Return**
```sql
CREATE OR REPLACE PROCEDURE add_return_records(p_return_id VARCHAR(10), p_issued_id VARCHAR(10))
LANGUAGE plpgsql AS $$
DECLARE
    v_isbn VARCHAR(50);
    v_book_title VARCHAR(200);
BEGIN
    INSERT INTO return_status(return_id, issued_id, return_date)
    VALUES (p_return_id, p_issued_id, CURRENT_DATE);

    SELECT issued_book_isbn, issued_book_name INTO v_isbn, v_book_title
    FROM issued_status
    WHERE issued_id = p_issued_id;

    UPDATE books SET status = 'yes' WHERE isbn = v_isbn;
    RAISE NOTICE 'Thank you for returning the book: %', v_book_title;
END;
$$;
```

#### **Task 19: Manage Book Issuance Using Stored Procedure**
```sql
CREATE OR REPLACE PROCEDURE issue_book(p_issued_id VARCHAR(10), p_issued_member_id VARCHAR(10), p_issued_book_isbn VARCHAR(50), p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql AS $$
DECLARE
    v_book_status VARCHAR(10);
    v_book_title VARCHAR(200);
BEGIN
    SELECT status, book_title INTO v_book_status, v_book_title
    FROM books WHERE isbn = p_issued_book_isbn;

    IF v_book_status = 'yes' THEN
        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

        UPDATE books SET status = 'no' WHERE isbn = p_issued_book_isbn;
        RAISE NOTICE '% has been issued. Thank you.', v_book_title;
    ELSE
        RAISE NOTICE 'Sorry, % is currently not available.', v_book_title;
    END IF;
END;
$$;
```

## Conclusion
This project demonstrates the application of SQL for database management, data analysis, and reporting. It includes advanced concepts like CTAS, stored procedures, and real-world data queries for a comprehensive library management system.


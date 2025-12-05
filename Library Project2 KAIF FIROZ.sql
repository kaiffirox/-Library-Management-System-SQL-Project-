create database library_p2;
use library_p2;

-- Library Management Table 2
-- 1. Database Setup
-- Create table "Branch"
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15)
);


-- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
);


-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE
);



-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);



-- Create table "IssueStatus"
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
);



-- Create table "ReturnStatus"
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

-- Project Tasks

-- 2. CRUD Operations

-- Create: Inserted sample records into the books table.
-- Read: Retrieved and displayed data from various tables.
-- Update: Updated records in the employees table.
-- Delete: Removed records from the members table as needed.


-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
-- Task 2: Update an Existing Member's Address
-- Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.


-- 3. CTAS (Create Table As Select)
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt.


-- 4. Data Analysis & Findings
-- Task 7. Retrieve All Books in a Specific Category:
-- Task 8: Find Total Rental Income by Category:
-- Task 9: List Members Who Registered in the Last 180 Days:
-- Task 10: List Employees with Their Branch Manager's Name and their branch details:
-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
-- Task 12: Retrieve the List of Books Not Yet Returned

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')";

INSERT INTO BOOKS values (
"978-1-60129-456-2", "To Kill a Mockingbird", "Classic", "6.00", "yes", "Harper Lee", "J.B. Lippincott & Co."
);

-- Task 2: Update an Existing Member's Address

UPDATE members 
SET 
    member_address = '125 Oak St'
WHERE
    member_id = 'C103';

-- Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status 
WHERE
    issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT 
    *
FROM
    issued_status
WHERE
    issued_emp_id = 'E101';
    
-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
    issued_emp_id, COUNT(*) as no_of_issued
FROM
    issued_status
GROUP BY issued_emp_id
HAVING no_of_issued > 1;

-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt.

CREATE TABLE book_issued_cnt AS SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count FROM
    issued_status AS ist
        JOIN
    books AS b ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn , b.book_title;

-- Task 7. Retrieve All Books in a Specific Category:

SELECT 
    *
FROM
    books
WHERE
    category = 'Fantasy';
    
-- Task 8: Find Total Rental Income by Category:

SELECT 
    b.category, SUM(b.rental_price) AS rental_PRICE
FROM
    issued_status AS ist
        JOIN
    books AS b ON b.isbn = ist.issued_book_isbn
GROUP BY b.category;

-- Task 9: List Members Who Registered in the Last 180 Days:

SELECT *
FROM members
WHERE reg_date >= CURDATE() - INTERVAL 180 DAY;

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e.emp_name, b.*, e2.emp_name AS manager
FROM
    branch AS b
        JOIN
    employees AS e ON b.branch_id = e.branch_id
        JOIN
    employees AS e2 ON e2.emp_id = b.manager_id;
    
-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:

CREATE TABLE EXPENSIVE_BOOKS AS
							SELECT * FROM
							books
							WHERE
							rental_price > 7.00;
                            
-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT 
    *
FROM
    issued_status AS ist
        LEFT JOIN
    return_status AS rs ON rs.issued_id = ist.issued_id
WHERE
    rs.return_id IS NULL;				
    
-- Advanced SQL Operations
/*
-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.
-- Task 14: Update Book Status on Return
-- Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
-- Task 18: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. The procedure should first check if the book is available (status = 'yes'). 
-- If the book is available, it should be issued, and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
-- Task 19: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

-- Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include: The number of overdue books. The total fines, with each day's fine calculated at $0.50. The number of books issued by each member. The resulting table should show: Member ID Number of overdue books Total fines
*/
-- SOLUTION
/*
-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period).
-- Display the member's_id, member's name, book title, issue date, and days overdue.
*/

SELECT 
    m.member_id,
    m.member_name,
    b.book_title,
    ist.issued_date,
    CURDATE() - ist.issued_date AS days_overdue
FROM
    members AS m
        JOIN
    issued_status AS ist ON m.member_id = ist.issued_member_id
        JOIN
    books AS b ON b.isbn = ist.issued_book_isbn
        LEFT JOIN
    return_status AS rs ON rs.issued_id = ist.issued_id
WHERE
    rs.return_date IS NULL
        AND (CURRENT_DATE() - ist.issued_date) > 30
ORDER BY 1;

-- 
/*
Task 14: Update Book Status on Return
-- Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/


DELIMITER $$

CREATE PROCEDURE add_return_records(
    IN p_return_id VARCHAR(10),
    IN p_issued_id VARCHAR(10)
)
BEGIN
    DECLARE v_isbn VARCHAR(50);
    DECLARE v_book_name VARCHAR(80);

    -- Insert into return_status
    INSERT INTO return_status(return_id, issued_id, return_date)
    VALUES (p_return_id, p_issued_id, CURDATE());

    -- Fetch ISBN and book name
    SELECT issued_book_isbn, issued_book_name
    INTO v_isbn, v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

    -- Update book status
    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    -- MySQL equivalent of output message
    SELECT CONCAT('Thank you for returning the book: ', v_book_name) AS message;

END $$

DELIMITER ;

/*
-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/

DROP TABLE IF EXISTS branch_performance;

CREATE TABLE branch_performance AS
SELECT 
    CONCAT(BR.branch_id, ' - ', BR.branch_address) AS branch_info,
    COUNT(IST.issued_id) AS total_issued,
    COUNT(RS.return_id) AS total_returned,
    SUM(BK.rental_price) AS total_revenue
FROM branch AS BR
JOIN employees AS E ON BR.branch_id = E.branch_id
JOIN issued_status AS IST ON IST.issued_emp_id = E.emp_id
LEFT JOIN return_status AS RS ON RS.issued_id = IST.issued_id
JOIN books AS BK ON BK.isbn = IST.issued_book_isbn
GROUP BY BR.branch_id, BR.branch_address;


/*
-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
*/

DROP TABLE IF EXISTS active_members;

CREATE TABLE active_members AS
SELECT *
FROM members
WHERE member_id IN (
    SELECT DISTINCT issued_member_id
    FROM issued_status
    WHERE issued_date >= CURRENT_DATE() - INTERVAL 2 MONTH
);

SELECT * FROM active_members;


-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

SELECT 
    e.emp_name,
    b.*,
    COUNT(ist.issued_id) as no_book_issued
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
GROUP BY 1, 2
LIMIT 3;

-- Task 18: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. The procedure should first check if the book is available (status = 'yes'). 
-- If the book is available, it should be issued, and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.

DROP PROCEDURE IF EXISTS issue_book;
DELIMITER $$

CREATE PROCEDURE issue_book(
    IN p_issued_id VARCHAR(10),
    IN p_issued_member_id VARCHAR(30),
    IN p_issued_book_isbn VARCHAR(30),
    IN p_issued_emp_id VARCHAR(10)
)
BEGIN
    DECLARE v_status VARCHAR(10);

    -- 1. Check book availability
    SELECT status INTO v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    -- 2. If book is available (yes)
    IF v_status = 'yes' THEN
        
        INSERT INTO issued_status(
            issued_id,
            issued_member_id,
            issued_date,
            issued_book_isbn,
            issued_emp_id
        )
        VALUES (
            p_issued_id,
            p_issued_member_id,
            CURDATE(),
            p_issued_book_isbn,
            p_issued_emp_id
        );

        -- Update book status → not available
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        -- MySQL does NOT support RAISE NOTICE → use SELECT
        SELECT CONCAT('Book issued successfully. Book ISBN: ', p_issued_book_isbn) AS message;

    ELSE
        -- Book not available
        SELECT CONCAT('ERROR: Book is not available. ISBN: ', p_issued_book_isbn) AS message;
    END IF;

END $$

DELIMITER ;

-- Test available book:
CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');

-- Test unavailable book:
CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');

-- Verify change:
SELECT * FROM books WHERE isbn = '978-0-375-41398-8';

/*
Task 19: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.
Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. 
The table should include: The number of overdue books. The total fines, with each day's fine calculated at $0.50. The number of books issued by each member. 
The resulting table should show: Member ID Number of overdue books Total fines
*/

DROP TABLE IF EXISTS overdue_summary;

CREATE TABLE overdue_summary AS
SELECT 
    m.member_id,
    
    -- Total books issued by member
    COUNT(ist.issued_id) AS total_issued,
    
    -- Count overdue books
    SUM(
        CASE 
            WHEN rs.return_id IS NULL 
                 AND ist.issued_date < CURDATE() - INTERVAL 30 DAY
            THEN 1 ELSE 0 
        END
    ) AS overdue_books,
    
    -- Total fine = overdue days × 0.50
    SUM(
        CASE 
            WHEN rs.return_id IS NULL 
                 AND ist.issued_date < CURDATE() - INTERVAL 30 DAY
            THEN 
                DATEDIFF(CURDATE(), ist.issued_date) - 30
            ELSE 0
        END
    ) * 0.50 AS total_fine

FROM 
    members m
JOIN 
    issued_status ist ON m.member_id = ist.issued_member_id
LEFT JOIN
    return_status rs ON ist.issued_id = rs.issued_id

GROUP BY 
    m.member_id;

SELECT * FROM members WHERE member_id = "C105"


-- LIBRARY STORE ANALYSIS PROJECT - KAIF-FIROZ 
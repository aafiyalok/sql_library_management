SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;

--Project tasks--

--CRUD operations--
--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"--

Insert into books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

--Task-2 ask 2: Update an Existing Member's Address--
--Update set where--

UPDATE members
SET member_address='130 Main St'
WHERE member_id = 'C101';

SELECT * FROM members;

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.--

DELETE FROM issued_status
WHERE issued_id = 'IS121';
SELECT * FROM issued_status


--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.--
SELECT * FROM issued_status
WHERE issued_emp_id='E101';

--Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.--
SELECT 
	issued_member_id
	--count(issued_id) as total_books
	
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(issued_id)>1;

--CTAS- Create Table As Selected--
--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results -
--each book and total book_issued_cnt**
select * from books;
select* from issued_status

CREATE TABLE issued_book_count
AS
select 
	b.isbn,
	b.book_title,
	count(st.issued_id)
FROM books as b
JOIN issued_status as st
ON b.isbn = st.issued_book_isbn
GROUP BY b.isbn

SELECT * FROM issued_book_count

--Create table of books whose status is yes--
drop table if exists available ;
CREATE TABLE available
AS
SELECT book_title,
	rental_price,
	status
FROM books
WHERE status='yes';

SELECT * FROM available;

--DATA Analysis and Findings--
--Task 7: Retrieve all books from a specific category

SELECT * FROM books
WHERE category='Fiction' OR category='Mystery';

--Task 8: Find Total Rental Income by Category:
SELECT 
	b.category,
	SUM(b.rental_price),
	COUNT(*)
FROM books AS b
JOIN issued_status AS ist
ON b.isbn = ist.issued_book_isbn
GROUP BY 1;

--Task 9:List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 DAYS'

--List Employees with Their Branch Manager's Name and their branch details:

SELECT 
	e.*,
	e1.emp_name AS manager_name,
	b.manager_id
FROM employees AS e
JOIN branch AS b
ON e.branch_id=b.branch_id
JOIN employees AS e1
ON b.manager_id=e1.emp_id

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold
DROP TABLE IF EXISTS high_price ;
CREATE TABLE high_price
	AS
	SELECT * FROM books
	WHERE rental_price > 7;

SELECT * FROM high_price;

--Task 12: Retrieve the List of Books Not Yet Returned

SELECT ist.issued_book_isbn 
	from issued_status as ist
	LEFT JOIN return_status as rst
	ON ist.issued_id=rst.issued_id
	WHERE rst.return_id is null;
select * from return_status;
	
	







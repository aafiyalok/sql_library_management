--library management system 

--creating branch table
drop table if exists branch;
create table branch(
	branch_id varchar(10) primary key,	
	manager_id	varchar(10),
	branch_address	varchar(50),
	contact_no varchar(10)
);

ALTER TABLE branch
ALTER COLUMN contact_no TYPE VARCHAR(25);

--creating table employees

drop table if exists employees;
create table employees(
	emp_id	varchar(10) PRIMARY KEY,
	emp_name varchar(20),
	position varchar(20),
	salary	int,
	branch_id varchar(10)

)

--CREATING BOOKS TABLE

drop table if exists books;
create table books(
	isbn varchar(20) primary key,	
	book_title varchar(75),	
	category varchar(15),	
	rental_price float,	
	status varchar(5),	
	author varchar(35),	
	publisher varchar(30)
);
ALTER TABLE BOOKS
ALTER COLUMN category TYPE VARCHAR(25);

--creating the issued_status table

drop table if exists issued_status;
create table issued_status(
	issued_id varchar(10) primary key,	
	issued_member_id varchar(10),	
	issued_book_name varchar(75),	
	issued_date	date,
	issued_book_isbn varchar(15),	
	issued_emp_id varchar(15)

);
ALTER TABLE issued_status
ALTER COLUMN issued_book_isbn TYPE VARCHAR(30);

--creating table members

drop table if exists members;
create table members(
	member_id varchar(20) primary key,	
	member_name varchar(30),	
	member_address varchar(70),	
	reg_date date
);

--creating table return status

drop table if exists return_status;
create table return_status(
	return_id varchar(10) primary key,	
	issued_id varchar(15),	
	return_book_name varchar(50),	
	return_date date,	
	return_book_isbn varchar(15)
);

--Adding foreign keys--
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id)

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

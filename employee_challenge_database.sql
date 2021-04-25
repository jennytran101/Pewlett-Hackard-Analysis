drop table if exists department;
drop table if exists dept_manager;
drop table if exists employees;
drop table if exists salaries;
drop table if exists titles;
drop table if exists dept_emp;

CREATE TABLE departments (
     dept_no VARCHAR,
     dept_name VARCHAR
);

CREATE TABLE dept_manager (
dept_no VARCHAR,
    emp_no INT,
    from_date DATE,
    to_date DATE
);

create table dept_emp(
	emp_no INT,
	dept_no VARCHAR ,
	from_date DATE,
	to_date DATE
);
	
create table Employees(
	emp_no INT,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
);

CREATE TABLE salaries (
  emp_no INT,
  salary INT,
  from_date DATE,
  to_date DATE
);


create table Titles(
	emp_no INT,
	title VARCHAR,
	from_date DATE,
	to_date DATE
);


Select * From departments;
Select * From dept_manager;
Select * From employees;
Select * From salaries;
Select * From titles;
Select * From dept_emp;

drop table if exists retirement;
select employees.emp_no, 
	 	employees.first_name,
		employees.last_name, 
		employees.birth_date,
		titles.title,
		titles.from_date,
		titles.to_date
INTO retirement		
		
from employees
inner join titles on employees.emp_no = titles.emp_no
where employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
order by employees.emp_no

select * from retirement;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement.emp_no) retirement.emp_no, retirement.first_name,
		retirement.last_name,retirement.title, retirement.from_date,
		retirement.to_date
INTO unique_titles
FROM retirement
ORDER BY retirement.emp_no, retirement.to_date DESC;

select * from unique_titles

drop table if exists retiring_titles; 
select unique_titles.title, count(unique_titles.emp_no)
INTO retiring_titles
from unique_titles
group by unique_titles.title
order by count(unique_titles.emp_no) DESC;
select * from retiring_titles


# DELIVERABLE 2
create table dept_emp(
	emp_no INT,
	dept_no VARCHAR,
	from_date DATE,
	to_date DATE
);
select * from dept_emp;
drop table if exists mentorship_eligibility;
select distinct on (employees.emp_no) employees.emp_no, employees.first_name, employees.last_name, employees.birth_date,
		dept_emp.from_date, dept_emp.to_date,
		titles.title

INTO mentorship_eligibility		
from employees
inner join dept_emp on employees.emp_no = dept_emp.emp_no
inner join titles on employees.emp_no = titles.emp_no
where (employees.birth_date BETWEEN 'January 1, 1965' AND 'December 31, 1965')
and (dept_emp.to_date = '9999-01-01')
ORDER BY employees.emp_no;

select * from mentorship_eligibility;

-- Create all tables 

CREATE TABLE departments (
  id SERIAL primary key,
	dept_no VARCHAR,
	dept_name VARCHAR
);

SELECT *
FROM departments;

CREATE TABLE dept_emp (
    id SERIAL primary key,
    emp_no INT,
    dept_no VARCHAR
);
SELECT * from dept_emp;


CREATE TABLE dept_manager (
    id SERIAL primary key,
    dept_no VARCHAR,
    emp_no INT
);
SELECT * from dept_manager;

CREATE TABLE employees (
    id SERIAL primary key,
    emp_no INT,
    emp_title_id VARCHAR,
    birth_date DATE,
    first_name VARCHAR,
    last_name VARCHAR,
    sex VARCHAR,
    hire_date DATE
);
SELECT * from employees;


CREATE TABLE salaries (
    id SERIAL primary key,
    emp_no INT,
    salary INT
);
SELECT * from salaries;

CREATE TABLE titles (
    id SERIAL primary key,
    title_id VARCHAR,
    title VARCHAR
);
SELECT * from titles;

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM employees
INNER JOIN salaries ON
employees.emp_no=salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date from employees where
(hire_date BETWEEN '1986-01-01'AND '1986-12-31') 

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first na
SELECT departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM employees
INNER JOIN dept_manager as managers ON
employees.emp_no=managers.emp_no
INNER JOIN departments ON departments.dept_no=managers.dept_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON departments.dept_no=dept_emp.dept_no

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex from employees where first_name='Hercules' AND last_name LIKE 'B%'

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON departments.dept_no=dept_emp.dept_no WHERE departments.dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON departments.dept_no=dept_emp.dept_no WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT
  last_name,
  COUNT(*) AS count_emp_last_names
FROM
  employees
GROUP BY
  last_name
  ORDER BY count_emp_last_names DESC;
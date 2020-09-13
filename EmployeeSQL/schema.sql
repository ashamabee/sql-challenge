-- Adding Tables
CREATE TABLE employees (
    emp_no INTEGER NOT NULL PRIMARY KEY,
    emp_title VARCHAR(30) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    sex VARCHAR(30) NOT NULL,
    hire_date DATE NOT NULL
);
CREATE TABLE departments (
    dept_no VARCHAR(30) NOT NULL PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL
);
CREATE TABLE dept_manager (
    dept_no VARCHAR(30) NOT NULL,
    emp_no INTEGER NOT NULL PRIMARY KEY,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(30) NOT NULL,
	PRIMARY KEY (emp_no,dept_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
CREATE TABLE titles (
    title_id VARCHAR(30) NOT NULL PRIMARY KEY,
    title VARCHAR(30) NOT NULL
);
CREATE TABLE salaries (
    emp_no INTEGER NOT NULL PRIMARY KEY,
    salary INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
-- Add foreign key to employee table
ALTER TABLE employees
ADD FOREIGN KEY (emp_title) REFERENCES titles(title_id);
-- View data
SELECT * FROM dept_manager;
-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no = s.emp_no;
-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;
-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
---- THERE ARE MORE THAN ONE MANAGER PER DEPARTMENT
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager AS dm
       JOIN employees AS e ON dm.emp_no = e.emp_no      
       JOIN departments AS d ON dm.dept_no = d.dept_no;
-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
       JOIN dept_emp AS de ON de.emp_no = e.emp_no      
       JOIN departments AS d ON de.dept_no = d.dept_no;
-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
       JOIN dept_emp AS de ON de.emp_no = e.emp_no      
       JOIN departments AS d ON de.dept_no = d.dept_no
	   WHERE d.dept_name = 'Sales';
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
       JOIN dept_emp AS de ON de.emp_no = e.emp_no      
       JOIN departments AS d ON de.dept_no = d.dept_no
	   WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';
-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT last_name,COUNT(*) as count 
FROM employees 
GROUP BY last_name 
ORDER BY count DESC;
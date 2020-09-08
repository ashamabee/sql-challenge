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
CREATE TABLE "salaries" (
    "emp_no" INTEGER NOT NULL PRIMARY KEY,
    "salary" INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
-- Add foreign key to employee table
ALTER TABLE employees
ADD FOREIGN KEY (emp_title) REFERENCES titles(title_id);

-- When I tried to import the employee data, I got this error:
-- ERROR:  insert or update on table "employees" violates foreign key constraint "employees_emp_title_fkey"
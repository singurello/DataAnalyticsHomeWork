-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


-- TO CHECK IF THE DATA WAS SUCCESSFULLY EXPORTED INTO DATABASE

SELECT * FROM departments LIMIT 3
SELECT * FROM dept_emp LIMIT 3
SELECT * FROM dept_manager LIMIT 3
SELECT * FROM employees LIMIT 3
SELECT * FROM salaries LIMIT 3
SELECT * FROM titles LIMIT 3

-- DATA ANLYSIS -- 

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees JOIN salaries ON employees.emp_no=salaries.emp_no

-- List employees who were hired in 1986.
SELECT * FROM employees WHERE 
hire_date >= '1986-01-01' AND hire_date <= '1986-12-31'

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT 
departments.dept_no, departments.dept_name,
employees.emp_no, employees.first_name, employees.last_name,
dept_manager.from_date, dept_manager.to_date
FROM departments JOIN dept_manager ON departments.dept_no=dept_manager.dept_no
JOIN employees ON dept_manager.emp_no=employees.emp_no

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees JOIN dept_emp ON employees.emp_no=dept_emp.emp_no 
JOIN departments ON dept_emp.dept_no = departments.dept_no

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees WHERE first_name='Hercules' AND last_name LIKE 'B%'

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM departments JOIN dept_manager ON departments.dept_no=dept_manager.dept_no
JOIN employees ON dept_manager.emp_no=employees.emp_no
WHERE departments.dept_name='Sales'

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM departments JOIN dept_manager ON departments.dept_no=dept_manager.dept_no
JOIN employees ON dept_manager.emp_no=employees.emp_no
WHERE departments.dept_name='Sales' OR departments.dept_name='Development'

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) as Frequency
FROM employees GROUP BY last_name
ORDER BY Frequency DESC


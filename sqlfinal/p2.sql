'''Create a database
1. employee (employee name, street, city) ,employee name is primary key
2. works (employee name, company name, salary)
3. company (company name, city) ,company name is primary key
4. manages (employee name, manager name)
Give an expression in SQL for each of the following queries.
1. Find the names of all employees who work for First Bank Corporation.
2. Find all employees who do not work for First Bank Coorporation
3. Find the company that has most employees.
4. Find all companies located in every in which small bank corporation is located
5. Find details of employee having salary greater than 10,000.
6. Update salary of all employees who work for First Bank Corporation by 10%.
7. Find employee and their managers.
8. Find the names, street and cities of all employees who work for First Bank
Corporation and earn more than 10,000.
9. Find those companies whose employees earn a higher salary,on average, than th
average salary at First Bank Corporation
Sure, let's create the tables, insert some sample data, and then provide queries based on the tables and data.

1. Create the "employee" table and insert sample data:

```sql
-- Create the employee table
CREATE TABLE employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

-- Insert sample data into the employee table
INSERT INTO employee (employee_name, street, city)
VALUES
    ('John Smith', '123 Main St', 'New York'),
    ('Alice Johnson', '456 Elm St', 'Los Angeles'),
    ('Bob Davis', '789 Oak St', 'Chicago'),
    ('Eva Wilson', '101 Pine St', 'San Francisco');
```

2. Create the "works" table and insert sample data:

```sql
-- Create the works table
CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_name, company_name)
);

-- Insert sample data into the works table
INSERT INTO works (employee_name, company_name, salary)
VALUES
    ('John Smith', 'First Bank Corporation', 12000.00),
    ('Alice Johnson', 'First Bank Corporation', 10500.00),
    ('Bob Davis', 'Second Bank Corp', 11000.00),
    ('Eva Wilson', 'Third Bank Inc', 13000.00),
    ('Alice Johnson', 'Fourth Corp', 9500.00);
```

3. Create the "company" table and insert sample data:

```sql
-- Create the company table
CREATE TABLE company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Insert sample data into the company table
INSERT INTO company (company_name, city)
VALUES
    ('First Bank Corporation', 'New York'),
    ('Second Bank Corp', 'Los Angeles'),
    ('Third Bank Inc', 'Chicago'),
    ('Fourth Corp', 'San Francisco');
```

4. Create the "manages" table and insert sample data (for manager-employee relationships):

```sql
-- Create the manages table
CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name, manager_name)
);

-- Insert sample data into the manages table
INSERT INTO manages (employee_name, manager_name)
VALUES
    ('John Smith', 'Alice Johnson'),
    ('Bob Davis', 'Alice Johnson'),
    ('Eva Wilson', 'Alice Johnson');
```

Now that we have created the tables and inserted sample data, let's proceed with the queries:

1. Find the names of all employees who work for "First Bank Corporation":

```sql
SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation';
```

2. Find all employees who do not work for "First Bank Corporation":

```sql
SELECT e.employee_name
FROM employee e
LEFT JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name IS NULL OR w.company_name <> 'First Bank Corporation';
```

3. Find the company that has the most employees:

```sql
SELECT company_name
FROM works
GROUP BY company_name
HAVING COUNT(*) = (SELECT MAX(emp_count) FROM (SELECT COUNT(*) AS emp_count FROM works GROUP BY company_name) AS counts);
```

4. Find all companies located in every city in which "Small Bank Corporation" is located (assuming "Small Bank Corporation" is not in the provided data):

```sql
SELECT DISTINCT w1.company_name
FROM works w1
WHERE NOT EXISTS (
  SELECT c.city
  FROM company c
  WHERE c.company_name = 'Small Bank Corporation'
  EXCEPT
  SELECT c.city
  FROM company c
  WHERE c.company_name = w1.company_name
);
```

5. Find details of employees having a salary greater than 10,000:

```sql
SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.salary > 10000;
```

6. Update the salary of all employees who work for "First Bank Corporation" by 10%:

```sql
UPDATE works
SET salary = salary * 1.10
WHERE company_name = 'First Bank Corporation';
```

7. Find employees and their managers:

```sql
SELECT e.employee_name, m.manager_name
FROM manages m
RIGHT JOIN employee e ON e.employee_name = m.employee_name;
```

8. Find the names, street, and cities of all employees who work for "First Bank Corporation" and earn more than 10,000:

```sql
SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation' AND w.salary > 10000;
```

9. Find companies whose employees earn a higher salary, on average, than the average salary at "First Bank Corporation":

```sql
SELECT w.company_name
FROM works w
GROUP BY w.company_name
HAVING AVG(w.salary) > (SELECT AVG(salary) FROM works WHERE company_name = 'First Bank Corporation');
```

You can execute these SQL queries to retrieve the desired information from the tables with the sample data.

Please make sure to adjust the SQL statements to match the specifics of your database system if needed.

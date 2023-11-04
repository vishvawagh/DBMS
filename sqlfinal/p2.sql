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

'''
1. **Create Tables:**

```sql
-- Create the 'employee' table
CREATE TABLE employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50)
);

-- Create the 'works' table
CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10, 2),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES company(company_name)
);

-- Create the 'company' table
CREATE TABLE company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Create the 'manages' table
CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
);
```

2. **Queries by number:**

Query 1: Find the names of all employees who work for 'First Bank Corporation'.
```sql
SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation';
```

Query 2: Find all employees who do not work for 'First Bank Corporation'.
```sql
SELECT e.employee_name
FROM employee e
LEFT JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name IS NULL OR w.company_name <> 'First Bank Corporation';
```

Query 3: Find the company that has the most employees.
```sql
SELECT company_name
FROM (
    SELECT company_name, COUNT(employee_name) AS num_employees
    FROM works
    GROUP BY company_name
    ORDER BY num_employees DESC
    LIMIT 1
);
```

Query 4: Find all companies located in every city where 'Small Bank Corporation' is located.
```sql
SELECT DISTINCT c1.company_name
FROM company c1
WHERE NOT EXISTS (
    SELECT c2.city
    FROM company c2
    WHERE c2.company_name = 'Small Bank Corporation'
    EXCEPT
    SELECT c3.city
    FROM company c3
    WHERE c3.company_name = c1.company_name
);
```

Query 5: Find details of employees with a salary greater than 10,000.
```sql
SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.salary > 10000;
```

Query 6: Update the salary of all employees who work for 'First Bank Corporation' by 10%.
```sql
UPDATE works
SET salary = salary * 1.10
WHERE company_name = 'First Bank Corporation';
```

Query 7: Find employee and their managers.
```sql
SELECT m.employee_name, m.manager_name
FROM manages m;
```

Query 8: Find the names, street, and cities of all employees who work for 'First Bank Corporation' and earn more than 10,000.
```sql
SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation' AND w.salary > 10000;
```

Query 9: Find those companies whose employees earn a higher salary, on average, than the average salary at 'First Bank Corporation'.
```sql
SELECT w.company_name
FROM works w
GROUP BY w.company_name
HAVING AVG(w.salary) > (
    SELECT AVG(salary)
    FROM works
    WHERE company_name = 'First Bank Corporation'
);
```

Please make sure to adjust the SQL statements to match the specifics of your database system if needed.
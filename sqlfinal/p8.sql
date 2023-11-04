'''Consider the following database
Employee(emp_no,name,skill,pay-rate) eno primary key
Position(posting_no,skill) posting_no primary key
Duty_allocation(posting_no,emp_no,day,shift)
Find the SQL queries for the following:
1. Get the duty allocation details for emp_no 123461 for the month of April 1986.
2. Find the shift details for Employee ‘xyz’
3. Get employees whose rate of pay is more than or equal to the rate of pay of employee ‘xyz’
4. Get the names and pay rates of employees with emp_no less than 123460 whose rate of pay is
more than the rate of pay of at least one employee with emp_no greater than or equal to 123460.
5. Find the names of employees who are assigned to all positions that require a Chef’s skill
6 .Find the employees with the lowest pay rate
7 .Get the employee numbers of all employees working on at least two dates.
8 .Get a list of names of employees with the skill of Chef who are assigned a duty
9 .Get a list of employees not assigned a duty
10.Get a count of different employees on each shift
'''
To solve these queries based on the given database structure, we will first create the tables, insert sample data, and then provide the SQL queries for each scenario:

1. Create the tables and insert sample data:

```sql
-- Create the Employee table
CREATE TABLE Employee (
    emp_no INT PRIMARY KEY,
    name VARCHAR(100),
    skill VARCHAR(50),
    pay_rate DECIMAL(10, 2)
);

-- Insert sample data into the Employee table
INSERT INTO Employee (emp_no, name, skill, pay_rate)
VALUES
    (123459, 'John', 'Chef', 25.00),
    (123460, 'Alice', 'Chef', 27.00),
    (123461, 'Bob', 'Waiter', 20.00),
    (123462, 'Eva', 'Chef', 28.00),
    (123463, 'Mia', 'Waiter', 21.00);

-- Create the Position table
CREATE TABLE Position (
    posting_no INT PRIMARY KEY,
    skill VARCHAR(50)
);

-- Insert sample data into the Position table
INSERT INTO Position (posting_no, skill)
VALUES
    (1, 'Chef'),
    (2, 'Waiter'),
    (3, 'Manager'),
    (4, 'Bartender');

-- Create the Duty_Allocation table
CREATE TABLE Duty_Allocation (
    posting_no INT,
    emp_no INT,
    day DATE,
    shift INT
);

-- Insert sample data into the Duty_Allocation table
INSERT INTO Duty_Allocation (posting_no, emp_no, day, shift)
VALUES
    (1, 123459, '1986-04-01', 1),
    (1, 123459, '1986-04-02', 2),
    (1, 123460, '1986-04-01', 1),
    (2, 123461, '1986-04-01', 2),
    (2, 123461, '1986-04-02', 1),
    (2, 123462, '1986-04-01', 2),
    (3, 123459, '1986-04-03', 1),
    (3, 123460, '1986-04-03', 1),
    (3, 123461, '1986-04-03', 2),
    (4, 123459, '1986-04-04', 1);

-- Insert more data for testing
INSERT INTO Duty_Allocation (posting_no, emp_no, day, shift)
VALUES
    (1, 123459, '1986-04-03', 2),
    (1, 123459, '1986-04-04', 1),
    (1, 123460, '1986-04-03', 2),
    (1, 123460, '1986-04-04', 1),
    (1, 123461, '1986-04-04', 1);
```

Now that you've created the tables and inserted sample data, you can proceed with the SQL queries:

1. Get the duty allocation details for emp_no 123461 for the month of April 1986:

```sql
SELECT posting_no, day, shift
FROM Duty_Allocation
WHERE emp_no = 123461 AND DATEPART(YEAR, day) = 1986 AND DATEPART(MONTH, day) = 4;
```

2. Find the shift details for Employee 'xyz':

```sql
SELECT emp_no, day, shift
FROM Duty_Allocation
WHERE emp_no = (SELECT emp_no FROM Employee WHERE name = 'xyz');
```

3. Get employees whose rate of pay is more than or equal to the rate of pay of employee 'xyz':

```sql
SELECT emp_no, name, pay_rate
FROM Employee
WHERE pay_rate >= (SELECT pay_rate FROM Employee WHERE name = 'xyz');
```

4. Get the names and pay rates of employees with emp_no less than 123460 whose rate of pay is more than the rate of pay of at least one employee with emp_no greater than or equal to 123460:

```sql
SELECT name, pay_rate
FROM Employee
WHERE emp_no < 123460 AND pay_rate > ANY (SELECT pay_rate FROM Employee WHERE emp_no >= 123460);
```

5. Find the names of employees who are assigned to all positions that require a Chef's skill:

```sql
SELECT name
FROM Employee
WHERE skill = 'Chef'
GROUP BY name
HAVING COUNT(DISTINCT emp_no) = (SELECT COUNT(*) FROM Position WHERE skill = 'Chef');
```

6. Find the employees with the lowest pay rate:

```sql
SELECT emp_no, name, pay_rate
FROM Employee
WHERE pay_rate = (SELECT MIN(pay_rate) FROM Employee);
```

7. Get the employee numbers of all employees working on at least two dates:

```sql
SELECT emp_no
FROM Duty_Allocation
GROUP BY emp_no
HAVING COUNT(DISTINCT day) >= 2;
```

8. Get a list of names of employees with the skill of Chef who are assigned a duty:

```sql
SELECT DISTINCT E.name
FROM Employee E
INNER JOIN Duty_Allocation D ON E.emp_no = D.emp_no
WHERE E.skill = 'Chef';
```

9. Get a list of employees not assigned a duty:

```sql
SELECT E.emp_no, E.name
FROM Employee E
WHERE E.emp_no NOT IN (SELECT DISTINCT emp_no FROM Duty_Allocation);
```

10. Get a count of different employees on each shift:

```sql
SELECT shift, COUNT(DISTINCT emp_no) AS EmployeeCount
FROM Duty_Allocation
GROUP BY shift;
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios.

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
Certainly! Here are SQL queries for the specified questions based on the provided database:

1. **Create Tables:**

```sql
-- Create the 'Employee' table
CREATE TABLE Employee (
    emp_no INT PRIMARY KEY,
    name VARCHAR(50),
    skill VARCHAR(50),
    pay_rate DECIMAL(10, 2)
);

-- Create the 'Position' table
CREATE TABLE Position (
    posting_no INT PRIMARY KEY,
    skill VARCHAR(50)
);

-- Create the 'Duty_Allocation' table
CREATE TABLE Duty_Allocation (
    posting_no INT,
    emp_no INT,
    day DATE,
    shift VARCHAR(20)
);
```

2. **Queries by number:**

Query 1: Get the duty allocation details for `emp_no` 123461 for the month of April 1986.
```sql
SELECT *
FROM Duty_Allocation
WHERE emp_no = 123461
    AND MONTH(day) = 4
    AND YEAR(day) = 1986;
```

Query 2: Find the shift details for Employee 'xyz'.
```sql
SELECT day, shift
FROM Duty_Allocation
WHERE emp_no = (SELECT emp_no FROM Employee WHERE name = 'xyz');
```

Query 3: Get employees whose rate of pay is more than or equal to the rate of pay of Employee 'xyz'.
```sql
SELECT name
FROM Employee
WHERE pay_rate >= (SELECT pay_rate FROM Employee WHERE name = 'xyz');
```

Query 4: Get the names and pay rates of employees with `emp_no` less than 123460 whose rate of pay is more than the rate of pay of at least one employee with `emp_no` greater than or equal to 123460.
```sql
SELECT name, pay_rate
FROM Employee
WHERE emp_no < 123460
    AND pay_rate > (SELECT MAX(pay_rate) FROM Employee WHERE emp_no >= 123460);
```

Query 5: Find the names of employees who are assigned to all positions that require a Chef’s skill.
```sql
SELECT E.name
FROM Employee AS E
WHERE NOT EXISTS (
    SELECT P.skill
    FROM Position AS P
    WHERE P.skill = 'Chef'
    EXCEPT
    SELECT D.skill
    FROM Duty_Allocation AS D
    WHERE D.emp_no = E.emp_no
);
```

Query 6: Find the employees with the lowest pay rate.
```sql
SELECT name
FROM Employee
WHERE pay_rate = (SELECT MIN(pay_rate) FROM Employee);
```

Query 7: Get the employee numbers of all employees working on at least two dates.
```sql
SELECT emp_no
FROM Duty_Allocation
GROUP BY emp_no
HAVING COUNT(DISTINCT day) >= 2;
```

Query 8: Get a list of names of employees with the skill of Chef who are assigned a duty.
```sql
SELECT E.name
FROM Employee AS E
WHERE E.skill = 'Chef'
    AND E.emp_no IN (SELECT DISTINCT D.emp_no FROM Duty_Allocation AS D);
```

Query 9: Get a list of employees not assigned a duty.
```sql
SELECT E.name
FROM Employee AS E
WHERE NOT EXISTS (
    SELECT emp_no
    FROM Duty_Allocation AS D
    WHERE D.emp_no = E.emp_no
);
```

Query 10: Get a count of different employees on each shift.
```sql
SELECT shift, COUNT(DISTINCT emp_no) AS EmployeeCount
FROM Duty_Allocation
GROUP BY shift;
```

These SQL queries should help you retrieve the requested information from the database. Adjust the table and column names if they differ from the examples provided.
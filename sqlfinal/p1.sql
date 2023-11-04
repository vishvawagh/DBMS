'''Create a db called company consist of the following tables.
1.Emp (eno,ename, job,hiredate,salary,commission,deptno,)
2.dept(deptno,deptname,location)
eno is primary key in emp
deptno is primary key in dept
Solve Queries by SQL
1. List the maximum salary paid to salesman
2. List name of emp whose name start with ‘I’
3. List details of emp who have joined before ’30-sept-81’
4. List the emp details in the descending order of their basic salary
5. List of no. of emp & avg salary for emp in the dept no ‘20’
6. List the avg salary, minimum salary of the emp hiredatewise for dept no ‘10’.
7. List emp name and its department
8. List total salary paid to each department
9. List details of employee working in ‘Dev’ department
10. Update salary of all employees in deptno 10 by 5 %.'''
-- Insert data into the "Dept" table
INSERT INTO Dept (deptno, deptname, location)
VALUES
  (10, 'HR', 'New York'),
  (20, 'Sales', 'Chicago'),
  (30, 'Development', 'San Francisco');

-- Insert data into the "Emp" table
INSERT INTO Emp (eno, ename, job, hiredate, salary, commission, deptno)
VALUES
  (1, 'John', 'Manager', TO_DATE('1980-12-17', 'YYYY-MM-DD'), 5000, NULL, 10),
  (2, 'Anna', 'Manager', TO_DATE('1981-02-20', 'YYYY-MM-DD'), 5500, NULL, 20),
  (3, 'Mike', 'Salesman', TO_DATE('1981-05-10', 'YYYY-MM-DD'), 3000, 500, 20),
  (4, 'Isabel', 'Salesman', TO_DATE('1982-03-15', 'YYYY-MM-DD'), 3200, 200, 20),
  (5, 'Robert', 'Clerk', TO_DATE('1980-09-25', 'YYYY-MM-DD'), 2000, NULL, 10),
  (6, 'Linda', 'Analyst', TO_DATE('1981-09-30', 'YYYY-MM-DD'), 4000, NULL, 30),
  (7, 'Eric', 'Clerk', TO_DATE('1982-11-05', 'YYYY-MM-DD'), 2200, NULL, 10);

1. **Create the `Emp` and `Dept` tables:**

```sql
-- Create the 'Dept' table
CREATE TABLE Dept (
    deptno INT PRIMARY KEY,
    deptname VARCHAR(50),
    location VARCHAR(50)
);

-- Create the 'Emp' table with foreign key reference to 'Dept' table
CREATE TABLE Emp (
    eno INT PRIMARY KEY,
    ename VARCHAR(50),
    job VARCHAR(50),
    hiredate DATE,
    salary DECIMAL(10, 2),
    commission DECIMAL(10, 2),
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES Dept(deptno)
);
```

2. **Queries by number:**

Query 1: List the maximum salary paid to salesmen.
```sql
SELECT MAX(salary)
FROM Emp
WHERE job = 'salesman';
```

Query 2: List names of employees whose names start with 'I'.
```sql
SELECT ename
FROM Emp
WHERE ename LIKE 'I%';
```

Query 3: List details of employees who joined before '30-Sept-81'.
```sql
SELECT *
FROM Emp
WHERE hiredate < DATE '1981-09-30';
```

Query 4: List employee details in descending order of their basic salary.
```sql
SELECT *
FROM Emp
ORDER BY salary DESC;
```

Query 5: List the number of employees and the average salary for employees in department number '20'.
```sql
SELECT COUNT(eno) AS num_employees, AVG(salary) AS avg_salary
FROM Emp
WHERE deptno = 20;
```

Query 6: List the average salary and minimum salary of employees hiredate-wise for department number '10'.
```sql
SELECT hiredate, AVG(salary) AS avg_salary, MIN(salary) AS min_salary
FROM Emp
WHERE deptno = 10
GROUP BY hiredate;
```

Query 7: List employee names and their respective departments.
```sql
SELECT e.ename, d.deptname
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno;
```

Query 8: List the total salary paid to each department.
```sql
SELECT d.deptname, SUM(e.salary) AS total_salary
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno
GROUP BY d.deptname;
```

Query 9: List details of employees working in the 'Dev' department.
```sql
SELECT *
FROM Emp
WHERE deptno = (SELECT deptno FROM Dept WHERE deptname = 'Dev');
```

Query 10: Update the salary of all employees in department number '10' by 5%.
```sql
UPDATE Emp
SET salary = salary * 1.05
WHERE deptno = 10;
```


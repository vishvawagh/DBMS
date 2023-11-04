'''
Consider the following database
Project(project_id,proj_name,chief_arch) , project_id is primary key
Employee(Emp_id,Emp_name) , Emp_id is primary key
Assigned-To(Project_id,Emp_id)
Find the SQL queries for the following:
1. Get the details of employees working on project C353
2. Get employee number of employees working on project C353
3. Obtain details of employees working on Database project
4. Get details of employees working on both C353 and C354
5. Get employee numbers of employees who do not work on project C453
'''


1. **Create Tables:**

```sql
-- Create the 'Project' table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    proj_name VARCHAR(50),
    chief_arch INT,
    FOREIGN KEY (chief_arch) REFERENCES Employee(Emp_id)
);

-- Create the 'Employee' table
CREATE TABLE Employee (
    Emp_id INT PRIMARY KEY,
    Emp_name VARCHAR(50)
);

-- Create the 'Assigned-To' table
CREATE TABLE Assigned_To (
    Project_id INT,
    Emp_id INT,
    FOREIGN KEY (Project_id) REFERENCES Project(project_id),
    FOREIGN KEY (Emp_id) REFERENCES Employee(Emp_id)
);
```

2. **Queries by number:**

Query 1: Get the details of employees working on project C353.
```sql
SELECT E.*
FROM Employee AS E
JOIN Assigned_To AS A ON E.Emp_id = A.Emp_id
JOIN Project AS P ON A.Project_id = P.project_id
WHERE P.proj_name = 'C353';
```

Query 2: Get employee numbers of employees working on project C353.
```sql
SELECT E.Emp_id
FROM Employee AS E
JOIN Assigned_To AS A ON E.Emp_id = A.Emp_id
JOIN Project AS P ON A.Project_id = P.project_id
WHERE P.proj_name = 'C353';
```

Query 3: Obtain details of employees working on the 'Database' project.
```sql
SELECT E.*
FROM Employee AS E
JOIN Assigned_To AS A ON E.Emp_id = A.Emp_id
JOIN Project AS P ON A.Project_id = P.project_id
WHERE P.proj_name = 'Database';
```

Query 4: Get details of employees working on both 'C353' and 'C354'.
```sql
SELECT E.*
FROM Employee AS E
WHERE E.Emp_id IN (
    SELECT A1.Emp_id
    FROM Assigned_To AS A1
    JOIN Project AS P1 ON A1.Project_id = P1.project_id
    WHERE P1.proj_name = 'C353'
) AND E.Emp_id IN (
    SELECT A2.Emp_id
    FROM Assigned_To AS A2
    JOIN Project AS P2 ON A2.Project_id = P2.project_id
    WHERE P2.proj_name = 'C354'
);
```

Query 5: Get employee numbers of employees who do not work on project C453.
```sql
SELECT E.Emp_id
FROM Employee AS E
WHERE E.Emp_id NOT IN (
    SELECT A.Emp_id
    FROM Assigned_To AS A
    JOIN Project AS P ON A.Project_id = P.project_id
    WHERE P.proj_name = 'C453'
);
```

These SQL queries should help you retrieve the requested information from the database. Adjust the table and column names if they differ from the examples provided.
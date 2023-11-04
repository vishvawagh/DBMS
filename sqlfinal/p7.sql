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

To solve the queries based on the given database structure, we will first create the tables, insert sample data, and then provide the SQL queries for each scenario:

1. Create the tables and insert sample data:

```sql
-- Create the Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    proj_name VARCHAR(100),
    chief_arch INT
);

-- Insert sample data into the Project table
INSERT INTO Project (project_id, proj_name, chief_arch)
VALUES
    (C353, 'Project C353', 101),
    (C354, 'Project C354', 102),
    (DB, 'Database Project', 103);

-- Create the Employee table
CREATE TABLE Employee (
    Emp_id INT PRIMARY KEY,
    Emp_name VARCHAR(100)
);

-- Insert sample data into the Employee table
INSERT INTO Employee (Emp_id, Emp_name)
VALUES
    (101, 'John Smith'),
    (102, 'Alice Johnson'),
    (103, 'Bob Davis'),
    (104, 'Eva Wilson');

-- Create the Assigned-To table
CREATE TABLE Assigned_To (
    Project_id INT,
    Emp_id INT
);

-- Insert sample data into the Assigned-To table
INSERT INTO Assigned_To (Project_id, Emp_id)
VALUES
    (C353, 101),
    (C353, 102),
    (C354, 102),
    (DB, 103);
```

Now that you've created the tables and inserted sample data, you can proceed with the SQL queries:

1. Get the details of employees working on project C353:

```sql
SELECT E.Emp_id, E.Emp_name
FROM Employee E
INNER JOIN Assigned_To A ON E.Emp_id = A.Emp_id
WHERE A.Project_id = 'C353';
```

2. Get employee numbers of employees working on project C353:

```sql
SELECT E.Emp_id
FROM Employee E
INNER JOIN Assigned_To A ON E.Emp_id = A.Emp_id
WHERE A.Project_id = 'C353';
```

3. Obtain details of employees working on the Database project:

```sql
SELECT E.Emp_id, E.Emp_name
FROM Employee E
INNER JOIN Assigned_To A ON E.Emp_id = A.Emp_id
WHERE A.Project_id = 'DB';
```

4. Get details of employees working on both C353 and C354:

```sql
SELECT E.Emp_id, E.Emp_name
FROM Employee E
WHERE E.Emp_id IN (
    SELECT A.Emp_id
    FROM Assigned_To A
    WHERE A.Project_id = 'C353'
)
AND E.Emp_id IN (
    SELECT A.Emp_id
    FROM Assigned_To A
    WHERE A.Project_id = 'C354'
);
```

5. Get employee numbers of employees who do not work on project C453:

```sql
SELECT E.Emp_id
FROM Employee E
WHERE E.Emp_id NOT IN (
    SELECT A.Emp_id
    FROM Assigned_To A
    WHERE A.Project_id = 'C453'
);
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios.

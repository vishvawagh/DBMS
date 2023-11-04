'''
Create the following tables. Solve queries by SQL
• Deposit (actno,cname,bname,amount,adate)
• Branch (bname,city)
• Customers (cname, city)
• Borrow(loanno,cname,bname, amount)
Add primary key and foreign key wherever applicable.
Insert data into the above created tables.
a. Display account date of customers Anil.
b. Modify the size of attribute of amount in deposit
c. Display names of customers living in city pune.
d. Display name of the city where branch KAROLBAGH is located.
e. Find the number of tuples in the customer relation
f. Delete all the record of customers Sunil
g. Create a view on deposit table.
'''
To solve these queries, we will first create the tables, add primary keys and foreign keys where applicable, insert sample data, and then provide the SQL queries for each scenario:

1. Create the tables:

```sql
-- Create the Deposit table
CREATE TABLE Deposit (
    actno INT PRIMARY KEY,
    cname VARCHAR(100),
    bname VARCHAR(100),
    amount DECIMAL(10, 2),
    adate DATE
);

-- Create the Branch table
CREATE TABLE Branch (
    bname VARCHAR(100) PRIMARY KEY,
    city VARCHAR(100)
);

-- Create the Customers table
CREATE TABLE Customers (
    cname VARCHAR(100) PRIMARY KEY,
    city VARCHAR(100)
);

-- Create the Borrow table
CREATE TABLE Borrow (
    loanno INT PRIMARY KEY,
    cname VARCHAR(100),
    bname VARCHAR(100),
    amount DECIMAL(10, 2),
    FOREIGN KEY (cname) REFERENCES Customers(cname),
    FOREIGN KEY (bname) REFERENCES Branch(bname)
);

-- Insert sample data into the tables
INSERT INTO Deposit (actno, cname, bname, amount, adate)
VALUES
    (1, 'John', 'Perryridge', 4500.00, '1996-04-15'),
    (2, 'Alice', 'Brighton', 6000.00, '1997-02-20'),
    (3, 'Eva', 'Perryridge', 3800.00, '1996-05-05'),
    (4, 'Bob', 'Brighton', 7000.00, '1997-01-25'),
    (5, 'Anil', 'Brighton', 5500.00, '1997-03-15');

INSERT INTO Branch (bname, city)
VALUES
    ('Perryridge', 'New York'),
    ('Brighton', 'New York');

INSERT INTO Customers (cname, city)
VALUES
    ('John', 'New York'),
    ('Alice', 'New York'),
    ('Eva', 'New York'),
    ('Bob', 'New York'),
    ('Anil', 'New York');

INSERT INTO Borrow (loanno, cname, bname, amount)
VALUES
    (101, 'John', 'Perryridge', 3000.00),
    (102, 'Alice', 'Brighton', 4000.00),
    (103, 'Eva', 'Perryridge', 2500.00),
    (104, 'Bob', 'Brighton', 3500.00),
    (105, 'Anil', 'Brighton', 2800.00);
```

Now that you've created the tables, added primary keys and foreign keys, and inserted sample data, you can proceed with the SQL queries:

a. Display the account date of customers named Anil:

```sql
SELECT adate
FROM Deposit
WHERE cname = 'Anil';
```

b. Modify the size of the amount attribute in Deposit:

```sql
ALTER TABLE Deposit
ALTER COLUMN amount DECIMAL(12, 2);
```

c. Display names of customers living in the city 'Pune' (assuming 'Pune' is one of the city values):

```sql
SELECT cname
FROM Customers
WHERE city = 'Pune';
```

d. Display the name of the city where the branch 'KAROLBAGH' is located:

```sql
SELECT city
FROM Branch
WHERE bname = 'KAROLBAGH';
```

e. Find the number of tuples (rows) in the Customers relation:

```sql
SELECT COUNT(*) AS TotalCustomers
FROM Customers;
```

f. Delete all the records of customers named 'Sunil' (assuming 'Sunil' exists in the Customers table):

```sql
DELETE FROM Customers
WHERE cname = 'Sunil';
```

g. Create a view on the Deposit table:

```sql
CREATE VIEW DepositView AS
SELECT actno, cname, bname, amount, adate
FROM Deposit;
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios, including modifying the table structure and creating a view.

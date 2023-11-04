'''
Create the following tables. And Solve following queries by SQL
• Deposit (actno,cname,bname,amount,adate)
• Branch (bname,city)
• Customers (cname, city)
• Borrow(loanno,cname,bname, amount)
Add primary key and foreign key wherever applicable.
Insert data into the above created tables.
1. Display names of depositors having amount greater than 4000.
2. Display account date of customers Anil
3. Display account no. and deposit amount of customers having account opened
between dates 1-12-96 and 1-5-97
4. Find the average account balance at the Perryridge branch.
5. Find the names of all branches where the average account balance is more
than $1,200.
6. Delete depositors having deposit less than 5000
7. Create a view on deposit table.
'''
To solve the queries, we will first create the tables, add primary keys and foreign keys where applicable, insert sample data, and then provide the SQL queries for each scenario:

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
    (1, 'Anil', 'Perryridge', 4500.00, '1996-10-15'),
    (2, 'John', 'Brighton', 6000.00, '1997-03-20'),
    (3, 'Eva', 'Perryridge', 3800.00, '1996-11-05'),
    (4, 'Alice', 'Brighton', 7000.00, '1997-04-25'),
    (5, 'Bob', 'Brighton', 5500.00, '1997-01-15');

INSERT INTO Branch (bname, city)
VALUES
    ('Perryridge', 'New York'),
    ('Brighton', 'New York');

INSERT INTO Customers (cname, city)
VALUES
    ('Anil', 'New York'),
    ('John', 'New York'),
    ('Eva', 'New York'),
    ('Alice', 'New York'),
    ('Bob', 'New York');

INSERT INTO Borrow (loanno, cname, bname, amount)
VALUES
    (101, 'Anil', 'Perryridge', 3000.00),
    (102, 'John', 'Brighton', 4000.00),
    (103, 'Eva', 'Perryridge', 2500.00),
    (104, 'Alice', 'Brighton', 3500.00),
    (105, 'Bob', 'Brighton', 2800.00);
```

Now that you've created the tables, added primary keys and foreign keys, and inserted sample data, you can proceed with the SQL queries:

1. Display names of depositors having an amount greater than 4000:

```sql
SELECT cname
FROM Deposit
WHERE amount > 4000;
```

2. Display account date of customers named Anil:

```sql
SELECT actno, adate
FROM Deposit
WHERE cname = 'Anil';
```

3. Display account no. and deposit amount of customers having accounts opened between dates '1996-12-01' and '1997-05-01':

```sql
SELECT actno, amount
FROM Deposit
WHERE adate BETWEEN '1996-12-01' AND '1997-05-01';
```

4. Find the average account balance at the Perryridge branch:

```sql
SELECT AVG(amount) AS AverageBalance
FROM Deposit
WHERE bname = 'Perryridge';
```

5. Find the names of all branches where the average account balance is more than $1,200:

```sql
SELECT bname
FROM Deposit
GROUP BY bname
HAVING AVG(amount) > 1200;
```

6. Delete depositors having deposits less than 5000:

```sql
DELETE FROM Deposit
WHERE amount < 5000;
```

7. Create a view on the Deposit table:

```sql
CREATE VIEW DepositView AS
SELECT actno, cname, bname, amount, adate
FROM Deposit;
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios, including creating a view on the Deposit table.

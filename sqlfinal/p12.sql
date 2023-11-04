'''Create the following tables. Solve queries by SQL
• Deposit (actno,cname,bname,amount,adate)
• Branch (bname,city)
• Customers (cname, city)
• Borrow(loanno,cname,bname, amount)
Add primary key and foreign key wherever applicable.
Insert data into the above created tables.
Solve following queries by SQL
1. Display customer name having living city Bombay and branch city Nagpur
2. Display customer name having same living city as their branch city
3. Display customer name who are borrowers as well as depositors and having
living city Nagpur.
4. Display borrower names having deposit amount greater than 1000 and loan
amount greater than 2000
5. Display customer name living in the city where branch of depositor sunil is
located.
6. Create an index on deposit table'''
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

1. Display customer names living in the city 'Bombay' and branch city 'Nagpur':

```sql
SELECT C.cname
FROM Customers C
JOIN Branch B ON C.city = 'Bombay' AND B.city = 'Nagpur';
```

2. Display customer names having the same living city as their branch city:

```sql
SELECT C.cname
FROM Customers C
JOIN Branch B ON C.city = B.city;
```

3. Display customer names who are both borrowers and depositors and have a living city of 'Nagpur':

```sql
SELECT DISTINCT C.cname
FROM Customers C
JOIN Deposit D ON C.cname = D.cname
JOIN Borrow B ON C.cname = B.cname
WHERE C.city = 'Nagpur';
```

4. Display borrower names having a deposit amount greater than 1000 and a loan amount greater than 2000:

```sql
SELECT DISTINCT B.cname
FROM Borrow B
WHERE B.amount > 2000
AND B.cname IN (
    SELECT D.cname
    FROM Deposit D
    WHERE D.amount > 1000
);
```

5. Display customer names living in the city where the branch of depositor 'Sunil' is located:

```sql
SELECT C.cname
FROM Customers C
WHERE C.city = (SELECT B.city FROM Branch B WHERE B.bname = (SELECT D.bname FROM Deposit D WHERE D.cname = 'Sunil'));
```

6. Create an index on the Deposit table:

```sql
CREATE INDEX idx_amount ON Deposit(amount);
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios, including creating an index.

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

1. **Create Tables with Primary and Foreign Keys:**

```sql
-- Create the 'Deposit' table
CREATE TABLE Deposit (
    actno INT PRIMARY KEY,
    cname VARCHAR(50),
    bname VARCHAR(50),
    amount DECIMAL(10, 2),
    adate DATE,
    FOREIGN KEY (cname) REFERENCES Customers(cname),
    FOREIGN KEY (bname) REFERENCES Branch(bname)
);

-- Create the 'Branch' table
CREATE TABLE Branch (
    bname VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Create the 'Customers' table
CREATE TABLE Customers (
    cname VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Create the 'Borrow' table (assumed, as it's mentioned in the queries)
CREATE TABLE Borrow (
    loanno INT PRIMARY KEY,
    cname VARCHAR(50),
    bname VARCHAR(50),
    amount DECIMAL(10, 2),
    FOREIGN KEY (cname) REFERENCES Customers(cname),
    FOREIGN KEY (bname) REFERENCES Branch(bname)
);
```

2. **Insert Data into the Tables:**

```sql
-- Insert data into the 'Branch' table
INSERT INTO Branch (bname, city)
VALUES
    ('Perryridge', 'New York'),
    ('Redwood', 'Palo Alto'),
    ('Brighton', 'Boston');

-- Insert data into the 'Customers' table
INSERT INTO Customers (cname, city)
VALUES
    ('Anil', 'New York'),
    ('Bob', 'Palo Alto'),
    ('Cathy', 'Boston');

-- Insert data into the 'Deposit' table
INSERT INTO Deposit (actno, cname, bname, amount, adate)
VALUES
    (1001, 'Anil', 'Perryridge', 5000.00, '1996-03-01'),
    (1002, 'Anil', 'Redwood', 3500.00, '1996-04-15'),
    (1003, 'Bob', 'Perryridge', 2000.00, '1997-01-12'),
    (1004, 'Cathy', 'Brighton', 4500.00, '1996-11-05');
```

3. **Queries by number:**

Query 1: Display names of depositors having an amount greater than 4000.
```sql
SELECT cname
FROM Deposit
WHERE amount > 4000;
```

Query 2: Display account dates of customers named Anil.
```sql
SELECT actno, adate
FROM Deposit
WHERE cname = 'Anil';
```

Query 3: Display account numbers and deposit amounts of customers having accounts opened between dates '1996-01-12' and '1997-05-01'.
```sql
SELECT actno, amount
FROM Deposit
WHERE adate BETWEEN '1996-01-12' AND '1997-05-01';
```

Query 4: Find the average account balance at the Perryridge branch.
```sql
SELECT AVG(amount) AS AverageBalance
FROM Deposit
WHERE bname = 'Perryridge';
```

Query 5: Find the names of all branches where the average account balance is more than $1,200.
```sql
SELECT bname
FROM Deposit
GROUP BY bname
HAVING AVG(amount) > 1200;
```

Query 6: Delete depositors having a deposit less than 5000.
```sql
DELETE FROM Deposit
WHERE amount < 5000;
```

Query 7: Create a view on the 'Deposit' table.
```sql
CREATE VIEW DepositView AS
SELECT actno, cname, bname, amount, adate
FROM Deposit;
```

You can now query the `DepositView` as if it were a table to simplify your future queries.

These SQL queries and table creations should help you get the desired results. Make sure to adjust table and column names if they differ from the examples provided.
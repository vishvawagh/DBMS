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
Here are the SQL table creations and queries based on your requirements:

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

-- Create the 'Borrow' table
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
    ('Brighton', 'Bombay'),
    ('Redwood', 'Pune');

-- Insert data into the 'Customers' table
INSERT INTO Customers (cname, city)
VALUES
    ('Anil', 'Pune'),
    ('Bob', 'New York'),
    ('Cathy', 'Bombay');

-- Insert data into the 'Deposit' table
INSERT INTO Deposit (actno, cname, bname, amount, adate)
VALUES
    (1001, 'Anil', 'Perryridge', 5000.00, '1996-03-01'),
    (1002, 'Anil', 'Redwood', 3500.00, '1996-04-15'),
    (1003, 'Bob', 'Perryridge', 2000.00, '1997-01-12'),
    (1004, 'Cathy', 'Brighton', 4500.00, '1996-11-05');

-- Insert data into the 'Borrow' table (assuming data is available)
-- You can add data as needed for this table.
```

3. **Queries by letter:**

a. Display names of all branches located in the city of Bombay.
```sql
SELECT bname
FROM Branch
WHERE city = 'Bombay';
```

b. Display account numbers and amounts of depositors.
```sql
SELECT actno, amount
FROM Deposit;
```

c. Update the city of customer 'Anil' from Pune to Mumbai.
```sql
UPDATE Customers
SET city = 'Mumbai'
WHERE cname = 'Anil';
```

d. Find the number of depositors in the bank.
```sql
SELECT COUNT(DISTINCT cname) AS NumberOfDepositors
FROM Deposit;
```

e. Calculate the minimum and maximum amount of customers.
```sql
SELECT MIN(amount) AS MinAmount, MAX(amount) AS MaxAmount
FROM Deposit;
```

f. Create an index on the 'Deposit' table.
```sql
CREATE INDEX idx_amount ON Deposit(amount);
```

g. Create a view on the 'Borrow' table.
```sql
CREATE VIEW BorrowView AS
SELECT loanno, cname, bname, amount
FROM Borrow;
```

You can now query the `BorrowView` as if it were a table to simplify your future queries.


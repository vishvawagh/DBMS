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
    ('Redwood', 'Pune'),
    ('Nagpur', 'Nagpur');

-- Insert data into the 'Customers' table
INSERT INTO Customers (cname, city)
VALUES
    ('Anil', 'Pune'),
    ('Bob', 'New York'),
    ('Cathy', 'Bombay'),
    ('Sunil', 'Nagpur');

-- Insert data into the 'Deposit' table
INSERT INTO Deposit (actno, cname, bname, amount, adate)
VALUES
    (1001, 'Anil', 'Perryridge', 5000.00, '1996-03-01'),
    (1002, 'Anil', 'Redwood', 3500.00, '1996-04-15'),
    (1003, 'Bob', 'Perryridge', 2000.00, '1997-01-12'),
    (1004, 'Cathy', 'Brighton', 4500.00, '1996-11-05'),
    (1005, 'Sunil', 'Nagpur', 3000.00, '1996-06-20');

-- Insert data into the 'Borrow' table (assuming data is available)
-- You can add data as needed for this table.
```

3. **Queries by number:**

Query 1: Display customer names living in Bombay and having their branch city as Nagpur.
```sql
SELECT c.cname
FROM Customers AS c
JOIN Branch AS b ON c.city = 'Bombay' AND b.city = 'Nagpur' AND c.cname = b.bname;
```

Query 2: Display customer names having the same living city as their branch city.
```sql
SELECT c.cname
FROM Customers AS c
JOIN Branch AS b ON c.city = b.city AND c.cname = b.bname;
```

Query 3: Display customer names who are both borrowers and depositors and live in Nagpur.
```sql
SELECT DISTINCT c.cname
FROM Customers AS c
WHERE c.cname IN (SELECT cname FROM Borrow)
AND c.cname IN (SELECT cname FROM Deposit)
AND c.city = 'Nagpur';
```

Query 4: Display borrower names having deposit amounts greater than 1000 and loan amounts greater than 2000.
```sql
SELECT DISTINCT bo.cname
FROM Borrow AS bo
JOIN Deposit AS de ON bo.cname = de.cname
WHERE de.amount > 1000
AND bo.amount > 2000;
```

Query 5: Display customer names living in the city where the branch of depositor 'Sunil' is located.
```sql
SELECT c.cname
FROM Customers AS c
JOIN Deposit AS d ON c.city = (SELECT city FROM Branch WHERE bname = d.bname AND c.cname = 'Sunil');
```

Query 6: Create an index on the 'Deposit' table.
```sql
CREATE INDEX idx_amount ON Deposit(amount);
```


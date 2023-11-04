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
    ('Cathy', 'Bombay'),
    ('Sunil', 'Pune');

-- Insert data into the 'Deposit' table
INSERT INTO Deposit (actno, cname, bname, amount, adate)
VALUES
    (1001, 'Anil', 'Perryridge', 5000.00, '1996-03-01'),
    (1002, 'Anil', 'Redwood', 3500.00, '1996-04-15'),
    (1003, 'Bob', 'Perryridge', 2000.00, '1997-01-12'),
    (1004, 'Cathy', 'Brighton', 4500.00, '1996-11-05'),
    (1005, 'Sunil', 'Pune', 3000.00, '1996-06-20');

-- Insert data into the 'Borrow' table (assuming data is available)
-- You can add data as needed for this table.
```

3. **Queries by letter:**

a. Display account date of customers Anil.
```sql
SELECT adate
FROM Deposit
WHERE cname = 'Anil';
```

b. Modify the size of the 'amount' attribute in the 'Deposit' table.
To modify the size of the 'amount' attribute, you can use an `ALTER TABLE` statement, but it depends on your specific database system. For example, in MySQL:

```sql
ALTER TABLE Deposit
MODIFY COLUMN amount DECIMAL(12, 2);
```

c. Display names of customers living in the city of Pune.
```sql
SELECT cname
FROM Customers
WHERE city = 'Pune';
```

d. Display the name of the city where the branch 'KAROLBAGH' is located.
```sql
SELECT city
FROM Branch
WHERE bname = 'KAROLBAGH';
```

e. Find the number of tuples (rows) in the 'Customers' table.
```sql
SELECT COUNT(*) AS NumberOfTuples
FROM Customers;
```

f. Delete all the records of customers named Sunil.
```sql
DELETE FROM Customers
WHERE cname = 'Sunil';
```

g. Create a view on the 'Deposit' table.
```sql
CREATE VIEW DepositView AS
SELECT actno, cname, bname, amount, adate
FROM Deposit;
```

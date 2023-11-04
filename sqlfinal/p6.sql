'''
The following tables form part of a database held in a relational DBMS:
Hotel (HotelNo, Name, City)
Room (RoomNo, HotelNo, Type, Price)
Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo)
Guest (GuestNo, GuestName, GuestAddress)
Solve following queries by SQL
1. List full details of all hotels.
2. List full details of all hotels in London.
3. List all guests currently staying at the Grosvenor Hotel.
4. List the names and addresses of all guests in London, alphabetically ordered by name.
5. List the bookings for which no date_to has been specified.
6. How many hotels are there?
7. List the rooms that are currently unoccupied at the Grosvenor Hotel.
8. What is the lost income from unoccupied rooms at each hotel today?
9. Create index on one of the field and show is performance in query.
10. Create one view on above database and query it.
'''
To solve these queries, we'll start by creating the tables, inserting sample data, and then providing the SQL queries based on the given table structure. Here's how to create the tables, insert sample data, and execute the queries:

1. Create the tables and insert sample data:

```sql
-- Create the Hotel table
CREATE TABLE Hotel (
    HotelNo INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50)
);

-- Insert sample data into the Hotel table
INSERT INTO Hotel (HotelNo, Name, City)
VALUES
    (1, 'Grosvenor Hotel', 'London'),
    (2, 'Park Plaza', 'New York'),
    (3, 'Golden Gate Inn', 'San Francisco');

-- Create the Room table
CREATE TABLE Room (
    RoomNo INT PRIMARY KEY,
    HotelNo INT,
    Type VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Insert sample data into the Room table
INSERT INTO Room (RoomNo, HotelNo, Type, Price)
VALUES
    (101, 1, 'Single', 150.00),
    (102, 1, 'Double', 200.00),
    (201, 2, 'Single', 180.00),
    (202, 2, 'Double', 250.00),
    (301, 3, 'Single', 120.00),
    (302, 3, 'Double', 190.00);

-- Create the Booking table
CREATE TABLE Booking (
    HotelNo INT,
    GuestNo INT,
    DateFrom DATE,
    DateTo DATE,
    RoomNo INT
);

-- Insert sample data into the Booking table
INSERT INTO Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo)
VALUES
    (1, 101, '2023-11-01', '2023-11-05', 101),
    (1, 102, '2023-11-02', '2023-11-06', 102),
    (2, 201, '2023-11-03', '2023-11-07', 201),
    (2, 202, '2023-11-04', '2023-11-08', 202),
    (3, 301, '2023-11-05', '2023-11-09', 301),
    (3, 302, '2023-11-06', '2023-11-10', 302);

-- Create the Guest table
CREATE TABLE Guest (
    GuestNo INT PRIMARY KEY,
    GuestName VARCHAR(100),
    GuestAddress VARCHAR(100)
);

-- Insert sample data into the Guest table
INSERT INTO Guest (GuestNo, GuestName, GuestAddress)
VALUES
    (101, 'John Smith', '123 Main St, London'),
    (102, 'Alice Johnson', '456 Elm St, London'),
    (201, 'Bob Davis', '789 Oak St, New York'),
    (202, 'Eva Wilson', '101 Pine St, New York'),
    (301, 'Chris Robinson', '567 Market St, San Francisco'),
    (302, 'Mia Baker', '789 Oak St, San Francisco');
```

Now that you've created the tables and inserted sample data, you can proceed with the SQL queries:

1. List full details of all hotels:

```sql
SELECT *
FROM Hotel;
```

2. List full details of all hotels in London:

```sql
SELECT *
FROM Hotel
WHERE City = 'London';
```

3. List all guests currently staying at the Grosvenor Hotel:

```sql
SELECT G.GuestName
FROM Guest G
JOIN Booking B ON G.GuestNo = B.GuestNo
WHERE B.HotelNo = 1;
```

4. List the names and addresses of all guests in London, alphabetically ordered by name:

```sql
SELECT GuestName, GuestAddress
FROM Guest
WHERE GuestAddress LIKE '%London%'
ORDER BY GuestName;
```

5. List the bookings for which no `DateTo` has been specified:

```sql
SELECT *
FROM Booking
WHERE DateTo IS NULL;
```

6. How many hotels are there?

```sql
SELECT COUNT(*) AS HotelCount
FROM Hotel;
```

7. List the rooms that are currently unoccupied at the Grosvenor Hotel:

```sql
SELECT R.RoomNo
FROM Room R
LEFT JOIN Booking B ON R.RoomNo = B.RoomNo
WHERE R.HotelNo = 1 AND B.RoomNo IS NULL;
```

8. What is the lost income from unoccupied rooms at each hotel today?

```sql
SELECT H.Name AS HotelName, ISNULL(SUM(R.Price), 0) AS LostIncome
FROM Hotel H
LEFT JOIN Room R ON H.HotelNo = R.HotelNo
LEFT JOIN Booking B ON R.RoomNo = B.RoomNo
WHERE B.DateFrom = '2023-11-04' AND B.DateTo IS NULL
GROUP BY H.Name;
```

9. Create an index on one of the fields:

You can create an index on the `Hotel.City` field, for example:

```sql
CREATE INDEX IX_City ON Hotel (City);
```

10. Create one view on the above database and query it:

```sql
-- Create a view that combines information from Hotel, Room, Booking, and Guest
CREATE VIEW HotelInfo AS
SELECT H.HotelNo, H.Name AS HotelName, H.City, R.RoomNo, R.Type, R.Price,
       B.GuestNo, B.DateFrom, B.DateTo, G.GuestName, G.GuestAddress
FROM Hotel H
JOIN Room R ON H.HotelNo = R.HotelNo
LEFT JOIN Booking B ON R.RoomNo = B.RoomNo
LEFT JOIN Guest G ON B.GuestNo = G.GuestNo;

-- Query the view
SELECT *
FROM HotelInfo;
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios, including creating a view and querying it.

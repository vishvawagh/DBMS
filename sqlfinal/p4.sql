'''
4.The following tables form part of a database held in a relational DBMS:
Hotel (HotelNo, Name, City) HotelNo is primary key
Room (RoomNo, HotelNo, Type, Price)
Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo)
Guest (GuestNo, GuestName, GuestAddress) GuestNo is primary key
Solve following queries by SQL
1. What is the total revenue per night from all double rooms?
2. List the details of all rooms at the Grosvenor Hotel, including the name of
the guest staying in the room, if the room is occupied.
3. What is the average number of bookings for each hotel in April?
4. Create index on one of the field and show is performance in query.
5. List full details of all hotels.
6. List full details of all hotels in London.
7. Update the price of all rooms by 5%.
8. List the number of rooms in each hotel in London.
9. List all double or family rooms with a price below £40.00 per night, in
ascending order of price.  ,create table and queries number wise
'''
To solve these queries, let's start by creating the tables, inserting sample data, and then providing the SQL queries based on the given table structure. We'll address each query one by one:

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
    RoomNo INT,
    HotelNo INT,
    Type VARCHAR(50),
    Price DECIMAL(10, 2),
    PRIMARY KEY (HotelNo, RoomNo)
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
    RoomNo INT,
    PRIMARY KEY (HotelNo, GuestNo, DateFrom)
);

-- Insert sample data into the Booking table
INSERT INTO Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo)
VALUES
    (1, 101, '2023-04-01', '2023-04-05', 101),
    (1, 102, '2023-04-02', '2023-04-06', 102),
    (2, 201, '2023-04-03', '2023-04-07', 201),
    (2, 202, '2023-04-04', '2023-04-08', 202),
    (3, 301, '2023-04-05', '2023-04-09', 301),
    (3, 302, '2023-04-06', '2023-04-10', 302);

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

1. What is the total revenue per night from all double rooms?

```sql
SELECT SUM(Price) AS TotalRevenuePerNight
FROM Room
WHERE Type = 'Double';
```

2. List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the room is occupied.

```sql
SELECT R.*, G.GuestName
FROM Room R
LEFT JOIN Booking B ON R.HotelNo = B.HotelNo AND R.RoomNo = B.RoomNo
LEFT JOIN Guest G ON B.GuestNo = G.GuestNo
WHERE R.HotelNo = 1;
```

3. What is the average number of bookings for each hotel in April?

```sql
SELECT H.Name AS HotelName, AVG(BookingCount) AS AvgBookingsInApril
FROM Hotel H
LEFT JOIN (
    SELECT H.HotelNo, COUNT(B.BookingNo) AS BookingCount
    FROM Hotel H
    LEFT JOIN Booking B ON H.HotelNo = B.HotelNo
    WHERE DATEPART(MONTH, B.DateFrom) = 4
    GROUP BY H.HotelNo
) AS AvgBookings ON H.HotelNo = AvgBookings.HotelNo
GROUP BY H.Name;
```

4. Create an index on the Room table's "Price" field:

```sql
CREATE INDEX IX_Price ON Room (Price);
```

5. List full details of all hotels:

```sql
SELECT *
FROM Hotel;
```

6. List full details of all hotels in London:

```sql
SELECT *
FROM Hotel
WHERE City = 'London';
```

7. Update the price of all rooms by 5%:

```sql
UPDATE Room
SET Price = Price * 1.05;
```

8. List the number of rooms in each hotel in London:

```sql
SELECT H.Name, COUNT(R.RoomNo) AS NumberOfRooms
FROM Hotel H
LEFT JOIN Room R ON H.HotelNo = R.HotelNo
WHERE H.City = 'London'
GROUP BY H.Name;
```

9. List all double or family rooms with a price below £40.00 per night, in ascending order of price:

```sql
SELECT *
FROM Room
WHERE (Type = 'Double' OR Type = 'Family') AND Price < 40.00
ORDER BY Price ASC;
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios.

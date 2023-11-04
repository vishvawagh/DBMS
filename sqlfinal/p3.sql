'''
3. The following tables form part of a database held in a relational DBMS:
Hotel (HotelNo, Name, City) HotelNo is the primary key
Room (RoomNo, HotelNo, Type, Price)
Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo)
Guest (GuestNo, GuestName, GuestAddress) GuestNo is primary key
Room contains room details for each hotel and (HotelNo, RoomNo) forms the
primary key.Booking contains details of the bookings and the primary key comprises
(HotelNo, GuestNo and DateFrom)
Solve following queries by SQL
1. List full details of all hotels.
2. How many hotels are there?
3. List the price and type of all rooms at the Grosvenor Hotel.
4. List the number of rooms in each hotel.
5. Update the price of all rooms by 5%.
6. List full details of all hotels in London.
7. What is the average price of a room?
8. List all guests currently staying at the Grosvenor Hotel.
9. List the number of rooms in each hotel in London.
10. Create one view on above database and query it. do same for these
'''
To solve these queries, you can create the tables, insert sample data, and then provide the SQL queries based on the given table structure. Here's how to create the tables, insert data, and execute the queries:

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

2. How many hotels are there?

```sql
SELECT COUNT(*) AS HotelCount
FROM Hotel;
```

3. List the price and type of all rooms at the Grosvenor Hotel:

```sql
SELECT Type, Price
FROM Room
WHERE HotelNo = 1;
```

4. List the number of rooms in each hotel:

```sql
SELECT Hotel.Name, COUNT(Room.RoomNo) AS NumberOfRooms
FROM Hotel
LEFT JOIN Room ON Hotel.HotelNo = Room.HotelNo
GROUP BY Hotel.Name;
```

5. Update the price of all rooms by 5%:

```sql
UPDATE Room
SET Price = Price * 1.05;
```

6. List full details of all hotels in London:

```sql
SELECT *
FROM Hotel
WHERE City = 'London';
```

7. What is the average price of a room?

```sql
SELECT AVG(Price) AS AveragePrice
FROM Room;
```

8. List all guests currently staying at the Grosvenor Hotel:

```sql
SELECT G.GuestName
FROM Guest G
JOIN Booking B ON G.GuestNo = B.GuestNo
WHERE B.HotelNo = 1;
```

9. List the number of rooms in each hotel in London:

```sql
SELECT H.Name, COUNT(R.RoomNo) AS NumberOfRooms
FROM Hotel H
LEFT JOIN Room R ON H.HotelNo = R.HotelNo
WHERE H.City = 'London'
GROUP BY H.Name;
```

10. Create a view on the database and query it:

```sql
-- Create a view that combines information from Hotel, Room, and Guest
CREATE VIEW HotelRoomGuest AS
SELECT H.Name AS HotelName, R.RoomNo, R.Type, R.Price, G.GuestName, G.GuestAddress
FROM Hotel H
JOIN Room R ON H.HotelNo = R.HotelNo
LEFT JOIN Booking B ON R.RoomNo = B.RoomNo
LEFT JOIN Guest G ON B.GuestNo = G.GuestNo;

-- Query the view
SELECT * FROM HotelRoomGuest;
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios. Additionally, you created a view and queried it.

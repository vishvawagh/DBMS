'''
The following tables form part of a database held in a relational DBMS:
Hotel (HotelNo, Name, City) HotelNo is the primary key
Room (RoomNo, HotelNo, Type, Price)
Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo)
Guest (GuestNo, GuestName, GuestAddress)
Solve following queries by SQL
1. List full details of all hotels.
2. How many hotels are there?
3. List the price and type of all rooms at the Grosvenor Hotel.
4. List the number of rooms in each hotel
5. List all guests currently staying at the Grosvenor Hotel.
6. List all double or family rooms with a price below £40.00 per night, in ascending order of
price.
7. How many different guests have made bookings for August?
8. What is the total income from bookings for the Grosvenor Hotel today?
9. What is the most commonly booked room type for each hotel in London?
10. Update the price of all rooms by 5% ,create table and queries number wise
'''
To solve these queries, we will first create the tables, insert sample data, and then provide the SQL queries based on the given table structure. Here's how to create the tables, insert sample data, and execute the queries:

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
    PRIMARY KEY (RoomNo, HotelNo)
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
    (1, 101, '2023-08-01', '2023-08-05', 101),
    (1, 102, '2023-08-02', '2023-08-06', 102),
    (2, 201, '2023-08-03', '2023-08-07', 201),
    (2, 202, '2023-08-04', '2023-08-08', 202),
    (3, 301, '2023-08-05', '2023-08-09', 301),
    (3, 302, '2023-08-06', '2023-08-10', 302);

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

5. List all guests currently staying at the Grosvenor Hotel:

```sql
SELECT Guest.GuestName
FROM Guest
JOIN Booking ON Guest.GuestNo = Booking.GuestNo
WHERE Booking.HotelNo = 1;
```

6. List all double or family rooms with a price below £40.00 per night, in ascending order of price:

```sql
SELECT *
FROM Room
WHERE Type IN ('Double', 'Family') AND Price < 40.00
ORDER BY Price ASC;
```

7. How many different guests have made bookings for August?

```sql
SELECT COUNT(DISTINCT GuestNo) AS DifferentGuests
FROM Booking
WHERE DATEPART(MONTH, DateFrom) = 8;
```

8. What is the total income from bookings for the Grosvenor Hotel today?

```sql
SELECT SUM(Room.Price) AS TotalIncome
FROM Booking
JOIN Room ON Booking.RoomNo = Room.RoomNo
WHERE Booking.HotelNo = 1 AND DATEPART(DAY, DateFrom) = DATEPART(DAY, GETDATE());
```

9. What is the most commonly booked room type for each hotel in London?

```sql
SELECT Hotel.Name, TOP(1) WITH TIES Room.Type AS MostCommonRoomType
FROM Hotel
JOIN Room ON Hotel.Hotel

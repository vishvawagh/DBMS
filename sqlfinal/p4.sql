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

1. **Create Tables:**

```sql
-- Create the 'Hotel' table
CREATE TABLE Hotel (
    HotelNo INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);

-- Create the 'Room' table
CREATE TABLE Room (
    RoomNo INT PRIMARY KEY,
    HotelNo INT,
    Type VARCHAR(50),
    Price DECIMAL(10, 2),
    FOREIGN KEY (HotelNo) REFERENCES Hotel(HotelNo)
);

-- Create the 'Booking' table
CREATE TABLE Booking (
    HotelNo INT,
    GuestNo INT,
    DateFrom DATE,
    DateTo DATE,
    RoomNo INT,
    PRIMARY KEY (HotelNo, GuestNo, DateFrom),
    FOREIGN KEY (HotelNo, RoomNo) REFERENCES Room(HotelNo, RoomNo)
);

-- Create the 'Guest' table
CREATE TABLE Guest (
    GuestNo INT PRIMARY KEY,
    GuestName VARCHAR(50),
    GuestAddress VARCHAR(100)
);
```

2. **Queries by number:**

Query 1: What is the total revenue per night from all double rooms?
```sql
SELECT SUM(Price) AS TotalRevenuePerNight
FROM Room
WHERE Type = 'Double';
```

Query 2: List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room if the room is occupied.
```sql
SELECT r.RoomNo, r.Type, r.Price, g.GuestName
FROM Room r
LEFT JOIN Booking b ON r.HotelNo = b.HotelNo AND r.RoomNo = b.RoomNo
LEFT JOIN Guest g ON b.GuestNo = g.GuestNo
WHERE r.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel');
```

Query 3: What is the average number of bookings for each hotel in April?
```sql
SELECT h.Name AS HotelName, AVG(COUNT(b.DateFrom)) AS AvgBookings
FROM Hotel h
LEFT JOIN Booking b ON h.HotelNo = b.HotelNo
WHERE MONTH(b.DateFrom) = 4
GROUP BY h.HotelNo;
```

Query 4: Create an index on a field and show its performance in a query.
```sql
-- Create an index on the 'HotelNo' field in the 'Booking' table
CREATE INDEX idx_hotelno ON Booking (HotelNo);

-- You can then run queries with improved performance that involve the 'HotelNo' field.
```

Query 5: List full details of all hotels.
```sql
SELECT *
FROM Hotel;
```

Query 6: List full details of all hotels in London.
```sql
SELECT *
FROM Hotel
WHERE City = 'London';
```

Query 7: Update the price of all rooms by 5%.
```sql
UPDATE Room
SET Price = Price * 1.05;
```

Query 8: List the number of rooms in each hotel in London.
```sql
SELECT h.Name AS HotelName, COUNT(r.RoomNo) AS NumberOfRooms
FROM Hotel h
LEFT JOIN Room r ON h.HotelNo = r.HotelNo
WHERE h.City = 'London'
GROUP BY h.HotelNo;
```

Query 9: List all double or family rooms with a price below £40.00 per night, in ascending order of price.
```sql
SELECT RoomNo, Type, Price
FROM Room
WHERE Type IN ('Double', 'Family') AND Price < 40.00
ORDER BY Price;
```

These SQL queries are based on the provided tables and should help you with the specified questions. Make sure to adjust table and column names if they differ from the examples provided.
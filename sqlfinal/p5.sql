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
    Price DECIMAL(10, 2)
);

-- Create the 'Booking' table
CREATE TABLE Booking (
    HotelNo INT,
    GuestNo INT,
    DateFrom DATE,
    DateTo DATE,
    RoomNo INT
);

-- Create the 'Guest' table
CREATE TABLE Guest (
    GuestNo INT PRIMARY KEY,
    GuestName VARCHAR(50),
    GuestAddress VARCHAR(100)
);
```

2. **Queries by number:**

Query 1: List full details of all hotels.
```sql
SELECT *
FROM Hotel;
```

Query 2: How many hotels are there?
```sql
SELECT COUNT(*) AS TotalHotels
FROM Hotel;
```

Query 3: List the price and type of all rooms at the Grosvenor Hotel.
```sql
SELECT Type, Price
FROM Room
WHERE HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel');
```

Query 4: List the number of rooms in each hotel.
```sql
SELECT Hotel.Name, COUNT(Room.RoomNo) AS NumberOfRooms
FROM Hotel
LEFT JOIN Room ON Hotel.HotelNo = Room.HotelNo
GROUP BY Hotel.HotelNo;
```

Query 5: List all guests currently staying at the Grosvenor Hotel.
```sql
SELECT G.GuestName
FROM Guest AS G
INNER JOIN Booking AS B ON G.GuestNo = B.GuestNo
WHERE B.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel');
```

Query 6: List all double or family rooms with a price below £40.00 per night, in ascending order of price.
```sql
SELECT RoomNo, Type, Price
FROM Room
WHERE Type IN ('Double', 'Family') AND Price < 40.00
ORDER BY Price;
```

Query 7: How many different guests have made bookings for August?
```sql
SELECT COUNT(DISTINCT GuestNo) AS TotalGuestsInAugust
FROM Booking
WHERE MONTH(DateFrom) = 8;
```

Query 8: What is the total income from bookings for the Grosvenor Hotel today?
```sql
SELECT SUM(Room.Price) AS TotalIncomeToday
FROM Booking
INNER JOIN Room ON Booking.RoomNo = Room.RoomNo
WHERE Booking.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel')
AND Booking.DateFrom = CURDATE();
```

Query 9: What is the most commonly booked room type for each hotel in London?
```sql
SELECT Hotel.Name, Room.Type AS MostCommonRoomType
FROM Hotel
INNER JOIN Room ON Hotel.HotelNo = Room.HotelNo
WHERE Hotel.City = 'London'
GROUP BY Hotel.HotelNo
ORDER BY COUNT(Room.Type) DESC
LIMIT 1;
```

Query 10: Update the price of all rooms by 5%.
```sql
UPDATE Room
SET Price = Price * 1.05;
```

These SQL queries are based on the provided tables and should help you with the specified questions. Make sure to adjust table and column names if they differ from the examples provided.
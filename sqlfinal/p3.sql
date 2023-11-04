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
    RoomNo INT,
    HotelNo INT,
    Type VARCHAR(50),
    Price DECIMAL(10, 2),
    PRIMARY KEY (HotelNo, RoomNo),
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
    FOREIGN KEY (HotelNo) REFERENCES Hotel(HotelNo),
    FOREIGN KEY (RoomNo, HotelNo) REFERENCES Room(RoomNo, HotelNo)
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
SELECT Room.Price, Room.Type
FROM Room
WHERE Room.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel');
```

Query 4: List the number of rooms in each hotel.
```sql
SELECT Hotel.Name, COUNT(Room.RoomNo) AS NumberOfRooms
FROM Hotel
LEFT JOIN Room ON Hotel.HotelNo = Room.HotelNo
GROUP BY Hotel.Name;
```

Query 5: Update the price of all rooms by 5%.
```sql
UPDATE Room
SET Price = Price * 1.05;
```

Query 6: List full details of all hotels in London.
```sql
SELECT *
FROM Hotel
WHERE City = 'London';
```

Query 7: What is the average price of a room?
```sql
SELECT AVG(Price) AS AverageRoomPrice
FROM Room;
```

Query 8: List all guests currently staying at the Grosvenor Hotel.
```sql
SELECT Guest.GuestName
FROM Guest
INNER JOIN Booking ON Guest.GuestNo = Booking.GuestNo
WHERE Booking.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel');
```

Query 9: List the number of rooms in each hotel in London.
```sql
SELECT Hotel.Name, COUNT(Room.RoomNo) AS NumberOfRooms
FROM Hotel
LEFT JOIN Room ON Hotel.HotelNo = Room.HotelNo
WHERE Hotel.City = 'London'
GROUP BY Hotel.Name;
```

10. **Create a view on the above database and query it:**

To create a view, you can use the following SQL statement:

```sql
CREATE VIEW HotelRoomSummary AS
SELECT h.Name AS HotelName, h.City, r.Type, r.Price
FROM Hotel h
LEFT JOIN Room r ON h.HotelNo = r.HotelNo;
```

Once you've created the view, you can query it like a table. For example, to list the details of all hotels:

```sql
SELECT *
FROM HotelRoomSummary;
```

You can use the view `HotelRoomSummary` to simplify and reuse the queries for reporting purposes.
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
Certainly! Here's how you can create the tables and SQL queries for each of the specified questions:

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

Query 2: List full details of all hotels in London.
```sql
SELECT *
FROM Hotel
WHERE City = 'London';
```

Query 3: List all guests currently staying at the Grosvenor Hotel.
```sql
SELECT G.GuestName
FROM Guest AS G
INNER JOIN Booking AS B ON G.GuestNo = B.GuestNo
WHERE B.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel');
```

Query 4: List the names and addresses of all guests in London, alphabetically ordered by name.
```sql
SELECT GuestName, GuestAddress
FROM Guest
WHERE GuestNo IN (
    SELECT GuestNo
    FROM Booking
    WHERE HotelNo IN (
        SELECT HotelNo
        FROM Hotel
        WHERE City = 'London'
    )
)
ORDER BY GuestName;
```

Query 5: List the bookings for which no `DateTo` has been specified.
```sql
SELECT *
FROM Booking
WHERE DateTo IS NULL;
```

Query 6: How many hotels are there?
```sql
SELECT COUNT(*) AS TotalHotels
FROM Hotel;
```

Query 7: List the rooms that are currently unoccupied at the Grosvenor Hotel.
```sql
SELECT R.RoomNo, R.Type
FROM Room AS R
WHERE R.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel')
AND R.RoomNo NOT IN (SELECT RoomNo FROM Booking WHERE HotelNo = R.HotelNo);
```

Query 8: What is the lost income from unoccupied rooms at each hotel today?
```sql
SELECT H.Name AS HotelName, SUM(R.Price) AS LostIncomeToday
FROM Hotel AS H
INNER JOIN Room AS R ON H.HotelNo = R.HotelNo
WHERE R.RoomNo NOT IN (SELECT RoomNo FROM Booking WHERE HotelNo = H.HotelNo AND DateFrom = CURDATE())
GROUP BY H.HotelNo;
```

Query 9: Create an index on one of the fields and show its performance in a query.
To create an index, you can use a statement like this:

```sql
CREATE INDEX idx_hotel_city ON Hotel(City);
```

After creating the index, queries that involve filtering or ordering by the `City` column in the `Hotel` table will perform faster.

Query 10: Create one view on the above database and query it.
To create a view, you can use a statement like this:

```sql
CREATE VIEW HotelBookingSummary AS
SELECT H.Name AS HotelName, B.DateFrom, B.DateTo, R.Type, R.Price
FROM Hotel AS H
INNER JOIN Booking AS B ON H.HotelNo = B.HotelNo
INNER JOIN Room AS R ON B.RoomNo = R.RoomNo;
```

Once you've created the view, you can query it like a table:

```sql
SELECT *
FROM HotelBookingSummary;
```

These SQL queries are based on the provided tables and should help you with the specified questions. Make sure to adjust table and column names if they differ from the examples provided.
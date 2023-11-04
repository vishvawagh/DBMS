'''Create the following tables.
1)PUBLISHER( PID , PNAME ,ADDRESS ,STATE ,PHONE ,EMAILID );
2)BOOK( ISBN ,BOOK_TITLE , CATEGORY , PRICE , COPYRIGHT_DATE , YEAR ,PAGE_COUNT ,PID );
3) AUTHOR(AID,ANAME,STATE,CITY ,ZIP,PHONE,URL )
4) AUTHOR_BOOK(AID,ISBN);
5) REVIEW(RID,ISBN,RATING);
Solve following queries by SQL
1. Retrieve city, phone, url of author whose name is ‘CHETAN BHAGAT’.
2. Retrieve book title, reviewable id and rating of all books.
3. Retrieve book title, price, author name and url for publishers ‘MEHTA’.
4. In a PUBLISHER relation change the phone number of ‘MEHTA’ to 123456
5. Calculate and display the average, maximum, minimum price of each publisher.
6. Delete details of all books having a page count less than 100.
7. Retrieve details of all authors residing in city Pune and whose name begins with character
‘C’.
8. Retrieve details of authors residing in same city as ‘Korth’.
9. Create a procedure to update the value of page count of a book of given ISBN.
10. Create a function that returns the price of book with a given ISBN'''
Certainly! Here are the table creations and SQL queries numbered accordingly:

1. **Table Creation: PUBLISHER**

```sql
CREATE TABLE PUBLISHER (
    PID INT PRIMARY KEY,
    PNAME VARCHAR(50),
    ADDRESS VARCHAR(100),
    STATE VARCHAR(20),
    PHONE VARCHAR(15),
    EMAILID VARCHAR(50)
);
```

2. **Table Creation: BOOK**

```sql
CREATE TABLE BOOK (
    ISBN INT PRIMARY KEY,
    BOOK_TITLE VARCHAR(100),
    CATEGORY VARCHAR(50),
    PRICE DECIMAL(10, 2),
    COPYRIGHT_DATE DATE,
    YEAR INT,
    PAGE_COUNT INT,
    PID INT,
    FOREIGN KEY (PID) REFERENCES PUBLISHER(PID)
);
```

3. **Table Creation: AUTHOR**

```sql
CREATE TABLE AUTHOR (
    AID INT PRIMARY KEY,
    ANAME VARCHAR(50),
    STATE VARCHAR(20),
    CITY VARCHAR(50),
    ZIP VARCHAR(10),
    PHONE VARCHAR(15),
    URL VARCHAR(100)
);
```

4. **Table Creation: AUTHOR_BOOK**

```sql
CREATE TABLE AUTHOR_BOOK (
    AID INT,
    ISBN INT,
    FOREIGN KEY (AID) REFERENCES AUTHOR(AID),
    FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
);
```

5. **Table Creation: REVIEW**

```sql
CREATE TABLE REVIEW (
    RID INT PRIMARY KEY,
    ISBN INT,
    RATING INT,
    FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
);
```

Now, let's go through the queries:

1. Retrieve city, phone, and URL of the author whose name is 'CHETAN BHAGAT'.
```sql
SELECT CITY, PHONE, URL
FROM AUTHOR
WHERE ANAME = 'CHETAN BHAGAT';
```

2. Retrieve book title, reviewable ID, and rating of all books.
```sql
SELECT B.BOOK_TITLE, R.RID, R.RATING
FROM BOOK AS B
LEFT JOIN REVIEW AS R ON B.ISBN = R.ISBN;
```

3. Retrieve book title, price, author name, and URL for publishers 'MEHTA'.
```sql
SELECT B.BOOK_TITLE, B.PRICE, A.ANAME, A.URL
FROM BOOK AS B
INNER JOIN PUBLISHER AS P ON B.PID = P.PID
INNER JOIN AUTHOR_BOOK AS AB ON B.ISBN = AB.ISBN
INNER JOIN AUTHOR AS A ON AB.AID = A.AID
WHERE P.PNAME = 'MEHTA';
```

4. In the PUBLISHER relation, change the phone number of 'MEHTA' to 123456.
```sql
UPDATE PUBLISHER
SET PHONE = '123456'
WHERE PNAME = 'MEHTA';
```

5. Calculate and display the average, maximum, and minimum price of each publisher.
```sql
SELECT P.PNAME, AVG(B.PRICE) AS AVG_PRICE, MAX(B.PRICE) AS MAX_PRICE, MIN(B.PRICE) AS MIN_PRICE
FROM PUBLISHER AS P
INNER JOIN BOOK AS B ON P.PID = B.PID
GROUP BY P.PNAME;
```

6. Delete details of all books having a page count less than 100.
```sql
DELETE FROM BOOK
WHERE PAGE_COUNT < 100;
```

7. Retrieve details of all authors residing in the city 'Pune' and whose name begins with the character 'C'.
```sql
SELECT *
FROM AUTHOR
WHERE CITY = 'Pune' AND ANAME LIKE 'C%';
```

8. Retrieve details of authors residing in the same city as 'Korth'.
```sql
SELECT A.*
FROM AUTHOR AS A
WHERE A.CITY = (SELECT CITY FROM AUTHOR WHERE ANAME = 'Korth');
```

9. Create a procedure to update the value of the page count of a book for a given ISBN.
```sql
DELIMITER //
CREATE PROCEDURE UpdatePageCount(IN ISBNToUpdate INT, IN NewPageCount INT)
BEGIN
    UPDATE BOOK
    SET PAGE_COUNT = NewPageCount
    WHERE ISBN = ISBNToUpdate;
END;
//
DELIMITER ;
```

10. Create a function that returns the price of a book with a given ISBN.
```sql
DELIMITER //
CREATE FUNCTION GetBookPrice(IN ISBNToRetrieve INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE BookPrice DECIMAL(10, 2);
    SELECT PRICE INTO BookPrice FROM BOOK WHERE ISBN = ISBNToRetrieve;
    RETURN BookPrice;
END;
//
DELIMITER ;
```


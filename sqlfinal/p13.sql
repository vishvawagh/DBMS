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
To solve these queries, we will first create the tables, add primary keys and foreign keys where applicable, insert sample data, and then provide the SQL queries for each scenario:

1. Create the tables:

```sql
-- Create the PUBLISHER table
CREATE TABLE PUBLISHER (
    PID INT PRIMARY KEY,
    PNAME VARCHAR(100),
    ADDRESS VARCHAR(100),
    STATE VARCHAR(50),
    PHONE VARCHAR(20),
    EMAILID VARCHAR(100)
);

-- Create the BOOK table
CREATE TABLE BOOK (
    ISBN VARCHAR(13) PRIMARY KEY,
    BOOK_TITLE VARCHAR(100),
    CATEGORY VARCHAR(50),
    PRICE DECIMAL(10, 2),
    COPYRIGHT_DATE DATE,
    YEAR INT,
    PAGE_COUNT INT,
    PID INT,
    FOREIGN KEY (PID) REFERENCES PUBLISHER(PID)
);

-- Create the AUTHOR table
CREATE TABLE AUTHOR (
    AID INT PRIMARY KEY,
    ANAME VARCHAR(100),
    STATE VARCHAR(50),
    CITY VARCHAR(50),
    ZIP VARCHAR(10),
    PHONE VARCHAR(20),
    URL VARCHAR(100)
);

-- Create the AUTHOR_BOOK table
CREATE TABLE AUTHOR_BOOK (
    AID INT,
    ISBN VARCHAR(13),
    FOREIGN KEY (AID) REFERENCES AUTHOR(AID),
    FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
);

-- Create the REVIEW table
CREATE TABLE REVIEW (
    RID INT PRIMARY KEY,
    ISBN VARCHAR(13),
    RATING DECIMAL(3, 1),
    FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
);

-- Insert sample data into the tables
INSERT INTO PUBLISHER (PID, PNAME, ADDRESS, STATE, PHONE, EMAILID)
VALUES
    (1, 'Mehta', '123 Main St', 'NY', '9876543210', 'mehta@example.com'),
    (2, 'Penguin', '456 Elm St', 'CA', '1234567890', 'penguin@example.com');

INSERT INTO BOOK (ISBN, BOOK_TITLE, CATEGORY, PRICE, COPYRIGHT_DATE, YEAR, PAGE_COUNT, PID)
VALUES
    ('ISBN1', 'Book 1', 'Fiction', 19.99, '2022-01-01', 2022, 250, 1),
    ('ISBN2', 'Book 2', 'Non-Fiction', 29.99, '2021-06-15', 2021, 300, 2);

INSERT INTO AUTHOR (AID, ANAME, STATE, CITY, ZIP, PHONE, URL)
VALUES
    (1, 'Chetan Bhagat', 'NY', 'New York', '10001', '9998887777', 'www.chetanbhagat.com'),
    (2, 'Author 2', 'CA', 'Los Angeles', '90001', '1112223333', 'www.author2.com');

INSERT INTO AUTHOR_BOOK (AID, ISBN)
VALUES
    (1, 'ISBN1'),
    (2, 'ISBN2');

INSERT INTO REVIEW (RID, ISBN, RATING)
VALUES
    (101, 'ISBN1', 4.5),
    (102, 'ISBN2', 3.7);
```

Now that you've created the tables, added primary keys and foreign keys, and inserted sample data, you can proceed with the SQL queries:

1. Retrieve the city, phone, and URL of the author whose name is 'CHETAN BHAGAT':

```sql
SELECT CITY, PHONE, URL
FROM AUTHOR
WHERE ANAME = 'Chetan Bhagat';
```

2. Retrieve the book title, reviewable id, and rating of all books:

```sql
SELECT B.BOOK_TITLE, R.RID, R.RATING
FROM BOOK B
JOIN REVIEW R ON B.ISBN = R.ISBN;
```

3. Retrieve the book title, price, author name, and URL for publishers 'MEHTA':

```sql
SELECT B.BOOK_TITLE, B.PRICE, A.ANAME, A.URL
FROM BOOK B
JOIN PUBLISHER P ON B.PID = P.PID
JOIN AUTHOR_BOOK AB ON B.ISBN = AB.ISBN
JOIN AUTHOR A ON AB.AID = A.AID
WHERE P.PNAME = 'Mehta';
```

4. Update the phone number of the 'MEHTA' publisher to '123456':

```sql
UPDATE PUBLISHER
SET PHONE = '123456'
WHERE PNAME = 'Mehta';
```

5. Calculate and display the average, maximum, and minimum price of each publisher:

```sql
SELECT P.PNAME, AVG(B.PRICE) AS AveragePrice, MAX(B.PRICE) AS MaxPrice, MIN(B.PRICE) AS MinPrice
FROM PUBLISHER P
JOIN BOOK B ON P.PID = B.PID
GROUP BY P.PNAME;
```

6. Delete details of all books having a page count less than 100:

```sql
DELETE FROM BOOK
WHERE PAGE_COUNT < 100;
```

7. Retrieve details of all authors residing in the city 'Pune' and whose name begins with the character 'C':

```sql
SELECT *
FROM AUTHOR
WHERE CITY = 'Pune' AND ANAME LIKE 'C%';
```

8. Retrieve details of authors residing in the same city as 'Korth' (assuming 'Korth' is the name of an author's city):

```sql
SELECT A.ANAME, A.CITY
FROM AUTHOR A
WHERE A.CITY = (SELECT CITY FROM AUTHOR WHERE ANAME = 'Korth');
```

9. Create a procedure to update the value of page count of a book of a given ISBN:

```sql
DELIMITER //
CREATE PROCEDURE UpdatePageCount(IN bookISBN VARCHAR(13), IN newPageCount INT)
BEGIN
    UPDATE BOOK
    SET PAGE_COUNT = newPageCount
    WHERE ISBN = bookISBN;
END //
DELIMITER ;
```

10. Create a function that returns the price of a book with a given ISBN:

```sql
DELIMITER //
CREATE FUNCTION GetBookPrice(bookISBN VARCHAR(13))
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE bookPrice DECIMAL(10, 2);
    SELECT PRICE INTO bookPrice FROM BOOK WHERE ISBN = bookISBN;
    RETURN bookPrice;
END //
DELIMITER ;
```

You've now created tables, inserted data, and executed the SQL queries for the given scenarios, including creating procedures and functions.

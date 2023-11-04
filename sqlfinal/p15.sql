15.
a) Write an SQL code block these raise a user defined exception where business rule is
voilated. BR for client_ master table specifies when the value of bal_due field is less than 0
handle the exception.
b) Write an SQL code block
Borrow(Roll_no, Name, DateofIssue, NameofBook, Status)
Fine(Roll_no,Date,Amt)
Accept roll_no & name of book from user. Check the number of days (from date of issue), if
days are between 15 to 30 then fine amount will be Rs 5per day. If no. of days>30, per day fine
will be Rs 50 per day & for days less than 30, Rs. 5 per day. After submitting the book, status
will change from I to R. If condition of fine is true, then details will be stored into fine table.
Also handles the exception by named exception handler or user define exception handler.
a) SQL code block with a user-defined exception for the `client_master` table:

```sql
-- Create the client_master table for testing
CREATE TABLE client_master (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    bal_due NUMBER(10, 2)
);

-- Sample data for testing
INSERT INTO client_master (client_id, client_name, bal_due) VALUES (1, 'Client A', -1000);
INSERT INTO client_master (client_id, client_name, bal_due) VALUES (2, 'Client B', 500);

-- SQL code block with a user-defined exception
DECLARE
    v_client_id INT := &client_id; -- Prompt for user input
    v_bal_due NUMBER(10, 2);
    
    -- User-defined exception
    negative_balance EXCEPTION;
    PRAGMA EXCEPTION_INIT(negative_balance, -20000);

BEGIN
    -- Get the balance due for the client
    SELECT bal_due INTO v_bal_due FROM client_master WHERE client_id = v_client_id;

    -- Check if balance due is less than 0
    IF v_bal_due < 0 THEN
        -- Raise the user-defined exception
        RAISE_APPLICATION_ERROR(-20000, 'Balance due is less than 0');
    ELSE
        -- Process the data (in this case, no further action)
        DBMS_OUTPUT.PUT_LINE('No exception raised. Balance due is: ' || v_bal_due);
    END IF;

EXCEPTION
    WHEN negative_balance THEN
        DBMS_OUTPUT.PUT_LINE('User-defined exception: Balance due is less than 0');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Client not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/
```

In this code block, we've created a user-defined exception `negative_balance` and used the `RAISE_APPLICATION_ERROR` function to raise it when the balance due is less than 0.

b) SQL code block for the `Borrow` and `Fine` tables:

```sql
-- Create the Borrow table for testing
CREATE TABLE Borrow (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(100),
    DateofIssue DATE,
    NameofBook VARCHAR(100),
    Status CHAR(1)
);

-- Create the Fine table for testing
CREATE TABLE Fine (
    Roll_no INT,
    Date DATE,
    Amt NUMBER(10, 2)
);

-- SQL code block to calculate and handle fines
DECLARE
    v_roll_no INT := &roll_no; -- Prompt for user input
    v_book_name VARCHAR(100) := '&book_name'; -- Prompt for user input
    v_date_of_issue DATE;
    v_days_elapsed INT;
    v_fine_amt NUMBER(10, 2);

    -- User-defined exceptions
    fine_too_high EXCEPTION;
    PRAGMA EXCEPTION_INIT(fine_too_high, -20001);
    invalid_status EXCEPTION;
    PRAGMA EXCEPTION_INIT(invalid_status, -20002);

BEGIN
    -- Get the date of issue for the book
    SELECT DateofIssue INTO v_date_of_issue
    FROM Borrow
    WHERE Roll_no = v_roll_no AND NameofBook = v_book_name AND Status = 'I';

    -- Calculate the number of days elapsed
    v_days_elapsed := TRUNC(SYSDATE - v_date_of_issue);

    -- Check the status and calculate the fine amount
    IF v_days_elapsed > 30 THEN
        v_fine_amt := v_days_elapsed * 50;
    ELSIF v_days_elapsed >= 15 AND v_days_elapsed <= 30 THEN
        v_fine_amt := v_days_elapsed * 5;
    ELSE
        v_fine_amt := 0;
    END IF;

    -- Check if the fine amount is too high
    IF v_fine_amt > 500 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Fine amount exceeds the limit');
    END IF;

    -- Update the status to 'R'
    UPDATE Borrow
    SET Status = 'R'
    WHERE Roll_no = v_roll_no AND NameofBook = v_book_name AND Status = 'I';

    -- Insert fine details into the Fine table
    INSERT INTO Fine (Roll_no, Date, Amt) VALUES (v_roll_no, SYSDATE, v_fine_amt);

EXCEPTION
    WHEN fine_too_high THEN
        DBMS_OUTPUT.PUT_LINE('User-defined exception: Fine amount exceeds the limit');
    WHEN invalid_status THEN
        DBMS_OUTPUT.PUT_LINE('User-defined exception: Invalid book status');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Book not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/
```

In this code block, we've created two user-defined exceptions, `fine_too_high` and `invalid_status`, and used them to handle specific scenarios. We calculate the fine amount based on the number of days elapsed and check if the fine amount exceeds a limit. The status of the book is updated to 'R', and fine details are inserted into the `Fine` table.

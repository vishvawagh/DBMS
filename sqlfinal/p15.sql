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
a) Here is an SQL code block that raises a user-defined exception when a business rule is violated in the `client_master` table:

```sql
DECLARE
   v_balance_due NUMBER;
   
   -- User-defined exception
   negative_balance_due EXCEPTION;
   PRAGMA EXCEPTION_INIT(negative_balance_due, -20001);
BEGIN
   -- Get the balance_due for a specific client
   SELECT bal_due INTO v_balance_due
   FROM client_master
   WHERE client_id = &Enter_Client_ID; -- You may need to adjust this condition

   -- Check if the balance_due is less than 0
   IF v_balance_due < 0 THEN
      RAISE negative_balance_due;
   END IF;
EXCEPTION
   WHEN negative_balance_due THEN
      DBMS_OUTPUT.PUT_LINE('User-defined exception: Negative balance_due is not allowed.');
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Client not found in the database.');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```

In this SQL code block, a user-defined exception named `negative_balance_due` is raised when the `balance_due` for a specific client is less than 0. The block also handles other exceptions, like the client not being found or any other errors.

b) Here is an SQL code block that checks the number of days between the issue date and the current date, calculates the fine amount, and updates the `Borrow` table. It also handles exceptions:

```sql
DECLARE
   v_roll_no NUMBER := &Enter_Roll_No;
   v_name_of_book VARCHAR2(50) := '&Enter_Name_Of_Book';
   v_issue_date DATE;
   v_fine_amount NUMBER;
   v_status CHAR(1) := 'R'; -- Assuming 'R' represents 'Returned' status

   -- User-defined exception
   fine_required EXCEPTION;
   PRAGMA EXCEPTION_INIT(fine_required, -20002);

BEGIN
   -- Get the issue date for the book
   SELECT DateofIssue INTO v_issue_date
   FROM Borrow
   WHERE Roll_no = v_roll_no AND NameofBook = v_name_of_book;

   -- Calculate the number of days since issue
   v_fine_amount := CASE
      WHEN (SYSDATE - v_issue_date) <= 15 THEN 0
      WHEN (SYSDATE - v_issue_date) <= 30 THEN (SYSDATE - v_issue_date - 15) * 5
      ELSE (SYSDATE - v_issue_date - 30) * 50 + 75
   END;

   -- Check if fine is required and update status
   IF v_fine_amount > 0 THEN
      RAISE fine_required;
   ELSE
      -- Update the status to 'R' (Returned)
      UPDATE Borrow
      SET Status = v_status
      WHERE Roll_no = v_roll_no AND NameofBook = v_name_of_book;

      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Book returned successfully. Fine amount: ' || v_fine_amount);
   END IF;

EXCEPTION
   WHEN fine_required THEN
      DBMS_OUTPUT.PUT_LINE('User-defined exception: Fine of ' || v_fine_amount || ' is required.');
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Book not found in the Borrow table.');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```

This SQL code block calculates the fine amount based on the number of days since issue and updates the status accordingly. If a fine is required, it raises a user-defined exception `fine_required`. It also handles other exceptions like the book not being found or any other errors.
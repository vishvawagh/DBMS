14.
a) Consider table Stud(Roll, Att,Status)
Write a PL/SQL block for following requirement and handle the exceptions. Roll no. of student
will be entered by user. Attendance of roll no. entered by user will be checked in Stud table. If
attendance is less than 75% then display the message “Term not granted” and set the status in
stud table as “D”. Otherwise display message “Term granted” and set the status in stud table as
“ND”
b) Write a PL/SQL block for following requirement using user defined exception handling. The
account_master table records the current balance for an account, which is updated whenever, any
deposits or withdrawals takes place. If the withdrawal attempted is more than the current balance
held in the account. The user defined exception is raised, displaying an appropriate message.
Write a PL/SQL block for above requirement using user defined exception handling.
a) PL/SQL block for handling attendance and status:

```sql
-- Create the STUD table for testing
CREATE TABLE Stud (
    Roll INT PRIMARY KEY,
    Att NUMBER(5, 2),
    Status CHAR(1)
);

-- Sample data for testing
INSERT INTO Stud (Roll, Att, Status) VALUES (101, 80, 'ND');
INSERT INTO Stud (Roll, Att, Status) VALUES (102, 60, 'D');

-- PL/SQL block to check attendance and set status
DECLARE
    v_roll_no INT;
    v_attendance NUMBER(5, 2);
BEGIN
    -- Input roll number from the user
    v_roll_no := &roll_no;  -- Prompt for user input

    -- Check attendance for the given roll number
    SELECT Att INTO v_attendance FROM Stud WHERE Roll = v_roll_no;

    -- Check attendance and update status
    IF v_attendance < 75 THEN
        DBMS_OUTPUT.PUT_LINE('Term not granted');
        -- Update status to "D"
        UPDATE Stud SET Status = 'D' WHERE Roll = v_roll_no;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Term granted');
        -- Update status to "ND"
        UPDATE Stud SET Status = 'ND' WHERE Roll = v_roll_no;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Roll number not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/
```

b) PL/SQL block for user-defined exception handling:

```sql
-- Create the account_master table for testing
CREATE TABLE account_master (
    account_id INT PRIMARY KEY,
    current_balance NUMBER(10, 2)
);

-- Sample data for testing
INSERT INTO account_master (account_id, current_balance) VALUES (1, 1000);
INSERT INTO account_master (account_id, current_balance) VALUES (2, 500);

-- PL/SQL block with user-defined exception
DECLARE
    v_account_id INT := &account_id; -- Prompt for user input
    v_withdrawal_amount NUMBER(10, 2) := &withdrawal_amount; -- Prompt for user input
    v_current_balance NUMBER(10, 2);
    
    -- User-defined exception
    insufficient_funds EXCEPTION;
    PRAGMA EXCEPTION_INIT(insufficient_funds, -20000);

BEGIN
    -- Get the current balance for the account
    SELECT current_balance INTO v_current_balance FROM account_master WHERE account_id = v_account_id;

    -- Check if withdrawal amount exceeds the current balance
    IF v_withdrawal_amount > v_current_balance THEN
        -- Raise the user-defined exception
        RAISE insufficient_funds;
    ELSE
        -- Perform the withdrawal
        v_current_balance := v_current_balance - v_withdrawal_amount;
        -- Update the current balance
        UPDATE account_master SET current_balance = v_current_balance WHERE account_id = v_account_id;
        DBMS_OUTPUT.PUT_LINE('Withdrawal successful. New balance: ' || v_current_balance);
    END IF;

EXCEPTION
    WHEN insufficient_funds THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient funds for withdrawal');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/
```

In the code for part b, we have created a user-defined exception named `insufficient_funds` and used the `RAISE` statement to raise this exception when a withdrawal amount exceeds the current balance. This allows you to handle specific cases with customized error messages.

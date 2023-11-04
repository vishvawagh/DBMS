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
a) Here is a PL/SQL block that accomplishes the requirement to check a student's attendance and set their status based on the attendance percentage. We also handle exceptions for this scenario:

```plsql
DECLARE
   v_roll_number STUD.Roll%TYPE;
   v_attendance STUD.Att%TYPE;
   v_status STUD.Status%TYPE;
BEGIN
   -- Accept roll number from the user
   v_roll_number := &Enter_Roll_Number;

   -- Check attendance for the given roll number
   SELECT Att, Status INTO v_attendance, v_status
   FROM Stud
   WHERE Roll = v_roll_number;

   -- Check attendance percentage and set status accordingly
   IF v_attendance < 75 THEN
      DBMS_OUTPUT.PUT_LINE('Term not granted');
      v_status := 'D';
   ELSE
      DBMS_OUTPUT.PUT_LINE('Term granted');
      v_status := 'ND';
   END IF;

   -- Update status in the Stud table
   UPDATE Stud
   SET Status = v_status
   WHERE Roll = v_roll_number;

   COMMIT;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Roll number not found in the database.');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```

This PL/SQL block will prompt the user to enter a roll number, check the attendance for that roll number, and update the status accordingly. It also handles exceptions for scenarios such as the roll number not being found in the database or any other errors.

b) Here is a PL/SQL block that handles user-defined exceptions for withdrawal from an account:

```plsql
DECLARE
   v_account_number NUMBER := &Enter_Account_Number;
   v_withdrawal_amount NUMBER := &Enter_Withdrawal_Amount;
   v_current_balance NUMBER;

   -- User-defined exception
   insufficient_funds EXCEPTION;
   PRAGMA EXCEPTION_INIT(insufficient_funds, -20001);

BEGIN
   -- Get the current balance for the account
   SELECT balance INTO v_current_balance
   FROM account_master
   WHERE account_number = v_account_number;

   -- Check if the withdrawal amount is greater than the current balance
   IF v_withdrawal_amount > v_current_balance THEN
      RAISE insufficient_funds;
   ELSE
      -- Update the balance after successful withdrawal
      UPDATE account_master
      SET balance = v_current_balance - v_withdrawal_amount
      WHERE account_number = v_account_number;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Withdrawal successful. New balance: ' || (v_current_balance - v_withdrawal_amount));
   END IF;
EXCEPTION
   WHEN insufficient_funds THEN
      DBMS_OUTPUT.PUT_LINE('Insufficient funds for withdrawal.');
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Account number not found in the database.');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```

In this PL/SQL block, a user-defined exception named `insufficient_funds` is raised if the withdrawal amount is greater than the current balance. It also handles other exceptions like account not found and any other errors that might occur during execution.
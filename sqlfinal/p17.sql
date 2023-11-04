17. Cursor (Any Two)
a) The bank manager has decided to activate all those accounts which were previously marked as
inactive for performing no transaction in last 365 days. Write a PL/SQ block (using implicit
cursor) to update the status of account, display an approximate message based on the no. of rows
affected by the update. (Use of %FOUND, %NOTFOUND, %ROWCOUNT)
b)Write a PL/SQL block of code using parameterized Cursor, that will merge the data available
in the newly created table N_RollCall with the data available in the table O_RollCall. If the
data in the first table already exist in the second table then that data should be skipped. output:
c)Write the PL/SQL block for following requirements using parameterized Cursor: Consider
table EMP(e_no, d_no, Salary), department wise average salary should be inserted into new
table dept_salary(d_no, Avg_sal)
a) Here is a PL/SQL block that uses an implicit cursor to activate accounts that were previously marked as inactive due to no transactions in the last 365 days. It also displays an approximate message based on the number of rows affected by the update using `%ROWCOUNT`:

```plsql
DECLARE
   v_rows_affected NUMBER := 0;
BEGIN
   -- Update the status of inactive accounts to 'Active'
   UPDATE account_table
   SET status = 'Active'
   WHERE last_transaction_date <= SYSDATE - 365;

   -- Get the number of rows affected by the update
   v_rows_affected := SQL%ROWCOUNT;

   -- Display an approximate message based on the number of rows affected
   IF v_rows_affected = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No accounts were activated.');
   ELSE
      DBMS_OUTPUT.PUT_LINE(v_rows_affected || ' accounts have been activated.');
   END IF;

   COMMIT;
END;
/
```

In this PL/SQL block, we update the status of accounts that meet the criteria and then use `SQL%ROWCOUNT` to determine how many rows were affected by the update. We display a message based on the number of rows updated.

b) To merge data from the newly created table `N_RollCall` with the data available in the table `O_RollCall` while skipping data that already exists in the second table, you can use a parameterized cursor. Here's a PL/SQL block for this:

```plsql
DECLARE
   CURSOR merge_cursor IS
      SELECT *
      FROM N_RollCall;

   v_n_roll_number N_RollCall.roll_number%TYPE;
BEGIN
   FOR n_rec IN merge_cursor LOOP
      v_n_roll_number := n_rec.roll_number;

      -- Check if the data already exists in O_RollCall
      SELECT COUNT(*) INTO v_exists
      FROM O_RollCall
      WHERE roll_number = v_n_roll_number;

      -- Insert the data if it doesn't already exist
      IF v_exists = 0 THEN
         INSERT INTO O_RollCall (roll_number, other_columns)
         VALUES (v_n_roll_number, n_rec.other_columns);
      END IF;
   END LOOP;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Data has been merged from N_RollCall to O_RollCall.');
END;
/
```

In this PL/SQL block, we use a parameterized cursor to fetch data from `N_RollCall`, and for each record, we check if the data already exists in `O_RollCall`. If not, we insert it into `O_RollCall`. This block effectively skips data that already exists in the second table.

c) To insert department-wise average salary into a new table `dept_salary`, you can use a parameterized cursor. Here's a PL/SQL block for this:

```plsql
DECLARE
   CURSOR dept_cursor IS
      SELECT DISTINCT d_no
      FROM EMP;

   v_d_no EMP.d_no%TYPE;
   v_avg_salary NUMBER;
BEGIN
   FOR dept_rec IN dept_cursor LOOP
      v_d_no := dept_rec.d_no;

      -- Calculate the average salary for the department
      SELECT AVG(Salary) INTO v_avg_salary
      FROM EMP
      WHERE d_no = v_d_no;

      -- Insert the department and its average salary into dept_salary
      INSERT INTO dept_salary (d_no, Avg_salary)
      VALUES (v_d_no, v_avg_salary);
   END LOOP;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Average salary per department has been inserted into dept_salary.');
END;
/
```

In this PL/SQL block, we use a parameterized cursor to fetch distinct department numbers, calculate the average salary for each department, and then insert the department and its average salary into the `dept_salary` table.
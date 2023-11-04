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
a) PL/SQL block using an implicit cursor to activate accounts and display a message:

```sql
-- Create the account table for testing
CREATE TABLE account (
    account_id INT PRIMARY KEY,
    account_status VARCHAR(1),
    last_transaction_date DATE
);

-- Sample data for testing
INSERT INTO account (account_id, account_status, last_transaction_date) VALUES (1, 'I', TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO account (account_id, account_status, last_transaction_date) VALUES (2, 'I', TO_DATE('2023-02-15', 'YYYY-MM-DD'));
INSERT INTO account (account_id, account_status, last_transaction_date) VALUES (3, 'A', TO_DATE('2023-10-10', 'YYYY-MM-DD'));

-- PL/SQL block to activate inactive accounts
DECLARE
    v_rowcount NUMBER;
BEGIN
    -- Update the status of inactive accounts
    UPDATE account
    SET account_status = 'A'
    WHERE account_status = 'I' AND last_transaction_date < SYSDATE - 365;

    -- Get the number of rows affected by the update
    v_rowcount := SQL%ROWCOUNT;

    IF v_rowcount > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Approximately ' || v_rowcount || ' account(s) activated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No accounts activated.');
    END IF;
END;
/
```

b) PL/SQL block using a parameterized cursor to merge data from `N_RollCall` into `O_RollCall`:

```sql
-- Create the N_RollCall and O_RollCall tables for testing
CREATE TABLE N_RollCall (
    roll_number INT PRIMARY KEY,
    student_name VARCHAR(100)
);

CREATE TABLE O_RollCall (
    roll_number INT PRIMARY KEY,
    student_name VARCHAR(100)
);

-- Sample data for testing
INSERT INTO O_RollCall (roll_number, student_name) VALUES (1, 'Alice');
INSERT INTO O_RollCall (roll_number, student_name) VALUES (2, 'Bob');
INSERT INTO N_RollCall (roll_number, student_name) VALUES (2, 'Bob');
INSERT INTO N_RollCall (roll_number, student_name) VALUES (3, 'Charlie');

-- PL/SQL block to merge data from N_RollCall into O_RollCall
DECLARE
    CURSOR merge_cursor IS
        SELECT roll_number, student_name
        FROM N_RollCall
        WHERE roll_number NOT IN (SELECT roll_number FROM O_RollCall);
BEGIN
    FOR merge_rec IN merge_cursor LOOP
        INSERT INTO O_RollCall (roll_number, student_name)
        VALUES (merge_rec.roll_number, merge_rec.student_name);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Data merged into O_RollCall.');
END;
/
```

c) PL/SQL block using a parameterized cursor to calculate department-wise average salary and insert it into a new table `dept_salary`:

```sql
-- Create the EMP table and dept_salary table for testing
CREATE TABLE EMP (
    e_no INT PRIMARY KEY,
    d_no INT,
    Salary NUMBER(10, 2)
);

CREATE TABLE dept_salary (
    d_no INT PRIMARY KEY,
    Avg_sal NUMBER(10, 2)
);

-- Sample data for testing
INSERT INTO EMP (e_no, d_no, Salary) VALUES (1, 101, 50000);
INSERT INTO EMP (e_no, d_no, Salary) VALUES (2, 101, 55000);
INSERT INTO EMP (e_no, d_no, Salary) VALUES (3, 102, 48000);

-- PL/SQL block to calculate department-wise average salary and insert into dept_salary
DECLARE
    CURSOR dept_cursor IS
        SELECT d_no, AVG(Salary) AS avg_salary
        FROM EMP
        GROUP BY d_no;
BEGIN
    FOR dept_rec IN dept_cursor LOOP
        INSERT INTO dept_salary (d_no, Avg_sal)
        VALUES (dept_rec.d_no, dept_rec.avg_salary);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Average salary by department calculated and inserted into dept_salary.');
END;
/
```

In these PL/SQL blocks, we use parameterized cursors to handle the specific tasks of activating accounts, merging data, and calculating department-wise average salaries. The results are displayed using the `DBMS_OUTPUT` package.


16. Cursor (Any Two)
a) The bank manager has decided to activate all those accounts which were previously marked as
inactive for performing no transaction in last 365 days. Write a PL/SQ block (using implicit
cursor) to update the status of account, display an approximate message based on the no. of rows
affected by the update. (Use of %FOUND, %NOTFOUND, %ROWCOUNT)
b)Organization has decided to increase the salary of employees by 10% of existing salary, who
are having salary less than average salary of organization, Whenever such salary updates takes
place, a record for the same is maintained in the increment_salary table.
c) Write PL/SQL block using explicit cursor for following requirements: College has decided to
mark all those students detained (D) who are having attendance less than 75%. Whenever such
update takes place, a record for the same is maintained in the D_Stud table. create table
stud21(roll number(4), att number(4), status varchar(1));In SQL, you typically use explicit cursors within PL/SQL blocks. Here are SQL blocks for the scenarios you described, using explicit cursors and including the creation of tables, data insertion, and cursor processing:

a) Bank Account Activation (Implicit Cursor):
```sql
-- Create the account table and insert sample data
CREATE TABLE account (
    account_id NUMBER,
    last_transaction_date DATE,
    status VARCHAR2(10)
);

INSERT INTO account (account_id, last_transaction_date, status)
VALUES (1, TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'Inactive');

-- SQL block to activate inactive accounts and display a message
UPDATE account
SET status = 'Active'
WHERE last_transaction_date < SYSDATE - 365;

-- Get the number of rows affected
DECLARE
    v_rows_affected NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_rows_affected FROM account WHERE status = 'Active';

    IF v_rows_affected > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Accounts updated: ' || v_rows_affected);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No accounts were updated.');
    END IF;
END;
/
```

b) Employee Salary Increase (Implicit Cursor):
```sql
-- Create the employee table and insert sample data
CREATE TABLE employee (
    employee_id NUMBER,
    salary NUMBER
);

INSERT INTO employee (employee_id, salary)
VALUES (1, 50000);

-- SQL block to increase salaries and maintain records
DECLARE
    v_avg_salary NUMBER;
BEGIN
    -- Calculate the average salary of the organization
    SELECT AVG(salary) INTO v_avg_salary FROM employee;

    -- Update salaries for employees with salary < average
    UPDATE employee
    SET salary = salary * 1.10
    WHERE salary < v_avg_salary;

    -- Insert records into increment_salary table (assuming you have one)
    INSERT INTO increment_salary (employee_id, old_salary, new_salary)
    SELECT employee_id, salary / 1.10, salary
    FROM employee
    WHERE salary < v_avg_salary;
END;
/
```

c) Student Attendance (Implicit Cursor):
```sql
-- Create the stud21 table and insert sample data
CREATE TABLE stud21 (
    roll NUMBER(4),
    att NUMBER(4),
    status VARCHAR2(1)
);

INSERT INTO stud21 (roll, att, status)
VALUES (1, 80, 'A');

INSERT INTO stud21 (roll, att, status)
VALUES (2, 70, 'P');

-- SQL block to mark detained students and maintain records
DECLARE
    v_attendance_threshold NUMBER := 75;
BEGIN
    -- Update status to 'D' for students with attendance < 75%
    UPDATE stud21
    SET status = 'D'
    WHERE att < v_attendance_threshold;

    -- Insert records into the D_Stud table (assuming you have one)
    INSERT INTO D_Stud (roll, att)
    SELECT roll, att
    FROM stud21
    WHERE status = 'D';
END;
/
```

Please note that the examples provided assume you have the necessary tables and structures in your database. You may need to adjust table and column names to match your actual schema.


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
stud21(roll number(4), att number(4), status varchar(1));a) Here is a PL/SQL block that uses an implicit cursor to activate accounts that were previously marked as inactive due to no transactions in the last 365 days. It also displays an approximate message based on the number of rows affected by the update:
a) PL/SQL block using an implicit cursor to activate accounts:

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

b) PL/SQL block to increase employee salaries and maintain records in the `increment_salary` table:

```sql
-- Create the employee and increment_salary tables for testing
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary NUMBER(10, 2)
);

CREATE TABLE increment_salary (
    emp_id INT,
    increment_date DATE,
    previous_salary NUMBER(10, 2),
    new_salary NUMBER(10, 2)
);

-- Sample data for testing
INSERT INTO employee (emp_id, emp_name, salary) VALUES (1, 'Employee A', 50000);
INSERT INTO employee (emp_id, emp_name, salary) VALUES (2, 'Employee B', 45000);

-- PL/SQL block to increase employee salaries and maintain records
DECLARE
    v_avg_salary NUMBER;
BEGIN
    -- Calculate the average salary of all employees
    SELECT AVG(salary) INTO v_avg_salary FROM employee;

    -- Update salaries and maintain records in the increment_salary table
    FOR emp_rec IN (SELECT emp_id, emp_name, salary FROM employee WHERE salary < v_avg_salary) LOOP
        INSERT INTO increment_salary (emp_id, increment_date, previous_salary, new_salary)
        VALUES (emp_rec.emp_id, SYSDATE, emp_rec.salary, emp_rec.salary * 1.10);

        -- Increase the salary by 10%
        UPDATE employee
        SET salary = emp_rec.salary * 1.10
        WHERE emp_id = emp_rec.emp_id;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Salaries updated and records maintained.');
END;
/
```

c) PL/SQL block using an explicit cursor to mark detained students and maintain records in the `D_Stud` table:

```sql
-- Create the stud21 and D_Stud tables for testing
CREATE TABLE stud21 (
    roll NUMBER(4) PRIMARY KEY,
    att NUMBER(4),
    status VARCHAR(1)
);

CREATE TABLE D_Stud (
    roll NUMBER(4),
    detention_date DATE
);

-- Sample data for testing
INSERT INTO stud21 (roll, att, status) VALUES (1, 70, 'P');
INSERT INTO stud21 (roll, att, status) VALUES (2, 60, 'P');
INSERT INTO stud21 (roll, att, status) VALUES (3, 80, 'P');

-- PL/SQL block to mark detained students and maintain records
DECLARE
    CURSOR student_cursor IS
        SELECT roll, att
        FROM stud21
        WHERE att < 75;
    
    v_detention_date DATE := SYSDATE;
BEGIN
    FOR student_rec IN student_cursor LOOP
        -- Mark the student as detained
        UPDATE stud21
        SET status = 'D'
        WHERE roll = student_rec.roll;

        -- Maintain records in the D_Stud table
        INSERT INTO D_Stud (roll, detention_date)
        VALUES (student_rec.roll, v_detention_date);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Detained students marked and records maintained.');
END;
/
```

In these PL/SQL blocks, we perform the required actions based on specific conditions and maintain records in corresponding tables. These examples demonstrate how to handle different scenarios using PL/SQL.

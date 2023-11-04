
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
stud21(roll number(4), att number(4), status varchar(1));
Certainly, here are the SQL blocks with explicit cursors for each scenario, along with the creation of the tables and data insertion:

1. Create the `account` table and insert sample data:

```sql
CREATE TABLE account (
    account_id NUMBER,
    last_transaction_date DATE,
    status VARCHAR2(10)
);

INSERT INTO account (account_id, last_transaction_date, status)
VALUES (1, TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'Inactive');
```

2. Create the `employee` table and insert sample data:

```sql
CREATE TABLE employee (
    employee_id NUMBER,
    salary NUMBER
);

INSERT INTO employee (employee_id, salary)
VALUES (1, 50000);
```

3. Create the `stud21` table and insert sample data:

```sql
CREATE TABLE stud21 (
    roll NUMBER(4),
    att NUMBER(4),
    status VARCHAR2(1)
);

INSERT INTO stud21 (roll, att, status)
VALUES (1, 80, 'A');

INSERT INTO stud21 (roll, att, status)
VALUES (2, 70, 'P');
```

Now, let's write SQL blocks with explicit cursors for each scenario:

a) Bank Account Activation (Explicit Cursor):

```sql
DECLARE
    v_rows_affected NUMBER := 0;
    v_account_id NUMBER;
    CURSOR inactive_accounts_cursor IS
        SELECT account_id
        FROM account
        WHERE last_transaction_date < (SYSDATE - 365);
BEGIN
    FOR account_rec IN inactive_accounts_cursor LOOP
        v_account_id := account_rec.account_id;

        -- Update the status of inactive accounts
        UPDATE account
        SET status = 'Active'
        WHERE account_id = v_account_id;

        -- Increment the rows affected count
        v_rows_affected := v_rows_affected + 1;
    END;

    IF v_rows_affected > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Accounts updated: ' || v_rows_affected);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No accounts were updated.');
    END IF;
END;
/
```

b) Employee Salary Increase (Explicit Cursor):

```sql
DECLARE
    v_avg_salary NUMBER;
    CURSOR eligible_employees_cursor IS
        SELECT employee_id, salary
        FROM employee
        WHERE salary < (SELECT AVG(salary) FROM employee);
BEGIN
    -- Calculate the average salary of the organization
    SELECT AVG(salary) INTO v_avg_salary FROM employee;

    FOR employee_rec IN eligible_employees_cursor LOOP
        -- Update salaries for employees with salary less than the average
        UPDATE employee
        SET salary = salary * 1.10
        WHERE employee_id = employee_rec.employee_id;

        -- Insert records into increment_salary table (assuming you have one)
        INSERT INTO increment_salary (employee_id, old_salary, new_salary)
        VALUES (employee_rec.employee_id, employee_rec.salary, employee_rec.salary * 1.10);
    END;
END;
/
```

c) Student Attendance (Explicit Cursor):

```sql
DECLARE
    v_attendance_threshold NUMBER := 75;
    CURSOR detained_students_cursor IS
        SELECT roll, att
        FROM stud21
        WHERE att < v_attendance_threshold;
BEGIN
    FOR student_rec IN detained_students_cursor LOOP
        -- Update status to 'D' for students with attendance less than 75%
        UPDATE stud21
        SET status = 'D'
        WHERE roll = student_rec.roll;

        -- Insert records into the D_Stud table (assuming you have one)
        INSERT INTO D_Stud (roll, att)
        VALUES (student_rec.roll, student_rec.att);
    END;
END;
/
```

You can run these SQL blocks in most relational database management systems (RDBMS) that support SQL. Make sure to adjust table and column names to match your actual schema.

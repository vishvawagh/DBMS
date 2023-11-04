
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

```plsql
DECLARE
   v_rows_affected NUMBER := 0;
BEGIN
   -- Update the status of inactive accounts to 'Active'
   UPDATE your_account_table
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

In this PL/SQL block, we update the status of accounts that meet the criteria and then use the `SQL%ROWCOUNT` attribute to determine how many rows were affected by the update. We display a message based on the number of rows updated.

b) Here is a PL/SQL block that increases the salary of employees by 10% of their existing salary if their salary is less than the average salary of the organization. It also maintains a record of the salary increment in the `increment_salary` table:

```plsql
DECLARE
   v_average_salary NUMBER;
   v_increment_amount NUMBER;
BEGIN
   -- Calculate the average salary of the organization
   SELECT AVG(salary) INTO v_average_salary
   FROM employee_table;

   -- Update the salary of employees who have a salary less than the average
   FOR employee_rec IN (SELECT employee_id, salary FROM employee_table WHERE salary < v_average_salary) LOOP
      v_increment_amount := 0.10 * employee_rec.salary; -- 10% increment
      -- Update the employee's salary
      UPDATE employee_table
      SET salary = salary + v_increment_amount
      WHERE employee_id = employee_rec.employee_id;
      -- Insert a record in the increment_salary table
      INSERT INTO increment_salary (employee_id, increment_amount, increment_date)
      VALUES (employee_rec.employee_id, v_increment_amount, SYSDATE);
   END LOOP;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Salary increments have been applied.');
END;
/
```

In this PL/SQL block, we calculate the average salary of the organization, and then, using a cursor, we update the salary of employees who have a salary less than the average. We also insert a record in the `increment_salary` table for each salary increment.

c) Here is a PL/SQL block that uses an explicit cursor to mark students as detained (D) if their attendance is less than 75%. It also maintains a record of such updates in the `D_Stud` table:

```plsql
DECLARE
   CURSOR stud_cursor IS
      SELECT roll, att
      FROM stud21
      WHERE att < 75;

   v_roll_number stud21.roll%TYPE;
   v_attendance stud21.att%TYPE;
BEGIN
   FOR stud_rec IN stud_cursor LOOP
      v_roll_number := stud_rec.roll;
      v_attendance := stud_rec.att;

      -- Mark the student as detained (D)
      UPDATE stud21
      SET status = 'D'
      WHERE roll = v_roll_number;

      -- Insert a record in the D_Stud table
      INSERT INTO D_Stud (roll, attendance_date, status)
      VALUES (v_roll_number, SYSDATE, 'D');
   END LOOP;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Students with attendance less than 75% have been marked as detained.');
END;
/
```

In this PL/SQL block, we use an explicit cursor to select students with attendance less than 75% and then update their status to 'D' and insert a record in the `D_Stud` table for each student.
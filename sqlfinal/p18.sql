18.Trigger
a) Write a update, delete trigger on clientmstr table. The System should keep track of the
records that ARE BEING updated or deleted. The old value of updated or deleted records
should be added in audit_trade table. (separate implementation using both row and statement
triggers).
b) Write a before trigger for Insert, update event considering following requirement:
Emp(e_no, e_name, salary) I) Trigger action should be initiated when salary is tried to be
inserted is less than Rs. 50,000/- II) Trigger action should be initiated when salary is tried to be
updated for value less than Rs. 50,000/- Action should be rejection of update or Insert
operation by displaying appropriate error message. Also the new values expected to be inserted
will be stored in new table Tracking(e_no, salary).
a) Here's how you can create an update trigger and a delete trigger on the `clientmstr` table to keep track of the records that are being updated or deleted and add the old values to the `audit_trade` table:

1. Using a Row-Level Update Trigger:
```sql
CREATE OR REPLACE TRIGGER update_audit_trigger
BEFORE UPDATE ON clientmstr
FOR EACH ROW
BEGIN
   IF :OLD.status <> :NEW.status THEN
      -- Add the old value to the audit_trade table
      INSERT INTO audit_trade (client_id, old_status, update_time)
      VALUES (:OLD.client_id, :OLD.status, SYSTIMESTAMP);
   END IF;
END;
/

CREATE OR REPLACE TRIGGER delete_audit_trigger
BEFORE DELETE ON clientmstr
FOR EACH ROW
BEGIN
   -- Add the old value to the audit_trade table
   INSERT INTO audit_trade (client_id, old_status, update_time)
   VALUES (:OLD.client_id, :OLD.status, SYSTIMESTAMP);
END;
/
```

In this trigger, the `update_audit_trigger` will fire before each row is updated, and if the `status` field is changed, it will add the old status and the timestamp of the update to the `audit_trade` table. The `delete_audit_trigger` will fire before each row is deleted and add the old status and timestamp to the `audit_trade` table.

2. Using a Statement-Level Update Trigger:
```sql
CREATE OR REPLACE TRIGGER update_audit_trigger
AFTER UPDATE ON clientmstr
DECLARE
   v_client_id clientmstr.client_id%TYPE;
BEGIN
   -- Use the FOR EACH ROW to check which rows were updated
   FOR updated_row IN (SELECT client_id FROM clientmstr WHERE status <> :NEW.status) LOOP
      v_client_id := updated_row.client_id;
      -- Add the old value to the audit_trade table
      INSERT INTO audit_trade (client_id, old_status, update_time)
      VALUES (v_client_id, (SELECT status FROM clientmstr WHERE client_id = v_client_id), SYSTIMESTAMP);
   END LOOP;
END;
/

CREATE OR REPLACE TRIGGER delete_audit_trigger
AFTER DELETE ON clientmstr
BEGIN
   -- Use the FOR EACH ROW to check which rows were deleted
   FOR deleted_row IN (SELECT client_id FROM clientmstr WHERE client_id = :OLD.client_id) LOOP
      -- Add the old value to the audit_trade table
      INSERT INTO audit_trade (client_id, old_status, update_time)
      VALUES (deleted_row.client_id, :OLD.status, SYSTIMESTAMP);
   END LOOP;
END;
/
```

In this trigger, the `update_audit_trigger` will fire after the update statement is executed, and it will use a FOR EACH ROW loop to identify which rows were updated and add the old status and timestamp to the `audit_trade` table. The `delete_audit_trigger` will fire after the delete statement and add the old status and timestamp for the deleted row.

b) Here's a before trigger that prevents inserting or updating a salary less than Rs. 50,000 in the `Emp` table and stores the new values in the `Tracking` table:

```sql
CREATE OR REPLACE TRIGGER salary_check_trigger
BEFORE INSERT OR UPDATE OF salary ON Emp
FOR EACH ROW
DECLARE
   v_error_message VARCHAR2(200);
BEGIN
   IF :NEW.salary < 50000 THEN
      v_error_message := 'Salary must be at least Rs. 50,000.';
      RAISE_APPLICATION_ERROR(-20001, v_error_message);
   END IF;

   IF INSERTING THEN
      -- Insert the new values into the Tracking table
      INSERT INTO Tracking (e_no, salary)
      VALUES (:NEW.e_no, :NEW.salary);
   ELSIF UPDATING THEN
      -- Update the new values in the Tracking table
      UPDATE Tracking
      SET salary = :NEW.salary
      WHERE e_no = :NEW.e_no;
   END IF;
END;
/
```

In this trigger, we use a `BEFORE INSERT OR UPDATE` trigger to check the salary value before it is inserted or updated in the `Emp` table. If the salary is less than Rs. 50,000, an error message is raised, preventing the operation. Additionally, for insertions, the new values are stored in the `Tracking` table, and for updates, the values are updated in the `Tracking` table.
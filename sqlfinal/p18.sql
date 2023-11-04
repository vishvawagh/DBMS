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
a) Implementation of update and delete triggers with separate row and statement triggers to track changes in the `clientmstr` table and add old values to the `audit_trade` table:

```sql
-- Create the clientmstr and audit_trade tables for testing
CREATE TABLE clientmstr (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    client_status VARCHAR(1)
);

CREATE TABLE audit_trade (
    client_id INT,
    action_type VARCHAR(10),
    old_client_name VARCHAR(100),
    old_client_status VARCHAR(1),
    audit_timestamp TIMESTAMP
);

-- Sample data for testing
INSERT INTO clientmstr (client_id, client_name, client_status) VALUES (1, 'Client A', 'A');
INSERT INTO clientmstr (client_id, client_name, client_status) VALUES (2, 'Client B', 'I');
INSERT INTO clientmstr (client_id, client_name, client_status) VALUES (3, 'Client C', 'A');

-- Update trigger to track changes and add old values to audit_trade
CREATE OR REPLACE TRIGGER update_clientmstr_trigger
AFTER UPDATE ON clientmstr
FOR EACH ROW
BEGIN
    IF :OLD.client_name != :NEW.client_name OR :OLD.client_status != :NEW.client_status THEN
        INSERT INTO audit_trade (client_id, action_type, old_client_name, old_client_status, audit_timestamp)
        VALUES (:OLD.client_id, 'UPDATE', :OLD.client_name, :OLD.client_status, SYSTIMESTAMP);
    END IF;
END;
/

-- Delete trigger to track changes and add old values to audit_trade
CREATE OR REPLACE TRIGGER delete_clientmstr_trigger
BEFORE DELETE ON clientmstr
FOR EACH ROW
BEGIN
    INSERT INTO audit_trade (client_id, action_type, old_client_name, old_client_status, audit_timestamp)
    VALUES (:OLD.client_id, 'DELETE', :OLD.client_name, :OLD.client_status, SYSTIMESTAMP);
END;
/
```

In this implementation, the `update_clientmstr_trigger` and `delete_clientmstr_trigger` triggers track changes in the `clientmstr` table and add old values to the `audit_trade` table when updates or deletions occur.

b) Implementation of a before trigger to reject insert or update operations with salary less than Rs. 50,000 and store new values in the `Tracking` table:

```sql
-- Create the Emp and Tracking tables for testing
CREATE TABLE Emp (
    e_no INT PRIMARY KEY,
    e_name VARCHAR(100),
    salary NUMBER(10, 2)
);

CREATE TABLE Tracking (
    e_no INT PRIMARY KEY,
    salary NUMBER(10, 2)
);

-- Sample data for testing
INSERT INTO Emp (e_no, e_name, salary) VALUES (1, 'Employee A', 55000);
INSERT INTO Emp (e_no, e_name, salary) VALUES (2, 'Employee B', 48000);

-- Before trigger to reject insert or update with salary less than Rs. 50,000 and store new values in Tracking
CREATE OR REPLACE TRIGGER salary_check_trigger
BEFORE INSERT OR UPDATE ON Emp
FOR EACH ROW
BEGIN
    IF :NEW.salary < 50000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be less than Rs. 50,000');
    ELSE
        IF INSERTING THEN
            INSERT INTO Tracking (e_no, salary)
            VALUES (:NEW.e_no, :NEW.salary);
        ELSIF UPDATING THEN
            INSERT INTO Tracking (e_no, salary)
            VALUES (:NEW.e_no, :NEW.salary);
        END IF;
    END IF;
END;
/
```

In this implementation, the `salary_check_trigger` before trigger checks if the salary is less than Rs. 50,000 and raises an error if it is. It also stores the new values in the `Tracking` table for insert and update operations.

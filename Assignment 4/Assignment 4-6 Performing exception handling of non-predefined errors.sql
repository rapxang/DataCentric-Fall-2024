ALTER TABLE BB_BASKETITEM
ADD CONSTRAINT check_quantity CHECK (QUANTITY <= 20);
DECLARE
    -- Declare a variable to hold the insert values.
    lv_item_id      BB_BASKETITEM.IDBASKETITEM%TYPE;
    lv_quantity     BB_BASKETITEM.QUANTITY%TYPE;
BEGIN
    -- Assign values to the variables (use a quantity greater than 20 to test the constraint).
    lv_item_id := 10;     -- Example item_id (you can adjust as per the actual data).
    lv_quantity := 25;     -- Quantity greater than 20 to trigger the constraint violation.

    -- Try to insert a new record into BB_BASKETITEM table
    BEGIN
        INSERT INTO BB_BASKETITEM (IDBASKETITEM, QUANTITY)
        VALUES (lv_item_id, lv_quantity);
        -- If the insert is successful, commit the transaction
        COMMIT;
    EXCEPTION
        -- Catch the constraint violation error (ORA-02290: check constraint violation)
        WHEN OTHERS THEN
            IF SQLCODE = -2290 THEN
                DBMS_OUTPUT.PUT_LINE('Check Quantity!');
            ELSE
                -- If a different error occurs, raise the exception
                RAISE;
            END IF;
    END;
END;
/


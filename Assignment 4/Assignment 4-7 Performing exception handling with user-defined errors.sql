DECLARE
    G_OLD NUMBER := 30;  -- Original basket ID
    G_NEW NUMBER := 4;   -- New basket ID
    v_count NUMBER;      -- Variable to hold the row count
BEGIN
    -- Check if any rows exist with the old basket ID (G_OLD)
    SELECT COUNT(*) INTO v_count
    FROM BB_BASKETITEM
    WHERE IDBASKETITEM = G_OLD;

    -- If no rows exist for G_OLD, raise a custom exception
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid original basket id.');
    END IF;

    -- Update the BB_BASKETITEM table to combine baskets
    UPDATE BB_BASKETITEM
    SET IDBASKETITEM = G_NEW
    WHERE IDBASKETITEM = G_OLD;

    -- Check how many rows were updated
    IF SQL%ROWCOUNT = 0 THEN
        -- If no rows were affected, raise an error
        RAISE_APPLICATION_ERROR(-20001, 'Invalid original basket id.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('IDBASKETITEM  ' || G_OLD || ' successfully combined with ' || G_NEW || '.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Display error message for any other exceptions
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE STATUS_SP (
    p_basket_id    IN NUMBER,        -- Input basket ID
    p_status_desc  OUT VARCHAR2,      -- Output status description
    p_status_date  OUT VARCHAR2       -- Output status date in string format
) IS
    v_stage_desc  VARCHAR2(100);      -- Local variable to hold stage description
BEGIN
    -- Query to get the most recent status for the given basket_id
    SELECT CASE IDSTAGE
               WHEN 1 THEN 'Submitted and received'
               WHEN 2 THEN 'Confirmed, processed, sent to shipping'
               WHEN 3 THEN 'Shipped'
               WHEN 4 THEN 'Cancelled'
               WHEN 5 THEN 'Backordered'
               ELSE 'Unknown'
           END AS status_desc,
           TO_CHAR(DTSTAGE, 'DD-MON-YYYY') AS status_date  -- Convert date to string
    INTO p_status_desc, p_status_date
    FROM BB_BASKETSTATUS
    WHERE IDBASKET = p_basket_id
    ORDER BY DTSTAGE DESC -- Get the most recent status
    FETCH FIRST ROW ONLY; -- Limit to just the most recent entry
    
    -- If no status was found, return an appropriate message
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_status_desc := 'No status available for this basket.';
            p_status_date := NULL; -- No date if no status is found
        WHEN OTHERS THEN
            -- Handle any other unexpected errors
            p_status_desc := 'Error occurred: ' || SQLERRM;
            p_status_date := NULL; -- No date in case of an error
END STATUS_SP;
/
DECLARE
    v_status_desc VARCHAR2(100);
    v_status_date VARCHAR2(20);
BEGIN
    STATUS_SP(p_basket_id => 3,
    p_status_desc => v_status_desc, 
    p_status_date => v_status_date);
    DBMS_OUTPUT.PUT_LINE('Status of Basket ID-4 : ' || v_status_desc);
    DBMS_OUTPUT.PUT_LINE('Status Date: ' || v_status_date);
END;
/
DECLARE
    v_status_desc VARCHAR2(100);
    v_status_date VARCHAR2(20);
BEGIN
    STATUS_SP(p_basket_id => 6,
    p_status_desc => v_status_desc, 
    p_status_date => v_status_date);
    DBMS_OUTPUT.PUT_LINE('Status of Basket ID-6 : ' || v_status_desc);
    DBMS_OUTPUT.PUT_LINE('Status Date: ' || v_status_date);
END;
/

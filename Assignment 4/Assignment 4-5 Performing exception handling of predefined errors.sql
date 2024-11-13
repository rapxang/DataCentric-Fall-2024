DECLARE
    G_SHOPPER NUMBER(5);  -- Host variable for shopper ID
    lv_customer_name VARCHAR2(100);
    lv_customer_address VARCHAR2(100);
    lv_customer_email VARCHAR2(100);
    lv_customer_phone NUMBER;
BEGIN
    G_SHOPPER := 99;

    -- Attempt to fetch customer details using the provided shopper ID
    SELECT FIRSTNAME, ADDRESS, EMAIL, PHONE
    INTO lv_customer_name, lv_customer_address, lv_customer_email,lv_customer_phone
    FROM BB_SHOPPER
    WHERE IDSHOPPER = G_SHOPPER;
    
    -- Display customer info if no exception is thrown
    DBMS_OUTPUT.PUT_LINE('Customer Name: ' || lv_customer_name);
    DBMS_OUTPUT.PUT_LINE('Customer Address: ' || lv_customer_address);
    DBMS_OUTPUT.PUT_LINE('Customer Email: ' || lv_customer_email);
    DBMS_OUTPUT.PUT_LINE('Customer Phone: ' || lv_customer_phone);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where no customer is found for the shopper ID
        DBMS_OUTPUT.PUT_LINE('Invalid shopper id');
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred');
END;



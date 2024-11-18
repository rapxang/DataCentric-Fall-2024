CREATE OR REPLACE PROCEDURE STATUS_SHIP_SP (
    p_basket_number   IN NUMBER,
    p_date_shipped    IN DATE,
    p_shipper         IN VARCHAR2,
    p_tracking_number IN VARCHAR2
) IS
BEGIN
    -- Insert a new row into the BB_BASKETSTATUS table to update status
    INSERT INTO BB_BASKETSTATUS (
        IDSTATUS,      -- Primary key
        IDBASKET,      -- Foreign key to BB_BASKET (assumed column)
        IDSTAGE,       -- Stage ID for "shipped" (3 is used here)
        DTSTAGE,       -- Date the item was shipped
        SHIPPER,       -- The shipping company
        SHIPPINGNUM    -- Tracking number
    )
    VALUES (
        BB_STATUS_SEQ.NEXTVAL,  -- Generate a new primary key from the sequence
        p_basket_number,        -- Basket ID from the input parameter
        3,                       -- Stage ID '3' represents shipped status
        p_date_shipped,         -- Date the item was shipped (input parameter)
        p_shipper,              -- Shipping company (input parameter)
        p_tracking_number       -- Tracking number (input parameter)
    );

    -- Commit the transaction if no error occurred
    COMMIT;

    -- Optionally log a success message (useful during debugging or monitoring)
    DBMS_OUTPUT.PUT_LINE('Basket ' || p_basket_number || ' has been successfully updated to "Shipped" status.');
    
EXCEPTION
    WHEN OTHERS THEN
        -- Rollback any changes if an error occurs
        ROLLBACK;

        -- Log the error message to the output for debugging
        DBMS_OUTPUT.PUT_LINE('Error occurred while updating basket ' || p_basket_number || ': ' || SQLERRM);

        -- Optionally, raise the error again for further handling in the calling program
        -- RAISE;
END STATUS_SHIP_SP;
/


--Exception Procedure:
BEGIN
    STATUS_SHIP_SP(
        p_basket_number   => 3,
        p_date_shipped    => TO_DATE('20-FEB-07', 'DD-MON-YY'),
        p_shipper         => 'UPS',
        p_tracking_number => 'ZW2384YXK4957'
    );
END;
/


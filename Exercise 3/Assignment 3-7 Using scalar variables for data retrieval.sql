DECLARE
    -- Host variable for the basket ID 
    lv_basket_id       NUMBER := 12;  
    
    -- Scalar variables to store retrieved values
    lv_subtotal        NUMBER;
    lv_shipping        NUMBER;
    lv_tax             NUMBER;
    lv_total           NUMBER;
BEGIN
    -- Retrieve the order summary data using the provided basket_id
    SELECT  subtotal, shipping,tax, total
    INTO lv_subtotal,lv_shipping,lv_tax,lv_total
    FROM bb_basket
    WHERE idbasket = lv_basket_id;
    
    -- Output the order summary information
    DBMS_OUTPUT.PUT_LINE('Order Summary for Basket ID: ' || lv_basket_id);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    DBMS_OUTPUT.PUT_LINE('Subtotal: $' || TO_CHAR(lv_subtotal, '999.99'));
    DBMS_OUTPUT.PUT_LINE('Shipping: $' || TO_CHAR(lv_shipping, '999.99'));
    DBMS_OUTPUT.PUT_LINE('Tax: $' || TO_CHAR(lv_tax, '999.99'));
    DBMS_OUTPUT.PUT_LINE('Total: $' || TO_CHAR(lv_total, '999.99'));
    
END;

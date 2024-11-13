DECLARE
    -- Host variable for the basket ID
    lv_basket_id       NUMBER := 12;  -- Change this for testing with different basket IDs

    -- Record type to store the basket data (IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL)
    TYPE basket_record IS RECORD (
        lv_idbasket  NUMBER,
        lv_subtotal  NUMBER,
        lv_shipping  NUMBER,
        lv_tax       NUMBER,
        lv_total     NUMBER
    );

    -- Record variable to hold the data for the basket
    basket_info basket_record;

BEGIN
    -- Retrieve the order summary data using the provided basket_id
    SELECT idbasket, subtotal, shipping, tax, total
    INTO basket_info.lv_idbasket, basket_info.lv_subtotal, basket_info.lv_shipping, basket_info.lv_tax, basket_info.lv_total
    FROM bb_basket
    WHERE idbasket = lv_basket_id;

    -- Output the order summary information
    DBMS_OUTPUT.PUT_LINE('Order Summary for Basket ID: ' || basket_info.lv_idbasket);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    DBMS_OUTPUT.PUT_LINE('Subtotal: $' || TO_CHAR(basket_info.lv_subtotal, '999.99'));
    DBMS_OUTPUT.PUT_LINE('Shipping: $' || TO_CHAR(basket_info.lv_shipping, '999.99'));
    DBMS_OUTPUT.PUT_LINE('Tax: $' || TO_CHAR(basket_info.lv_tax, '999.99'));
    DBMS_OUTPUT.PUT_LINE('Total: $' || TO_CHAR(basket_info.lv_total, '999.99'));

END;

DECLARE
    lv_basket_id      NUMBER := 5;   -- Host variable for basket_id, change for testing with other basket IDs (e.g., 12)
    lv_quantity        NUMBER;         -- Variable to store the quantity of items in the basket
    lv_shipping_cost   NUMBER;         -- Variable to store the calculated shipping cost
BEGIN
    -- Retrieve the quantity of items in the basket using the basket_id
    SELECT quantity INTO lv_quantity
    FROM bb_basket
    WHERE idbasket = lv_basket_id;
    
    -- Check if quantity is found
    IF lv_quantity IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Basket not found');
        RETURN;
    END IF;
    
    -- Determine the shipping cost based on the quantity using IF-ELSE or CASE statement
    IF lv_quantity <= 3 THEN
        lv_shipping_cost := 5.00;
    ELSIF lv_quantity BETWEEN 4 AND 6 THEN
        lv_shipping_cost := 7.50;
    ELSIF lv_quantity BETWEEN 7 AND 10 THEN
        lv_shipping_cost := 10.00;
    ELSE
        lv_shipping_cost := 12.00;
    END IF;
    
    -- Display the shipping cost
    DBMS_OUTPUT.PUT_LINE('Basket ID: ' || lv_basket_id);
    DBMS_OUTPUT.PUT_LINE('Quantity of items: ' || lv_quantity);
    DBMS_OUTPUT.PUT_LINE('Calculated shipping cost: $' || lv_shipping_cost);
    
END;


DECLARE
    lv_total_spent   NUMBER := 100;  -- Host variable for total spending amount
    lv_product_id    NUMBER := 4;    -- Host variable for the product ID
    lv_price         NUMBER;         -- Variable to store the price of the selected product
    lv_items_purchased NUMBER := 0;  -- Counter for the number of items that can be bought
BEGIN
    -- Fetch the price of the product using the provided product_id
    SELECT price INTO lv_price
    FROM bb_product
    WHERE idproduct = lv_product_id;
    
    -- Ensure we found the product and have a valid price
    IF lv_price IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Product not found');
        RETURN;
    END IF;
    
    -- Use a WHILE loop to calculate how many items can be bought
    WHILE lv_total_spent >= lv_price LOOP
        lv_total_spent := lv_total_spent - lv_price;  -- Deduct the price of one item from total_spent
        lv_items_purchased := lv_items_purchased + 1;  -- Increment the item count
    END LOOP;
    
    -- Output the result
    DBMS_OUTPUT.PUT_LINE('Items that can be purchased: ' || lv_items_purchased);
    DBMS_OUTPUT.PUT_LINE('Remaining money: $' || lv_total_spent);
    
END;

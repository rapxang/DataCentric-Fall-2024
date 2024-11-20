CREATE OR REPLACE FUNCTION ORD_SHIP_SF(basket_id IN NUMBER)
RETURN VARCHAR2
IS
  order_date DATE;
  shipping_date DATE;
  days_diff NUMBER;
BEGIN
  -- Get the order date from the BB_BASKET table
  SELECT DTORDERED
  INTO order_date
  FROM BB_BASKET
  WHERE IDBASKET = basket_id;

  -- Get the shipping date from the BB_BASKETSTATUS table (where IDSTAGE = 5 indicates the item was shipped)
  SELECT DTSTAGE
  INTO shipping_date
  FROM BB_BASKETSTATUS
  WHERE IDBASKET = basket_id
    AND IDSTAGE = 5;

  -- Calculate the difference in days between the order date and the shipping date
  days_diff := shipping_date - order_date;

  -- Return 'OK' if shipped within a day, otherwise return 'CHECK'
  IF days_diff <= 1 THEN
    RETURN 'OK';
  ELSE
    RETURN 'CHECK';
  END IF;
END ORD_SHIP_SF;
/

SET SERVEROUTPUT ON;

DECLARE
  -- Declare a variable for the basket ID (host variable for basket 3)
  basket_id NUMBER := 3;
  result VARCHAR2(7);  -- Variable to hold the result ('OK' or 'CHECK')
BEGIN
  -- Call the ORD_SHIP_SF function to check the shipping status
  result := ORD_SHIP_SF(basket_id);

  -- Output the result using DBMS_OUTPUT
  DBMS_OUTPUT.PUT_LINE('Basket ' || basket_id || ' Shipping Status: ' || result);
END;
/


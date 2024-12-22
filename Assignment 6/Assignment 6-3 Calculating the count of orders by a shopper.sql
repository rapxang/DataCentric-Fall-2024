CREATE OR REPLACE FUNCTION NUM_PURCH_SF(shopper_id IN NUMBER)
RETURN NUMBER
IS
  total_orders NUMBER;
BEGIN
  -- Count the number of orders placed by the given shopper
  SELECT SUM(COOKIE)
  INTO total_orders
  FROM BB_SHOPPER
  WHERE IDSHOPPER = shopper_id;
  
  RETURN total_orders;

END NUM_PURCH_SF;
/
SET SERVEROUTPUT ON;

BEGIN
  -- Declare a variable to hold the result
  DECLARE
    total_orders NUMBER;
  BEGIN
    -- Use a SELECT statement to call the function and output the result with DBMS_OUTPUT
    SELECT NUM_PURCH_SF(23)
    INTO total_orders
    FROM DUAL;

    -- Output the result using DBMS_OUTPUT
    DBMS_OUTPUT.PUT_LINE('Total number of orders for shopper 23: ' || total_orders);
  END;
END;
/


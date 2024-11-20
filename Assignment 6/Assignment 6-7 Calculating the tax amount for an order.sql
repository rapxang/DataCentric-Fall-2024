CREATE OR REPLACE FUNCTION TAX_CALC_S(basket_id IN NUMBER)
RETURN NUMBER
IS
  subtotal NUMBER;  -- Variable to store the subtotal of the basket
  shipping_state VARCHAR2(50);  -- Variable to store the shipping state
  tax_rate NUMBER := 0;  -- Default tax rate is 0
  tax_amount NUMBER;  -- Variable to store the calculated tax amount
BEGIN
  -- Get the subtotal and shipping state from the BB_BASKET table
  SELECT SUBTOTAL, SHIPSTATE
  INTO subtotal, shipping_state
  FROM BB_BASKET
  WHERE IDBASKET = basket_id;

  -- Get the tax rate from the BB_TAX table based on the shipping state
  BEGIN
    SELECT TAXRATE
    INTO tax_rate
    FROM BB_TAX
    WHERE STATE = shipping_state;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- If no tax rate is found for the shipping state, tax_rate will remain 0
      tax_rate := 0;
  END;

  -- Calculate the tax amount
  tax_amount := subtotal * tax_rate;

  -- Return the calculated tax amount
  RETURN tax_amount;
END TAX_CALC_S;
/

SELECT 
  IDBASKET,
  SUBTOTAL,
  SHIPSTATE,
  TAX_CALC_S(IDBASKET) AS TAX_AMOUNT
FROM 
  BB_BASKET
WHERE 
  IDBASKET = 3;


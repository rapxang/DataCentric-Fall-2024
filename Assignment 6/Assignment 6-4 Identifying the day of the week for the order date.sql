CREATE OR REPLACE FUNCTION DAY_ORD_SF(order_date IN DATE)
RETURN VARCHAR2
IS
  day_of_week VARCHAR2(9);  -- Variable to hold the day of the week
BEGIN
  -- Use TO_CHAR with 'DAY' to extract the day of the week from the order_date
  SELECT TO_CHAR(order_date, 'Day')
  INTO day_of_week
  FROM DUAL;
  
  -- Return the day of the week
  RETURN TRIM(day_of_week);  -- TRIM to remove any extra spaces
END DAY_ORD_SF;
/
SET SERVEROUTPUT ON;

BEGIN
  -- Declare a cursor to hold the results
  FOR rec IN (
    SELECT DAY_ORD_SF(DTORDERED) AS DAY_OF_WEEK, COUNT(IDBASKET) AS TOTAL_BASKETS
    FROM BB_BASKET
    GROUP BY DAY_ORD_SF(DTORDERED)
    ORDER BY TOTAL_BASKETS DESC
  )
  LOOP
    -- Output the day of the week and total number of baskets using DBMS_OUTPUT
    DBMS_OUTPUT.PUT_LINE('Day: ' || rec.DAY_OF_WEEK || ' | Total Baskets: ' || rec.TOTAL_BASKETS);
  END LOOP;
END;
/


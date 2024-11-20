CREATE OR REPLACE FUNCTION STATUS_DESC_SF(stage_id IN NUMBER)
RETURN VARCHAR2
IS
  status_description VARCHAR2(100); -- Variable to store the description
BEGIN
  -- Use a CASE statement to return the appropriate status description based on the stage_id
  SELECT CASE stage_id
             WHEN 1 THEN 'Order submitted'
             WHEN 2 THEN 'Accepted, sent to shipping'
             WHEN 3 THEN 'Backordered'
             WHEN 4 THEN 'Cancelled'
             WHEN 5 THEN 'Shipped'
             ELSE 'Unknown status'  -- In case an invalid stage_id is passed
         END
  INTO status_description
  FROM dual;

  -- Return the status description
  RETURN status_description;
END STATUS_DESC_SF;
/

SELECT 
  IDBASKET, 
  DTSTAGE, 
  STATUS_DESC_SF(IDSTAGE) AS STAGE_DESCRIPTION
FROM 
  BB_BASKETSTATUS
WHERE 
  IDBASKET = 4;

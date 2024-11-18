CREATE OR REPLACE PROCEDURE PROMO_SHIP_SP (
    p_cutoff_date IN DATE,            -- The cutoff date for the promotion eligibility
    p_month       IN VARCHAR2,        -- The month for the promotion (e.g., 'APR')
    p_year        IN NUMBER           -- The year for the promotion (e.g., 2007)
) IS
BEGIN
    -- Insert eligible customers into BB_PROMOLIST
    INSERT INTO BB_PROMOLIST (
        IDSHOPPER,      -- Customer ID from the basket
        PROMO_FLAG,       -- Set to 1 for free shipping
        MONTH,      -- Month of the promotion
        YEAR,       -- Year of the promotion
        USED              -- Default 'N', no need to update unless used
    )
    SELECT DISTINCT b.IDSHOPPER,  -- Select unique customers who are eligible for the promotion
           1 AS PROMO_FLAG,        -- Flag for free shipping
           p_month AS MONTH, -- Month of the promotion
           p_year AS YEAR,   -- Year of the promotion
           'N' AS USED             -- Default value for "USED"
    FROM BB_BASKET b
    WHERE b.DTCREATED <= p_cutoff_date    -- Filter for customers who haven't shopped after the cutoff date
    AND NOT EXISTS (
        -- Ensure that the customer hasn't made any purchase after the cutoff date
        SELECT 1
        FROM BB_BASKET b2
        WHERE b2.IDSHOPPER = b.IDSHOPPER
        AND b2.DTCREATED > p_cutoff_date
    );

    -- Commit changes if needed (if not using autocommit)
    COMMIT;

    -- Optionally, you could output the number of records inserted for monitoring
    DBMS_OUTPUT.PUT_LINE('Promotion has been applied to eligible customers for ' || p_month || ' ' || p_year);

EXCEPTION
    WHEN OTHERS THEN
        -- Handle any unexpected errors
        ROLLBACK;  -- Rollback if an error occurs
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END PROMO_SHIP_SP;
/
BEGIN
    PROMO_SHIP_SP(
        p_cutoff_date => TO_DATE('15-FEB-2007', 'DD-MON-YYYY'),
        p_month       => 'APR',
        p_year        => 2007
    );
END;
/

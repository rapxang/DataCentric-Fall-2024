
--Step 1: Define the Package Specification
CREATE OR REPLACE PACKAGE TAX_RATE_PKG IS
    -- Declare a cursor to fetch tax rates and states
    CURSOR cur_tax_rates IS
        SELECT STATE, TAXRATE
        FROM BB_TAX;

    -- Declare a function to fetch the tax rate by state abbreviation
    FUNCTION get_tax_rate_by_state(p_state_abbr IN VARCHAR2) RETURN NUMBER;
END TAX_RATE_PKG;
/

--Step 2: Define the Package Body
CREATE OR REPLACE PACKAGE BODY TAX_RATE_PKG IS
    -- Function to fetch the tax rate by state abbreviation
    FUNCTION get_tax_rate_by_state(p_state_abbr IN VARCHAR2) RETURN NUMBER IS
        v_tax_rate NUMBER;
    BEGIN
        -- Open the cursor and loop through it to find the tax rate
        FOR rec IN cur_tax_rates LOOP
            IF rec.STATE = p_state_abbr THEN
                v_tax_rate := rec.TAXRATE;
                RETURN v_tax_rate;
            END IF;
        END LOOP;

        -- If no matching state is found, raise an exception
        RAISE_APPLICATION_ERROR(-20001, 'State not found or no tax rate available.');
    END get_tax_rate_by_state;
END TAX_RATE_PKG;
/

--Step 3: Test the Function Using an Anonymous PL/SQL Block
DECLARE
    v_tax_rate NUMBER;
BEGIN
    -- Call the function with state abbreviation 'NC' to fetch the tax rate
    v_tax_rate := TAX_RATE_PKG.get_tax_rate_by_state('NC');

    -- Output the tax rate
    DBMS_OUTPUT.PUT_LINE('Tax rate for NC: ' || v_tax_rate);
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any exceptions
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

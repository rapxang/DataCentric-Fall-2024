CREATE OR REPLACE PACKAGE LOGIN_PKG IS
    -- Declare the packaged variables
    shopper_id NUMBER;
    zip_code VARCHAR2(3);  -- Only store the first 3 digits of the zip code
    
    -- Declare the function to verify user credentials
    FUNCTION verify_user_credentials(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2
    ) RETURN VARCHAR2;
END LOGIN_PKG;
/
CREATE OR REPLACE PACKAGE BODY LOGIN_PKG IS
    -- Function to verify user credentials
    FUNCTION verify_user_credentials (
        p_username IN VARCHAR2,
        p_password IN VARCHAR2
    ) RETURN VARCHAR2 IS
        v_shopper_id NUMBER;
        v_zip_code VARCHAR2(10);
        v_return_value VARCHAR2(1) := 'N';
    BEGIN
        -- Verify the username and password against the database
        BEGIN
            SELECT IDSHOPPER, ZIPCODE
            INTO v_shopper_id, v_zip_code
            FROM BB_SHOPPER
            WHERE USERNAME = p_username
              AND PASSWORD = p_password;
            
            -- If the query is successful, set the return value to 'Y'
            v_return_value := 'Y';
            
            -- Store the shopper ID and the first 3 digits of the ZIP code in the package variables
            LOGIN_PKG.shopper_id := v_shopper_id;
            LOGIN_PKG.zip_code := SUBSTR(v_zip_code, 1, 3);
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle invalid logon credentials
                DBMS_OUTPUT.PUT_LINE('Invalid username or password');
                RETURN v_return_value;
        END;
        
        -- Return the result
        RETURN v_return_value;
    END verify_user_credentials;
END LOGIN_PKG;
/
VARIABLE G_CK CHAR;

-- Call the packaged function to verify login
EXEC :G_CK := LOGIN_PKG.verify_user_credentials('gma1', 'goofy');

-- Print the login success status (using DBMS_OUTPUT)
PRINT :G_CK;

BEGIN
    -- Output the login success status (using DBMS_OUTPUT)
    DBMS_OUTPUT.PUT_LINE('Login success status: ' || :G_CK);
    
    -- Output the stored values in the package variables
    DBMS_OUTPUT.PUT_LINE('Stored Shopper ID: ' || LOGIN_PKG.shopper_id);
    DBMS_OUTPUT.PUT_LINE('Stored Zip Code (First 3 digits): ' || LOGIN_PKG.zip_code);
END;
/

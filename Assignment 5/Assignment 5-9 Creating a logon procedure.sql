CREATE OR REPLACE PROCEDURE MEMBER_CK_SP (
    p_username   IN VARCHAR2,      -- Username input
    p_password   IN VARCHAR2,      -- Password input (also used to return name)
    p_member_name OUT VARCHAR2,    -- Full name to be returned (First + Last)
    p_cookie_value OUT VARCHAR2,   -- Cookie value to be returned
    p_check      OUT VARCHAR2      -- Return 'INVALID' if login fails
) IS
BEGIN
    -- Initialize the P_CHECK parameter to 'INVALID' by default
    p_check := 'INVALID';
    
    -- Check for valid logon by querying the BB_SHOPPER table
    SELECT FIRSTNAME || ' ' || LASTNAME AS member_name, COOKIE
    INTO p_member_name, p_cookie_value
    FROM BB_SHOPPER
    WHERE USERNAME = p_username  -- Assuming MEMBER_ID is used as username
      AND PASSWORD = p_password;  -- Match the password
    
    -- If a valid match is found, the member's full name and cookie value will be returned
    p_check := 'VALID';  -- Indicate successful login if no error occurs
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- If no match is found, the logon is invalid
        p_member_name := NULL;
        p_cookie_value := NULL;
        -- p_check is already 'INVALID' by default
    WHEN OTHERS THEN
        -- Handle any unexpected errors
        p_member_name := NULL;
        p_cookie_value := NULL;
        p_check := 'INVALID';  -- In case of any other errors, mark as invalid
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END MEMBER_CK_SP;
/

--Execution Procedure
DECLARE
    v_member_name VARCHAR2(100);
    v_cookie_value VARCHAR2(100);
    v_check VARCHAR2(10);
BEGIN
    MEMBER_CK_SP(
        p_username   => 'rat55',     -- Valid username
        p_password   => 'kile',      -- Valid password
        p_member_name => v_member_name,
        p_cookie_value => v_cookie_value,
        p_check      => v_check
    );
    
    -- Output the result
    DBMS_OUTPUT.PUT_LINE('Logon Status: ' || v_check);
    DBMS_OUTPUT.PUT_LINE('Member Name: ' || v_member_name);
    DBMS_OUTPUT.PUT_LINE('Cookie Value: ' || v_cookie_value);
END;
/



--Execution Procedure
DECLARE
    v_member_name VARCHAR2(100);
    v_cookie_value VARCHAR2(100);
    v_check VARCHAR2(10);
BEGIN
    MEMBER_CK_SP(
        p_username   => 'rat',     -- Valid username
        p_password   => 'kile',      -- Valid password
        p_member_name => v_member_name,
        p_cookie_value => v_cookie_value,
        p_check      => v_check
    );
    
    -- Output the result
    DBMS_OUTPUT.PUT_LINE('Logon Status: ' || v_check);
    DBMS_OUTPUT.PUT_LINE('Member Name: ' || v_member_name);
    DBMS_OUTPUT.PUT_LINE('Cookie Value: ' || v_cookie_value);
END;
/
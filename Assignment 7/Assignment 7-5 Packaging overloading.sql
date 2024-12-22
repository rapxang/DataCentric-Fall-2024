-- Package Specification
CREATE OR REPLACE PACKAGE SHOP_QUERY_PKG IS
    -- Declare procedure to retrieve shopper info by shopper id
    PROCEDURE get_shopper_info_by_id (
        p_shopper_id IN NUMBER,
        p_first_name OUT VARCHAR2,
        p_last_name OUT VARCHAR2,
        p_city OUT VARCHAR2,
        p_state OUT VARCHAR2,
        p_phone OUT VARCHAR2,
        p_email OUT VARCHAR2
    );

    -- Declare procedure to retrieve shopper info by last name
    PROCEDURE get_shopper_info_by_last_name (
        p_last_name IN VARCHAR2,
        p_first_name OUT VARCHAR2,
        p_last_name_out OUT VARCHAR2,  -- Renamed OUT parameter for clarity
        p_city OUT VARCHAR2,
        p_state OUT VARCHAR2,
        p_phone OUT VARCHAR2,
        p_email OUT VARCHAR2
    );
END SHOP_QUERY_PKG;
/
-- Package Body
CREATE OR REPLACE PACKAGE BODY SHOP_QUERY_PKG IS

    -- Procedure to get shopper info by shopper id
    PROCEDURE get_shopper_info_by_id (
        p_shopper_id IN NUMBER,
        p_first_name OUT VARCHAR2,
        p_last_name OUT VARCHAR2,
        p_city OUT VARCHAR2,
        p_state OUT VARCHAR2,
        p_phone OUT VARCHAR2,
        p_email OUT VARCHAR2
    ) IS
    BEGIN
        -- Query the BB_SHOPPER table for shopper details using shopper_id
        SELECT FIRSTNAME, LASTNAME, CITY, STATE, PHONE, EMAIL
        INTO p_first_name, p_last_name, p_city, p_state, p_phone, p_email
        FROM BB_SHOPPER
        WHERE IDSHOPPER = p_shopper_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- If no record is found, raise an error
            DBMS_OUTPUT.PUT_LINE('No shopper found with ID: ' || p_shopper_id);
            RAISE;
        WHEN OTHERS THEN
            -- Handle any other exceptions
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            RAISE;
    END get_shopper_info_by_id;

    -- Procedure to get shopper info by last name
    PROCEDURE get_shopper_info_by_last_name (
        p_last_name IN VARCHAR2,
        p_first_name OUT VARCHAR2,
        p_last_name_out OUT VARCHAR2, -- Renamed OUT parameter
        p_city OUT VARCHAR2,
        p_state OUT VARCHAR2,
        p_phone OUT VARCHAR2,
        p_email OUT VARCHAR2
    ) IS
    BEGIN
        -- Query the BB_SHOPPER table for shopper details using last name
        -- If multiple rows are returned, only the first one is selected
        SELECT FIRSTNAME, LASTNAME, CITY, STATE, PHONE, EMAIL
        INTO p_first_name, p_last_name_out, p_city, p_state, p_phone, p_email
        FROM BB_SHOPPER
        WHERE LASTNAME = p_last_name
        AND ROWNUM = 1;  -- To prevent TOO_MANY_ROWS exception by limiting to 1 result
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- If no record is found, raise an error
            DBMS_OUTPUT.PUT_LINE('No shopper found with last name: ' || p_last_name);
            RAISE;
        WHEN TOO_MANY_ROWS THEN
            -- Handle case where multiple records match
            DBMS_OUTPUT.PUT_LINE('Multiple shoppers found with last name: ' || p_last_name);
            RAISE;
        WHEN OTHERS THEN
            -- Handle any other exceptions
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            RAISE;
    END get_shopper_info_by_last_name;

END SHOP_QUERY_PKG;
/
-- Anonymous PL/SQL Block to test the procedure
DECLARE
    v_first_name VARCHAR2(50);
    v_last_name VARCHAR2(50);
    v_city VARCHAR2(100);
    v_state VARCHAR2(100);
    v_phone VARCHAR2(20);
    v_email VARCHAR2(100);
BEGIN
    -- Call the procedure using shopper id
    SHOP_QUERY_PKG.get_shopper_info_by_id(23, v_first_name, v_last_name, v_city, v_state, v_phone, v_email);

    -- Output the results
    DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('City: ' || v_city);
    DBMS_OUTPUT.PUT_LINE('State: ' || v_state);
    DBMS_OUTPUT.PUT_LINE('Phone: ' || v_phone);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
END;
/

DECLARE
    v_first_name VARCHAR2(50);
    v_last_name VARCHAR2(50);
    v_city VARCHAR2(100);
    v_state VARCHAR2(100);
    v_phone VARCHAR2(20);
    v_email VARCHAR2(100);
BEGIN
    -- Call the procedure using last name 'Ratman'
    SHOP_QUERY_PKG.get_shopper_info_by_last_name('Ratman', v_first_name, v_last_name, v_city, v_state, v_phone, v_email);

    -- Output the results
    DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('City: ' || v_city);
    DBMS_OUTPUT.PUT_LINE('State: ' || v_state);
    DBMS_OUTPUT.PUT_LINE('Phone: ' || v_phone);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
END;
/

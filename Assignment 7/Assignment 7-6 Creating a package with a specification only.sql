CREATE OR REPLACE PACKAGE TAX_RATE_PKG IS
    -- Declare constant tax rates for specific states
    PV_TAX_NC CONSTANT NUMBER := 0.35;  -- North Carolina Tax Rate
    PV_TAX_TX CONSTANT NUMBER := 0.05;   -- Texas Tax Rate
    PV_TAX_TN CONSTANT NUMBER := 0.02;   -- Tennessee Tax Rate
END TAX_RATE_PKG;
/


--Anonymous PL/SQL Block to Display the Tax Rates
DECLARE
BEGIN
    -- Display the tax rates using DBMS_OUTPUT
    DBMS_OUTPUT.PUT_LINE('North Carolina Tax Rate: ' || TAX_RATE_PKG.PV_TAX_NC);
    DBMS_OUTPUT.PUT_LINE('Texas Tax Rate: ' || TAX_RATE_PKG.PV_TAX_TX);
    DBMS_OUTPUT.PUT_LINE('Tennessee Tax Rate: ' || TAX_RATE_PKG.PV_TAX_TN);
END;
/


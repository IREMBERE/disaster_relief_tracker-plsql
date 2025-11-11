-- FILE: relief_tracker.sql
-- CREATE OR REPLACE PROCEDURE version (save this in a file and compile)
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE relief_tracker IS

    ----------------------------------------------------------------
    -- Types and collection
    ----------------------------------------------------------------
    TYPE delivery_record IS RECORD (
        location_name  VARCHAR2(100),
        item_type      VARCHAR2(100),
        weight_kg      NUMBER,
        status         VARCHAR2(20)   -- 'Delivered' | 'Pending' | 'Failed'
    );

    TYPE delivery_table IS TABLE OF delivery_record;
    deliveries delivery_table := delivery_table();

    ----------------------------------------------------------------
    -- Aggregates and loop counter
    ----------------------------------------------------------------
    total_delivered_kg NUMBER := 0;
    total_failed_kg    NUMBER := 0;
    total_pending_kg   NUMBER := 0;

    i INTEGER;

BEGIN
    ----------------------------------------------------------------
    -- Populate sample data (edit these lines to change sample)
    ----------------------------------------------------------------
    deliveries.EXTEND(7);
    deliveries(1) := delivery_record('Kigali',    'Rice Bags',       500, 'Delivered');
    deliveries(2) := delivery_record('Gisenyi',   'Medical Kits',    200, 'Delivered');
    deliveries(3) := delivery_record('Musanze',   'Tents',           300, 'Failed');
    deliveries(4) := delivery_record('Huye',      'Water Bottles',   400, 'Delivered');
    deliveries(5) := delivery_record('Nyagatare', 'Blankets',        250, 'Failed');
    deliveries(6) := delivery_record('Ruhango',   'Sanitation Kits', 150, 'Pending');
    deliveries(7) := delivery_record('Nyamagabe', 'Fuel',            600, 'Delivered');

    DBMS_OUTPUT.PUT_LINE('=== DISASTER RELIEF SUPPLY REPORT ===');

    ----------------------------------------------------------------
    -- Main processing loop
    ----------------------------------------------------------------
    FOR i IN 1 .. deliveries.COUNT LOOP

        -- If a delivery failed -> add to failed and skip
        IF deliveries(i).status = 'Failed' THEN
            total_failed_kg := total_failed_kg + deliveries(i).weight_kg;
            GOTO after_processing;
        END IF;

        -- If pending -> add to pending, print pending notice, skip adding to delivered
        IF deliveries(i).status = 'Pending' THEN
            total_pending_kg := total_pending_kg + deliveries(i).weight_kg;
            DBMS_OUTPUT.PUT_LINE('Pending delivery: ' || deliveries(i).location_name ||
                                 ' | Item: ' || deliveries(i).item_type ||
                                 ' | Weight: ' || deliveries(i).weight_kg || ' kg');
            GOTO after_processing;
        END IF;

        -- Otherwise treat as delivered
        total_delivered_kg := total_delivered_kg + deliveries(i).weight_kg;

        DBMS_OUTPUT.PUT_LINE('Delivered to: ' || deliveries(i).location_name ||
                             ' | Item: ' || deliveries(i).item_type ||
                             ' | Weight: ' || deliveries(i).weight_kg || ' kg');

        <<after_processing>>
        NULL; -- label target

    END LOOP;

    -- Final summary
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Delivered Weight: ' || total_delivered_kg || ' kg');
    DBMS_OUTPUT.PUT_LINE('Total Pending Weight : ' || total_pending_kg   || ' kg');
    DBMS_OUTPUT.PUT_LINE('Total Failed Weight  : ' || total_failed_kg    || ' kg');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Report Completed Successfully.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END relief_tracker;
/






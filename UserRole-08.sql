DECLARE
  ncount NUMBER;
BEGIN
  SELECT COUNT(1) INTO ncount FROM DBA_ROLES WHERE role = 'CUSTOMER_USER';
  IF (ncount > 0) THEN
    DBMS_OUTPUT.PUT_LINE('ROLE CUSTOMER_USER ALREADY EXISTS');
  ELSE
    EXECUTE IMMEDIATE 'CREATE ROLE CUSTOMER_USER';
    FOR x IN (SELECT * FROM user_tables WHERE table_name IN ('TICKET_ID', 'SEAT'))
    LOOP
      EXECUTE IMMEDIATE 'GRANT UPDATE ON ' || x.table_name || ' TO CUSTOMER_USER';
    END LOOP;
    COMMIT;
    FOR x IN (SELECT * FROM user_tables WHERE table_name IN ('TICKET','CUSTOMER_ADDON','PAYMENT'))
    LOOP
      EXECUTE IMMEDIATE 'GRANT INSERT ON ' || x.table_name || ' TO CUSTOMER_USER';
    END LOOP;
    COMMIT;
    FOR x IN (SELECT * FROM user_tables WHERE table_name IN ('CUSTOMER', 'THEATRE', 'MOVIE', 'TICKET', 'THEATRE_LOCATION',' SCHEDULED_SHOW',' ADDON',' PAYMENT', 'MOVIE_SCREEN'))
    LOOP
      EXECUTE IMMEDIATE 'GRANT SELECT ON ' || x.table_name || ' TO CUSTOMER_USER';
    END LOOP;
    COMMIT;
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON movie_booking_pkg TO CUSTOMER_USER';
    COMMIT;
    
  END IF;
END;
/
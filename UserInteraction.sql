set serveroutput on;
CREATE OR replace PROCEDURE Customer_Actions
is
BEGIN
dbms_output.Put_line('HELLO ');

dbms_output.Put_line('OPERATIONS ALLOWED:');    

dbms_output.Put_line('');

dbms_output.Put_line('-------------USER RELATED ACTIONS-------------');

dbms_output.Put_line('1. TO view Movie Schedules : select * from movie_schedule');

dbms_output.Put_line('2. TO view Ticket History : select * from tickets_history');

dbms_output.Put_line('3. To view available seats in the screen for the show : select *from seats_available');

dbms_output.Put_line('4. To checkout : select seats and addons');

dbms_output.Put_line('4. To view addons : select *from addon ');

dbms_output.Put_line('');

EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END Customer_Actions;
/


BEGIN
  movieadmin.Customer_Actions();
END;
/


--- select movie name,screen_id
SELECT *FROM movieadmin.movie_schedule;

-- Get list of seats available
select *from movieadmin.seats_available where screen_id = 1 and movie_name = 'Eiffel';


-- List of addons
select *from movieadmin.addon; 

COMMIT;


-- Call the login procedure to retrieve the customer ID
BEGIN
  movie_booking_pkg.login(p_username => 'garry123', p_password => 'fdsfv32');
END;
/

---- to checkout after selecting tickets
DECLARE
  v_checkout_price NUMBER;
BEGIN
  
  movie_booking_pkg.checkout(
                     p_movie_id => 7,
                     p_show_id => 7,
                     p_screen_id => 3,
                     p_seat_list => '25A,25B',
                     p_total_price => v_checkout_price);
  
END;
/


DECLARE
  v_checkout_price NUMBER;
BEGIN
  movie_booking_pkg.AddAddOnsToCheckout(
                     p_add_on_id => '1,2,3',
                     p_quantity => '1,3,5',
                     checkoutPrice => v_checkout_price);
END;
/



DECLARE
  p_payment_id NUMBER;
BEGIN
  movie_booking_pkg.processpayment(
                     p_name => 'PP',
                     p_address => '02120',
                     p_payment_id => p_payment_id);
END;
/

select *from ticket;

select *from customer_addon;

select *from payment;





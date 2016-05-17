-- Configuration
function love.conf(t)
	t.title = "Scrolling Shooter Tutorial" -- The title of the window the game is in (string)
	t.window.width = 480        -- we want our game to be long and thin.
	t.window.height = 800

	-- For Windows debugging
	t.console = true
end

--SELECT city FROM weather WHERE temp_lo = (SELECT max(temp_lo) FROM weather);
--select city, max(temp_lo) from weather group by city;	
--BEGIN;
 -- UPDATE weather SET temp_hi = temp_hi - 2, temp_lo = temp_lo - 2 WHERE city = 'San Francisco';
  --INSTER INTO weather VALUES ('Berkeley', 45, 53, 0.0, '19994-11-28);
 -- UPDATE weather SET temp_hi = temp_hi -2, temp_lo = temp_lo -2 WHERE city = 'San Francisco';
--COMMIT;
--CREATE FUNCTION sales_tax(subtotal real) RETURNS real as $$ 
--BEGIN 
--RETURN subtotal* 0.06;
--END;
--$$ LANGUAGE plpgsql;

--select sales_tax(0.5);
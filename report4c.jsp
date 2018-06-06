CREATE OR REPLACE FUNCTION third()
RETURNS trigger AS
$$
declare
    temprow record;
BEGIN
	IF POSITION('M' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('M' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Time Conflict';
				END IF;
			END LOOP;
	ELSIF POSITION('Tue' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('Tue' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Time Conflict';
				END IF;
			END LOOP;
	ELSIF POSITION('W' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('W' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Time Conflict';
				END IF;
			END LOOP;
	ELSIF POSITION('Thu' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('Thu' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Time Conflict';
				END IF;
			END LOOP;
	ELSIF POSITION('F' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('F' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Time Conflict';
				END IF;
			END LOOP;
	ELSE 
	    RAISE NOTICE 'Assigning Professor Completed';
    	RETURN NEW;
	END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER handle_professor
BEFORE INSERT OR UPDATE ON class
FOR EACH ROW EXECUTE PROCEDURE third(); 
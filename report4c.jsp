<%

CREATE OR REPLACE FUNCTION third()
RETURNS trigger AS
$$
BEGIN
	FOR temprow IN
		SELECT le_day FROM class WHERE f_name = NEW.f_name
		LOOP 
			IF POSITION ('M' in temprow.le_day) > 0 AND NEW.le_time = temprow.le.time AND NEW.le_ampm = temprow.ampm
				THEN RAISE EXCEPTION 'FAILED';
			ENDIF
		END LOOP;
		
	IF POSITION('M' in New.le_day ) > 0 AND POSITION('M' in (SELECT le_day FROM class WHERE f_name = NEW.f_name AND le_time = NEW.le_time AND le_ampm = NEW.ampm)) > 0
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('Tue' in New.le_day ) > 0 AND POSITION('Tue' in (SELECT le_day FROM class WHERE f_name = NEW.f_name AND le_time = NEW.le_time AND le_ampm = NEW.ampm)) > 0
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('W' in New.le_day ) > 0 AND POSITION('W' in (SELECT le_day FROM class WHERE f_name = NEW.f_name AND le_time = NEW.le_time AND le_ampm = NEW.ampm)) > 0
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('Thu' in New.le_day ) > 0 AND POSITION('Thu' in (SELECT le_day FROM class WHERE f_name = NEW.f_name AND le_time = NEW.le_time AND le_ampm = NEW.ampm)) > 0
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('F' in New.le_day ) > 0 AND POSITION('F' in (SELECT le_day FROM class WHERE f_name = NEW.f_name AND le_time = NEW.le_time AND le_ampm = NEW.ampm)) > 0
	    THEN RAISE EXCEPTION 'Time Conflict';
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
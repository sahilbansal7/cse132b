CREATE OR REPLACE FUNCTION third()
RETURNS trigger AS
$$
BEGIN

IF POSITION('M' in OLD.le_day WHERE OLD.f_name = NEW.f_name) > 0
	RAISE EXCEPTION 'Hi';
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
<%

CREATE OR REPLACE FUNCTION third()
RETURNS trigger AS
$$
BEGIN
	IF POSITION('M' in New.le_day ) > 0 AND POSITION('M' in (SELECT le_day FROM class WHERE f_name = NEW.f_name)) > 0 AND NEW.le_time = (SELECT le_time FROM class WHERE f_name = NEW.f_name) AND NEW.le_ampm = (SELECT le_ampm FROM class WHERE f_name = NEW.f_name)
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('Tue' in New.le_day ) > 0 AND POSITION('Tue' in (SELECT le_day FROM class WHERE f_name = NEW.f_name)) > 0 AND NEW.le_time = (SELECT le_time FROM class WHERE f_name = NEW.f_name) AND NEW.le_ampm = (SELECT le_ampm FROM class WHERE f_name = NEW.f_name)
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('W' in New.le_day ) > 0 AND POSITION('W' in (SELECT le_day FROM class WHERE f_name = NEW.f_name)) > 0 AND NEW.le_time = (SELECT le_time FROM class WHERE f_name = NEW.f_name) AND NEW.le_ampm = (SELECT le_ampm FROM class WHERE f_name = NEW.f_name)
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('Thu' in New.le_day ) > 0 AND POSITION('Thu' in (SELECT le_day FROM class WHERE f_name = NEW.f_name)) > 0 AND NEW.le_time = (SELECT le_time FROM class WHERE f_name = NEW.f_name) AND NEW.le_ampm = (SELECT le_ampm FROM class WHERE f_name = NEW.f_name)
	    THEN RAISE EXCEPTION 'Time Conflict';
	ELSIF POSITION('F' in New.le_day ) > 0 AND POSITION('F' in (SELECT le_day FROM class WHERE f_name = NEW.f_name)) > 0 AND NEW.le_time = (SELECT le_time FROM class WHERE f_name = NEW.f_name) AND NEW.le_ampm = (SELECT le_ampm FROM class WHERE f_name = NEW.f_name)
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
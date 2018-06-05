<%

CREATE OR REPLACE FUNCTION second()
RETURNS trigger AS
$$
BEGIN
IF NEW.co_number = (SELECT co_number FROM class) AND NEW.section_id = (SELECT section_id FROM class) AND class.enroll_limit = (SELECT COUNT(*) FROM course_enrollment ce WHERE ce.co_number = NEW.co_number AND ce.section_id = NEW.section_id)
    THEN RAISE EXCEPTION 'Enrollment Limit Already Reached';
ELSE 
    RAISE NOTICE 'Insertion Successful'
END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER handle_class_time
BEFORE INSERT OR UPDATE ON course_enrollment
FOR EACH ROW EXECUTE PROCEDURE second(); 


CREATE OR REPLACE FUNCTION second()
RETURNS trigger AS
$$
BEGIN
IF ((SELECT c.enroll_limit from class c where NEW.co_number = c.co_number and NEW.section_id = c.section_id) = (SELECT COUNT(*) FROM course_enrollment ce WHERE ce.co_number = NEW.co_number AND ce.section_id = NEW.section_id))
    THEN RAISE EXCEPTION 'Enrollment Limit Already Reached';
ELSE 
    RAISE NOTICE 'Insertion Successful';
    RETURN NEW;
END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER handle_enrollment
BEFORE INSERT OR UPDATE ON course_enrollment
FOR EACH ROW EXECUTE PROCEDURE second(); 
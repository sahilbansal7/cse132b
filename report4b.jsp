CREATE OR REPLACE FUNCTION second()
RETURNS trigger AS
$$
BEGIN
IF NEW.co_number = class.co_number AND NEW.section_id = class.section_id AND class.enroll_limit = (SELECT COUNT(*) FROM course_enrollment ce WHERE ce.co_number = NEW.co_number AND ce.section_id = NEW.section_id)
    THEN RAISE EXCEPTION 'Enrollment Limit Already Reached';
ELSE 
    RAISE NOTICE 'Insertion Successful';
    RETURN NEW
END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER handle_enrollment
BEFORE INSERT OR UPDATE ON course_enrollment
FOR EACH ROW EXECUTE PROCEDURE second(); 
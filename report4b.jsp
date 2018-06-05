<%

CREATE OR REPLACE FUNCTION second()
RETURNS trigger AS
$$
BEGIN
IF OLD.enroll_limit == COUNT(course_enrollment.co_number == OLD.co_number AND course_enrollment.section_id == OLD.section_id)
    THEN RAISE EXCEPTION 'Enrollment Limit Already Reached'
ELSE 
    RAISE NOTICE 'Insertion Successful'
END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER handle_class_time
BEFORE INSERT OR UPDATE ON class
FOR EACH ROW EXECUTE PROCEDURE second();
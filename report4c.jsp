<% CREATE OR REPLACE FUNCTION third()
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
	END IF;

    RAISE NOTICE 'Assigning Professor Completed';
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;





declare
    temprow record;
BEGIN
	IF POSITION('M' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('M' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
				END IF;
			END LOOP;
	ELSIF POSITION('Tue' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('Tue' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
				END IF;
			END LOOP;
	ELSIF POSITION('W' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('W' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
				END IF;
			END LOOP;
	ELSIF POSITION('Thu' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('Thu' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
				END IF;
			END LOOP;
	ELSIF POSITION('F' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF POSITION ('F' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
					THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
				END IF;
			END LOOP;
	ELSE
	END IF;

    RAISE NOTICE 'Assigning Professor Completed';
	RETURN NEW;
END;

















declare
    temprow record;
BEGIN
	IF POSITION('M' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF temprow.section_id != NEW.section_id or temprow.co_number != NEW.co_number
					IF POSITION ('M' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
						THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
					END IF;
				END IF;
			END LOOP;
	END IF;
	IF POSITION('Tue' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF temprow.section_id != NEW.section_id or temprow.co_number != NEW.co_number
					IF POSITION ('Tue' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
						THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
					END IF;
				END IF;
			END LOOP;
	END IF;
	IF POSITION('W' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF temprow.section_id != NEW.section_id or temprow.co_number != NEW.co_number
					IF POSITION ('W' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
						THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
					END IF;
				END IF;
			END LOOP;
	END IF;
	IF POSITION('Thu' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF temprow.section_id != NEW.section_id or temprow.co_number != NEW.co_number
					IF POSITION ('Thu' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
						THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
					END IF;
				END IF;
			END LOOP;
	END IF;
	IF POSITION('F' in New.le_day ) > 0 THEN 
		FOR temprow IN SELECT * FROM class WHERE f_name = NEW.f_name
			LOOP 
				IF temprow.section_id != NEW.section_id or temprow.co_number != NEW.co_number
					IF POSITION ('F' in temprow.le_day) > 0 AND NEW.le_time = temprow.le_time AND NEW.le_ampm = temprow.le_ampm
						THEN RAISE EXCEPTION 'Professor % Already Teaching Course % Section % At % % %', temprow.f_name, temprow.co_number, temprow.section_id, temprow.le_day, temprow.le_time, temprow.le_ampm;
					END IF;
				END IF;
			END LOOP;
	END IF;

    RAISE NOTICE 'Assigning Professor Completed';
	RETURN NEW;
END;

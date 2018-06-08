<%

CREATE OR REPLACE FUNCTION elev()
	RETURNS trigger AS
	$$
	BEGIN
		IF NEW.grade = 'A+' OR NEW.grade = 'A' OR NEW.grade = 'A-' THEN 	
			IF OLD.grade != 'A+' AND OLD.grade != 'A' AND OLD.grade != 'A-' THEN	
				UPDATE CPQG SET a = a + 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET a = a + 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			END IF;

			IF OLD.grade = 'B+' OR OLD.grade = 'B' OR OLD.grade = 'B-' THEN 	
				UPDATE CPQG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'C+' OR OLD.grade = 'C' OR OLD.grade = 'C-' THEN 	
				UPDATE CPQG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'D+' OR OLD.grade = 'D' OR OLD.grade = 'D-' THEN 	
				UPDATE CPQG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'F' OR OLD.grade = 'IN' THEN 	
				UPDATE CPQG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			END IF;
		ELSIF NEW.grade = 'B+' OR NEW.grade = 'B' OR NEW.grade = 'B-' THEN
			IF OLD.grade != 'B+' AND OLD.grade != 'B' AND OLD.grade != 'B-' THEN	
				UPDATE CPQG SET b = b + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number AND quarter = NEW.quarter AND year = NEW.year;
				UPDATE CPG SET b = b + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number;
			END IF;

			IF OLD.grade = 'A+' OR OLD.grade = 'A' OR OLD.grade = 'A-' THEN 	
				UPDATE CPQG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'C+' OR OLD.grade = 'C' OR OLD.grade = 'C-' THEN 	
				UPDATE CPQG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'D+' OR OLD.grade = 'D' OR OLD.grade = 'D-' THEN 	
				UPDATE CPQG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'F' OR OLD.grade = 'IN' THEN 	
				UPDATE CPQG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			END IF;
		ELSIF NEW.grade = 'C+' OR NEW.grade = 'C' OR NEW.grade = 'C-' THEN
			IF OLD.grade != 'C+' AND OLD.grade != 'C' AND OLD.grade != 'C-' THEN	
				UPDATE CPQG SET c = c + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number AND quarter = NEW.quarter AND year = NEW.year;
				UPDATE CPG SET c = c + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number;
			END IF;

			IF OLD.grade = 'B+' OR OLD.grade = 'B' OR OLD.grade = 'B-' THEN 	
				UPDATE CPQG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'A+' OR OLD.grade = 'A' OR OLD.grade = 'A-' THEN 	
				UPDATE CPQG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'D+' OR OLD.grade = 'D' OR OLD.grade = 'D-' THEN 	
				UPDATE CPQG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'F' OR OLD.grade = 'IN' THEN 	
				UPDATE CPQG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			END IF;
		ELSIF NEW.grade = 'D+' OR NEW.grade = 'D' OR NEW.grade = 'D-' THEN
			IF OLD.grade != 'D+' AND OLD.grade != 'D' AND OLD.grade != 'D-' THEN	
				UPDATE CPQG SET d = d + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number AND quarter = NEW.quarter AND year = NEW.year;
				UPDATE CPG SET d = d + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number;
			END IF;

			IF OLD.grade = 'B+' OR OLD.grade = 'B' OR OLD.grade = 'B-' THEN 	
				UPDATE CPQG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'C+' OR OLD.grade = 'C' OR OLD.grade = 'C-' THEN 	
				UPDATE CPQG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'A+' OR OLD.grade = 'A' OR OLD.grade = 'A-' THEN 	
				UPDATE CPQG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'F' OR OLD.grade = 'IN' THEN 	
				UPDATE CPQG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET other = other - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			END IF;
		ELSIF NEW.grade = 'F' OR NEW.grade = 'IN' THEN
			IF OLD.grade != 'F' AND OLD.grade != 'IN' THEN	
				UPDATE CPQG SET other = other + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number AND quarter = NEW.quarter AND year = NEW.year;
				UPDATE CPG SET other = other + 1 WHERE f_name = NEW.f_name AND co_number = NEW.co_number;
			END IF;

			IF OLD.grade = 'B+' OR OLD.grade = 'B' OR OLD.grade = 'B-' THEN 	
				UPDATE CPQG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET b = b - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'C+' OR OLD.grade = 'C' OR OLD.grade = 'C-' THEN 	
				UPDATE CPQG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET c = c - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'D+' OR OLD.grade = 'D' OR OLD.grade = 'D-' THEN 	
				UPDATE CPQG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET d = d - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			ELSIF OLD.grade = 'A+' OR OLD.grade = 'A' OR OLD.grade = 'A-' THEN 	
				UPDATE CPQG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number AND quarter = OLD.quarter AND year = OLD.year;
				UPDATE CPG SET a = a - 1 WHERE f_name = OLD.f_name AND co_number = OLD.co_number;
			END IF;
		ELSE 
			RAISE EXCEPTION 'Invalid Grade Option : Grade % is not acceptable, Please choose from A, B, C, D, F, IN', NEW.grade;		 	 
		END IF;

		RETURN NEW;
	END;
	$$
	LANGUAGE plpgsql;

	CREATE TRIGGER handle_grade_update
	BEFORE UPDATE ON past_classes
	FOR EACH ROW EXECUTE PROCEDURE elev(); 
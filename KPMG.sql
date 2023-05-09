#adding school id in the table
ALTER TABLE new_schema.schools_df ADD COLUMN schoold_id INT;

UPDATE new_schema.schools_df
SET schoold_id = 
  CASE school
    WHEN 'ironhack' THEN 10828
    WHEN 'app-academy' THEN 10525
    WHEN 'springboard' THEN 11035
    ELSE NULL
  END;
  
  #checking average scores
SELECT AVG(overallScore), school  FROM new_schema.schools_df
group by school;

SELECT AVG(curriculum), school  FROM new_schema.schools_df
group by school;

SELECT AVG(overall), school  FROM new_schema.schools_df
group by school;

SELECT AVG(jobSupport), school  FROM new_schema.schools_df
group by school;

#checking locations
SELECT * FROM new_schema.locations;

#checking the prices
SELECT * FROM new_schema.price;

#checking the badges
SELECT * FROM new_schema.badges;

#checking the courses
SELECT * FROM new_schema.courses;

#checking how many comments we have for each school
select count(distinct id), school from new_schema.schools_df
group by school;

#checking how many courses we have by school
select count(distinct courses), school FROM new_schema.courses
group by school;

select count(distinct program), school FROM new_schema.schools_df
group by school;

#creating a new column in the table to reduce the courses names variations
ALTER TABLE new_schema.schools_df
ADD COLUMN program2 VARCHAR(50);

UPDATE new_schema.schools_df
SET program2 = 
  CASE 
        WHEN program LIKE '%Data%' THEN 'DATA' 
		WHEN program LIKE '%Business%' THEN 'DATA' 
        WHEN program LIKE '%UX/UI%' THEN 'UX/UI' 
        WHEN program LIKE '%Cyber%' THEN 'Cyber Sec'  
        WHEN program LIKE '%Software%' THEN 'Software Engineering'
        WHEN program LIKE '%Web%' THEN 'Web Dev'
        Else NULL 
    END;

#checking the total graduations per yer and school and courses
SELECT  count(graduatingYear), graduatingYear, school, program2 FROM new_schema.schools_df
group by graduatingYear, school, program2;

#checking the average score per year per school and courses
SELECT  AVG(overallScore), count(graduatingYear), graduatingYear, school, program2 FROM new_schema.schools_df
group by graduatingYear, school, program2, overallScore;

#checking cybersecurity courses
Select * FROM new_schema.schools_df
WHERE program2 = 'Cyber Sec';

#checking number of comments per school
select count(distinct id), school FROM new_schema.schools_df
WHERE program2 = 'Cyber Sec'
group by school;

#checking average 
select count(distinct id), AVG(overallScore), school FROM new_schema.schools_df
WHERE program2 = 'Cyber Sec'
group by school;

#hightest gratuating rate in last 3 years
SELECT COUNT(graduatingYear), graduatingYear, school, program
FROM KPMG_project.school_df
WHERE program LIKE 'cyber%' OR program LIKE 'Data%' OR program LIKE 'UX/UI%' OR program LIKE 'Software%' OR program LIKE 'Digital%' OR program LIKE 'Web%'
GROUP BY graduatingYear, school, program
ORDER BY graduatingYear DESC;
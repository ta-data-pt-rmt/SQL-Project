USE Ironhack_SQL;

SELECT *
FROM courses

SELECT *
FROM locations

SELECT *
FROM badges

SELECT *
FROM reviews

SELECT *
FROM websites

SELECT *
FROM program_cost
ORDER BY Program ASC

SELECT school, COUNT(*) AS review_count
FROM reviews
GROUP BY school
ORDER BY review_count DESC;

SELECT school, AVG(overall) AS overall_mean
FROM reviews
GROUP BY school
ORDER BY overall_mean DESC;

SELECT school, AVG(curriculum) AS curriculum_mean
FROM reviews
GROUP BY school
ORDER BY curriculum_mean DESC;

SELECT school, AVG(jobSupport) AS job_mean
FROM reviews
GROUP BY school
ORDER BY job_mean DESC;

SELECT school, AVG(jobSupport)*2 AS job_mean
FROM reviews
WHERE school IN (
    SELECT school
    FROM reviews
    GROUP BY school
    HAVING COUNT(*) > 250 
)
GROUP BY school
ORDER BY job_mean DESC;
-- Explain this number: 303

SELECT school, AVG(overall)*2 AS overall_mean
FROM reviews
WHERE school IN (
    SELECT school
    FROM reviews
    GROUP BY school
    HAVING COUNT(*) > 250 
)
GROUP BY school
ORDER BY overall_mean DESC;

SELECT school, AVG(jobSupport)*2 AS job_mean
FROM reviews
WHERE school IN (
    SELECT school
    FROM reviews
    GROUP BY school
    HAVING COUNT(*) > 250 
)
GROUP BY school
ORDER BY job_mean DESC;
-- Explain this number: 303

SELECT school, AVG(curriculum)*2 AS cur_mean
FROM reviews
WHERE school IN (
    SELECT school
    FROM reviews
    GROUP BY school
    HAVING COUNT(*) > 200 
)
GROUP BY school
ORDER BY cur_mean DESC;

-- Calculate averages for Ironhack
SELECT 
    'Ironhack' AS school,
    AVG(overall)*2 AS overall_avg,
    AVG(curriculum)*2 AS curriculum_avg,
    AVG(jobSupport)*2 AS jobSupport_avg
FROM 
    reviews
WHERE 
    school = 'ironhack'

UNION ALL

-- Calculate averages for all other schools with more than 300 reviews
SELECT 
    'Other Schools' AS school,
    AVG(overall)*2 AS overall_avg,
    AVG(curriculum)*2 AS curriculum_avg,
    AVG(jobSupport)*2 AS jobSupport_avg
FROM 
    reviews
WHERE 
    school != 'ironhack'
    AND school IN (
        SELECT school
        FROM reviews
        GROUP BY school
        HAVING COUNT(*) > 300
    );
    

SELECT
	School, AVG(cost) AS avg_cost
FROM program_cost
GROUP BY school;
    
SELECT *
FROM program_costs

SELECT id, COUNT(*)
FROM program_costs
GROUP BY id
HAVING COUNT(*) > 1;
ALTER TABLE program_costs
ADD PRIMARY KEY (id);


-- Change 1 to 0 to allow DB changes
SET SQL_SAFE_UPDATES = 1;
DELETE FROM program_costs
WHERE cost = 0;

SELECT
    program_costs.school,
    ROUND(AVG(program_costs.cost)) AS avg_cost,
    ROUND(AVG(reviews.overall)) AS avg_overall,
    ROUND(AVG(reviews.curriculum)) AS curriculum_avg,
    ROUND(AVG(reviews.jobSupport)) AS jobSupport_avg
FROM
    program_costs
INNER JOIN
    reviews ON program_costs.program = reviews.program
GROUP BY
    program_costs.school
ORDER BY
    avg_overall DESC;

-- Change column names--

ALTER TABLE locations
CHANGE `country.abbrev` country_abbrev VARCHAR(255);

SELECT
    'Ironhack' AS school,
    locations.country_name,
    ROUND(AVG(reviews.overall)) AS overall_avg,
    ROUND(AVG(reviews.curriculum)) AS curriculum_avg,
    ROUND(AVG(reviews.jobSupport)) AS jobSupport_avg
FROM
    reviews
INNER JOIN locations ON reviews.school = locations.school
WHERE
    reviews.school = 'ironhack'
GROUP BY
    locations.country_name
UNION ALL
-- Calculate averages for all other schools by location
SELECT
    'Other Schools' AS school,
    locations.country_name,
    ROUND(AVG(reviews.overall)) AS overall_avg,
    ROUND(AVG(reviews.curriculum)) AS curriculum_avg,
    ROUND(AVG(reviews.jobSupport)) AS jobSupport_avg
FROM
    reviews
INNER JOIN locations ON reviews.school = locations.school
WHERE
    reviews.school != 'ironhack'
GROUP BY
    locations.country_name;
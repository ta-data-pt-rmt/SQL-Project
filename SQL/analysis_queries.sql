USE tech_schools_data;

-- Query to identify competitors

SELECT school_name
FROM Schools
WHERE school_name != 'Ironhack';

-- Query to analyze ratings and reviews

SELECT school_name, AVG(overall_rating) as avg_overall_rating, AVG(curriculum_rating) as avg_curriculum_rating, AVG(job_support_rating) as avg_job_support_rating
FROM Comments
GROUP BY school_name;

-- Analyze course offering

SELECT school_name, COUNT(course_name) as course_count
FROM Courses
GROUP BY school_name;

-- Analyze locations

SELECT school_name, COUNT(city_name) as city_count, COUNT(country_name) as country_count
FROM Locations
GROUP BY school_name;

-- Analyze badges

SELECT school_name, COUNT(badge_name) as badge_count
FROM Badges
GROUP BY school_name;

-- Ironhack's avg rating

SELECT 
    AVG(overall_score) AS avg_overall_score,
    AVG(overall_rating) AS avg_overall_rating,
    AVG(curriculum_rating) AS avg_curriculum_rating,
    AVG(job_support_rating) AS avg_job_support_rating
FROM 
    Comments
WHERE 
    school_name = 'ironhack';
    
-- Avg ratings for all schools

SELECT 
    school_name,
    AVG(overall_score) AS avg_overall_score,
    AVG(overall_rating) AS avg_overall_rating,
    AVG(curriculum_rating) AS avg_curriculum_rating,
    AVG(job_support_rating) AS avg_job_support_rating
FROM 
    Comments
GROUP BY 
    school_name;
    
-- Top competitors based on num of comments

SELECT 
    school_name,
    COUNT(*) AS comment_count
FROM 
    Comments
GROUP BY 
    school_name
ORDER BY 
    comment_count DESC
LIMIT 5;

-- Calculate average ratings for each course by year

SELECT 
    c.course_name,
    YEAR(cm.created_at) AS year,
    AVG(cm.overall_rating) AS avg_overall_rating,
    AVG(cm.curriculum_rating) AS avg_curriculum_rating,
    AVG(cm.job_support_rating) AS avg_job_support_rating
FROM 
    Comments cm
JOIN 
    Courses c ON cm.program = c.course_name
WHERE 
    c.school_name = 'ironhack'
GROUP BY 
    c.course_name, year
ORDER BY 
    c.course_name, year;
    
-- Distribution of comments and average ratings for each course

SELECT 
    c.course_name,
    COUNT(cm.comment_id) AS num_comments,
    AVG(cm.overall_rating) AS avg_overall_rating,
    AVG(cm.curriculum_rating) AS avg_curriculum_rating,
    AVG(cm.job_support_rating) AS avg_job_support_rating
FROM 
    Comments cm
JOIN 
    Courses c ON cm.program = c.course_name
WHERE 
    c.school_name = 'ironhack'
GROUP BY 
    c.course_name
ORDER BY 
    num_comments DESC;
    
    
-- Perform a simple sentiment analysis by counting positive and negative words in the reviews.

SELECT 
    c.course_name,
    SUM(CASE WHEN cm.review_body LIKE '%good%' OR cm.review_body LIKE '%great%' OR cm.review_body LIKE '%excellent%' THEN 1 ELSE 0 END) AS positive_reviews,
    SUM(CASE WHEN cm.review_body LIKE '%bad%' OR cm.review_body LIKE '%poor%' OR cm.review_body LIKE '%terrible%' THEN 1 ELSE 0 END) AS negative_reviews
FROM 
    Comments cm
JOIN 
    Courses c ON cm.program = c.course_name
WHERE 
    c.school_name = 'ironhack'
GROUP BY 
    c.course_name
ORDER BY 
    positive_reviews DESC, negative_reviews;

-- Identify the top-rated courses specifically for job support.

SELECT 
    c.course_name,
    AVG(cm.job_support_rating) AS avg_job_support_rating
FROM 
    Comments cm
JOIN 
    Courses c ON cm.program = c.course_name
WHERE 
    c.school_name = 'ironhack'
GROUP BY 
    c.course_name
HAVING 
    avg_job_support_rating IS NOT NULL
ORDER BY 
    avg_job_support_rating DESC;
    
-- Identify which courses receive the most positive feedback overall.

SELECT 
    c.course_name,
    COUNT(*) AS positive_feedback_count
FROM 
    Comments cm
JOIN 
    Courses c ON cm.program = c.course_name
WHERE 
    c.school_name = 'ironhack'
    AND (cm.review_body LIKE '%good%' OR cm.review_body LIKE '%great%' OR cm.review_body LIKE '%excellent%')
GROUP BY 
    c.course_name
ORDER BY 
    positive_feedback_count DESC;
    

-- Analyze the number of comments over time to understand trends.

SELECT 
    YEAR(cm.created_at) AS year,
    MONTH(cm.created_at) AS month,
    COUNT(cm.comment_id) AS num_comments
FROM 
    Comments cm
JOIN 
    Courses c ON cm.program = c.course_name
WHERE 
    c.school_name = 'ironhack'
GROUP BY 
    year, month
ORDER BY 
    year, month;
    
-- Average price comparison
SELECT school_name, AVG(price_min) AS avg_price_min, AVG(price_max) AS avg_price_max
FROM Schools
GROUP BY school_name;

-- Price range analysis
SELECT school_name, MIN(price_min) AS min_price, MAX(price_max) AS max_price
FROM Schools
GROUP BY school_name;

-- Course Performance by Location
SELECT 
    l.city_name,
    l.country_name,
    c.course_name,
    AVG(cm.overall_rating) AS avg_overall_rating,
    AVG(cm.curriculum_rating) AS avg_curriculum_rating,
    AVG(cm.job_support_rating) AS avg_job_support_rating
FROM 
    Comments cm
JOIN 
    Courses c ON cm.program = c.course_name
JOIN 
    Locations l ON c.school_id = l.school_id
WHERE 
    c.school_name = 'ironhack'
GROUP BY 
    l.city_name, l.country_name, c.course_name
ORDER BY 
    l.country_name, l.city_name, c.course_name;
    
-- Badge Distribution Across Competitors

SELECT 
    school_name,
    badge_name,
    COUNT(*) AS badge_count
FROM 
    Badges
GROUP BY 
    school_name, badge_name
ORDER BY 
    school_name, badge_count DESC;
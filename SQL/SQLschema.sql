USE tech_schools_data;
CREATE TABLE IF NOT EXISTS Schools (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(255),
    website VARCHAR(255),
    description TEXT,
    price_min FLOAT,
    price_max FLOAT
);

CREATE TABLE IF NOT EXISTS Comments (
    comment_id INT PRIMARY KEY,
    school_id INT,
    school_name VARCHAR(255),
    user_name VARCHAR(255),
    anonymous BOOL,
    graduating_year INT,
    tagline VARCHAR(255),
    created_at DATETIME,
    overall_score FLOAT,
    overall_rating FLOAT,
    curriculum_rating FLOAT,
    job_support_rating FLOAT,
    review_body TEXT,
    program VARCHAR(255),
    program_cat VARCHAR(255),
    FOREIGN KEY (school_id) REFERENCES Schools(school_id)
);

CREATE TABLE IF NOT EXISTS Badges (
    badge_id INT PRIMARY KEY,
    school_id INT,
    school_name VARCHAR(255),
    badge_name VARCHAR(255),
    keyword VARCHAR(255),
    description TEXT,
    FOREIGN KEY (school_id) REFERENCES Schools(school_id)
);

CREATE TABLE IF NOT EXISTS Locations (
    location_id INT PRIMARY KEY,
    school_id INT,
    school_name VARCHAR(255),
    country_id INT,
    country_name VARCHAR(255),
    city_id INT,
    city_name VARCHAR(255),
    FOREIGN KEY (school_id) REFERENCES Schools(school_id)
);

CREATE TABLE IF NOT EXISTS Courses (
    course_id INT PRIMARY KEY,
    school_id INT,
    school_name VARCHAR(255),
    course_name VARCHAR(255),
    FOREIGN KEY (school_id) REFERENCES Schools(school_id)
);

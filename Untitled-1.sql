SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;


SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location ='New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact;

SELECT
    COUNT(job_id) AS number_works_available,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location ='New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
GROUP BY
    location_category

SELECT
    COUNT(job_id) AS number_works_available,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location ='New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    location_category

/*(sub query)*/

SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

/*(CT EXPRESSION query)*/

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;

------------------

SELECT 
    company_id,
    name as company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

SELECT
    company_id,
    COUNT(*)
FROM
    job_postings_fact
GROUP BY
    company_id
........................
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
FROM
        job_postings_fact
GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    company_job_count.total_jobs DESC

........

SELECT
    skill_id,
    COUNT(*)
FROM
    skills_job_dim AS skills_to_jobs
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_jobs.skill_id
WHERE
    job_postings.job_work_from_home = True
GROUP BY
    skill_id

..........
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_jobs
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_jobs.skill_id
    WHERE
        job_postings.job_work_from_home = True AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 10;
..................

SELECT *
FROM january_jobs;

SELECT *
FROM january_jobs;

SELECT *
FROM march_jobs;

............

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs

.........

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs
.................
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs

..............
SELECT *
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS first_quarter_jobs_posting

SELECT
    first_quarter_jobs_posting.job_title_short,
    first_quarter_jobs_posting.job_location,
    first_quarter_jobs_posting.job_via,
    first_quarter_jobs_posting.job_posted_date::DATE
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS first_quarter_jobs_posting
WHERE
    first_quarter_jobs_posting.salary_year_avg > 70000

................

SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS first_quarter_jobs_posting
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC

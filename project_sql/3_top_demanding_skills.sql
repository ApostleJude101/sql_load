WITH remote_job_available AS (
    SELECT
        skill_id,
        COUNT(*) AS Total_Count_Job
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = true
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    Total_Count_Job
FROM remote_job_available
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_available.skill_id
ORDER BY
    Total_Count_Job DESC
LIMIT 5;

SELECT*
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
LIMIT 5

SELECT
    skills,
    COUNT(skills_dim.skill_id) AS demanded_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
ORDER BY
    demanded_count DESC
LIMIT 5

SELECT
    skills,
    COUNT(skills_dim.skill_id) AS demanded_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demanded_count DESC
LIMIT 5

SELECT
    skills,
    COUNT(skills_dim.skill_id) AS demanded_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst') AND 
    (job_work_from_home = true)
GROUP BY
    skills
ORDER BY
    demanded_count DESC
LIMIT 5
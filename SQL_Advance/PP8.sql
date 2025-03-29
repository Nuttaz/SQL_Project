/*
- Get the corresponding skill and skill type for each job posting in q1
- Includes those without any skills, too
- Why? Look at the skills and the type for each job in the first quarter that has a salary > 70,000
*/

WITH q1_jobs AS (
    SELECT *
    FROM jan_jobs

    UNION

    SELECT *
    FROM feb_jobs

    UNION

    SELECT *
    FROM mar_jobs
),

q1_skill as (
    SELECT skills_job_dim.skill_id, count(q1_jobs.job_id) as number_of_job
    FROM q1_jobs LEFT JOIN skills_job_dim ON q1_jobs.job_id = skills_job_dim.job_id
    WHERE q1_jobs.salary_year_avg > 70000
    GROUP BY skills_job_dim.skill_id
)

SELECT
    q1_skill.skill_id,
    skills_dim.skills,
    skills_dim.type,
    q1_skill.number_of_job
FROM q1_skill LEFT JOIN skills_dim ON q1_skill.skill_id = skills_dim.skill_id
ORDER BY q1_skill.number_of_job DESC

/* Find the count of the number of remote job postings per skill
- display the top 5 skills by their demand in remote jobs
- include skill ID, name, and count of postings requiring the skill */

WITH topfive AS (
    SELECT
        skills_job_dim.skill_id,
        count(job_postings_fact.job_id) as number_of_posted
    FROM
        job_postings_fact
        LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_location = 'Anywhere'
    GROUP BY
        skills_job_dim.skill_id
    ORDER BY
        number_of_posted DESC
    LIMIT 5
)

SELECT 
    topfive.skill_id,
    skills_dim.skills,
    topfive.number_of_posted
FROM
    topfive
    LEFT JOIN skills_dim ON topfive.skill_id = skills_dim.skill_id
ORDER BY topfive.number_of_posted DESC

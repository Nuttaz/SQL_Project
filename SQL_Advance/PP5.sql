/*Identify the top 5 skills that are most frequently mentioned in job postings.
Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table
and then join this result with the skills_dim table to get the skill name.*/

SELECT
    skills,
    skill_mentioned
FROM
    (SELECT 
            skill_id,
            Count(*) as skill_mentioned
        from skills_job_dim
        GROUP BY skill_id
        ORDER BY skill_mentioned DESC
        LIMIT 5
    ) as topfive
    LEFT JOIN skills_dim on topfive.skill_id = skills_dim.skill_id
/*What are the skills required for these top-paying Data Analyst (Remote)?
- Identify the top 10 highest-paying Data Analyst role that are available remotely's required skills
- Using Sub-query*/


SELECT  skills_dim.skill_id,
        skills_dim.skills,
        skills_dim.type,
        count(skills_dim.skills) as demand_count
FROM    skills_job_dim
        LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   skills_job_dim.job_id IN (SELECT job_id
                                FROM job_postings_fact
                                WHERE job_title_short = 'Data Analyst'
                                    AND job_work_from_home = true
                                    AND salary_year_avg is not NULL
                                ORDER BY salary_year_avg DESC
                                LIMIT 10
                                )
GROUP BY skills_dim.skill_id, skills_dim.skills, skills_dim.type
ORDER BY demand_count DESC
LIMIT 10
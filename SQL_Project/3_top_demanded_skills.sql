/*What are the most in-demand skills for Data Analyst (Remote)?
- Identify the top 10 highest-demand skill for Data Analyst role that are available remotely
- Using Inner Join to merge 3 tables*/

SELECT  skills_job_dim.skill_id,
        skills,
        skills_dim.type,
        count(skills_job_dim.skill_id) as demand_count
FROM    job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE        AND
        salary_year_avg IS NOT NULL                                    
GROUP BY skills_job_dim.skill_id, skills, skills_dim.type
ORDER BY demand_count DESC
LIMIT 10
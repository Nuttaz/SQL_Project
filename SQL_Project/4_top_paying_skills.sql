/*What are the top skills based on salay for Data Analyst (Remote)?
- Identify the top 10 highest-paying skill for Data Analyst role that are available remotely
- Using Round and Average*/

SELECT  skills_job_dim.skill_id,
        skills,
        skills_dim.type,
        ROUND(avg(salary_year_avg),0) as avg_salary
FROM    job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   job_title_short = 'Data Analyst' AND
        job_work_from_home = true        AND
        salary_year_avg IS NOT NULL                
GROUP BY skills_job_dim.skill_id, skills, skills_dim.type
ORDER BY avg_salary DESC
LIMIT 10
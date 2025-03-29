/*What are the most optimal skills to learn for Data Analyst (Remote)?
- Optimal: High Demand AND High Paying
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Using 2 CTEs*/

WITH top_demanded_skills AS (
        SELECT  skills_job_dim.skill_id,
                skills,
                count(skills_job_dim.skill_id) as demand_count
        FROM    job_postings_fact
                INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
                INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE   job_title_short = 'Data Analyst' AND
                job_work_from_home = TRUE        AND
                salary_year_avg IS NOT NULL                                    
        GROUP BY skills_job_dim.skill_id, skills
        ORDER BY demand_count DESC
        LIMIT 40),
    top_paying_skills AS (
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
        LIMIT 40)
SELECT top_paying_skills.*, top_demanded_skills.demand_count
FROM top_paying_skills
        INNER JOIN top_demanded_skills ON top_paying_skills.skill_id = top_demanded_skills.skill_id
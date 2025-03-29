/*What are the top-paying jobs for Data Analyst (Remote)?
- Identify the top 10 highest-paying Data Analyst role that are available remotely
- Using CTEs*/

WITH toptenjob AS (
    SELECT
        job_id,
        company_id,
        salary_year_avg
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = true
        AND salary_year_avg is not NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    job_id,
    company_dim.name as company_name,
    round(salary_year_avg,0) AS avg_salary
FROM
    toptenjob
    LEFT JOIN company_dim ON toptenjob.company_id = company_dim.company_id
ORDER BY
        salary_year_avg DESC
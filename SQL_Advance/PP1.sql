/*Write a query to find the average salary both yearly (salary_year_avg)
and hourly (salary_hour_avg) for job postings that were posted after 1 Jun 2023
Group the results by job schedule type*/

SELECT
    job_postings_fact.job_schedule_type,
    round(avg(job_postings_fact.salary_hour_avg),0) as avg_hour_salary,
    round(avg(job_postings_fact.salary_year_avg),0) as avg_year_salary
FROM
    job_postings_fact
WHERE
    job_postings_fact.job_schedule_type is not null
    and job_postings_fact.job_posted_date > '2023-06-01'
GROUP BY job_postings_fact.job_schedule_type
HAVING 
    round(avg(job_postings_fact.salary_hour_avg),0) is not null
    OR round(avg(job_postings_fact.salary_year_avg),0) is not null
ORDER BY
    round(avg(job_postings_fact.salary_year_avg),0) DESC
LIMIT 10
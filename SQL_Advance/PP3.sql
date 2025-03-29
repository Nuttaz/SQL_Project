/*Write a query to find companies (include company name)
that have posted jobs offering health insurance,
where these postings were made in the second quarter of 2023
use date extract to filter by quarter*/

SELECT company_dim.name as company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_health_insurance = TRUE
    and (EXTRACT(MONTH from job_posted_date) between 4 and 6)

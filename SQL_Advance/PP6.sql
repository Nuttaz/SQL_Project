/*Determine the size category ('Small','Medium', or 'Large')
for each company by first identifying the number of job posting they have.
Use a subquery to calculate the total job postings per company.
A company is considered 'Small' if it has less than 10 job postings,
'Medium' if the number of job postings is between 10 and 50
and 'Large' if it has more than 50 job postings.
Implement a subquery to aggregate job counts per company before classifying them base on size.*/

WITH company_job_post AS (
SELECT
    company_id,
    count(job_id) as number_of_job
FROM
    job_postings_fact
GROUP BY
    company_id
)

SELECT
    CASE
    WHEN number_of_job < 10 THEN 'Small'
    WHEN number_of_job < 51 THEN 'Medium'
    ELSE 'Large'
    END AS company_size,
    count(company_id) as number_of_company
FROM
    company_job_post
GROUP BY company_size

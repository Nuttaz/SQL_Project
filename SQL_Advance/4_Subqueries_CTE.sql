/*
Choose a subquery when:

You're using the WHERE clause keywords IN or EXISTS to pick up the selection criteria from another table.
You want to select a single piece of data from another table as the new value for a field in an UPDATE statement.

Other circumstance use CTEs is better
*/


/* SubQuery
- query within another query
- It can be used in severak places in the main query
    - Such as the SELECT, FROM, WHERE, or HAVING Clause
- It's executed first, and the results are passed to the outer query
    - It is used when you want to perform a calculation before the main query can complete its calculation

*/
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    where EXTRACT(MONTH from job_posted_date) = 1
    ) AS january_jobs;
-- SubQuery end here

SELECT 
    company_id,
    name as company_name
FROM
    company_dim
where
    company_id in (
        SELECT company_id
        FROM    job_postings_fact
        WHERE job_no_degree_mention = true
)
ORDER BY
    company_id

/* CTE Common Table Expressions: define a temparary result set that you can reference
- Can reference within a SELECT, INSERT, UPDATE, or DELETE statement
- Exists only during the execution of a query
- it's a defined query that can be referenced in the main query or other CTEs
- defined with WITH */

with january_jobs as ( --CTE definition starts here
    SELECT *
    FROM job_postings_fact
    where EXTRACT(MONTH from job_posted_date) = 1
) -- CTE definition ends here

SELECT * FROM january_jobs;


/*Find the company that have the most job openings.
- Get the total number of job postings per company id
- Return the total number of jobs with the company name*/

-- how to solve without subquery and CTEs
SELECT
    company_dim.name as company_name,
    count(job_postings_fact.job_id) as number_of_job
FROM
    job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
GROUP BY
    company_name
Order BY
    number_of_job DESC
LIMIT 10
--

-- How to solve with CTEs
with number_of_job as (
        SELECT company_id, count(*) as count_job
        FROM job_postings_fact
        GROUP BY company_id
)
SELECT
    company_dim.name as company_name,
    count_job
from
    company_dim
    left join number_of_job on company_dim.company_id = number_of_job.company_id
ORDER BY count_job DESC
LIMIT 10
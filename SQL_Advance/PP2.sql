/*Write a query to count the number of job postings for each month in 2023,
adjusting the job_posted_date to be in 'America/New_York' time zone before extracting the month.
Assume the job_posted_date is stored in UTC. Group by and order by the month.*/

SELECT
    EXTRACT(MONTH from (job_posted_date at time zone 'UTC' at time zone 'EST')) as month_posted,
    count(job_id) as number_of_posted
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR from (job_posted_date at time zone 'UTC' at time zone 'EST')) = '2023'
    and 
GROUP BY
    month_posted

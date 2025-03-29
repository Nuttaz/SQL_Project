/* Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as 'Local'
- Otherwise 'Onsite'*/

SELECT
    CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    Else 'Onsite'
    END as Location
    , count(job_id) as number_of_job
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY Location
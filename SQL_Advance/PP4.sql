/* I want to categorize the salaries from each job posting. To see if it fits in my desired salary range.
- Put salary into different buckets
- Define what's a high, standard, or low salary with our own conditions
- why? It is easy to determine which job postings are worth looking at based on salary.
  Bucketing is a common practice in data analysis when viewing categories.
- I only want to look at data analyst roles
- Order from highest to lowest */

SELECT
    job_title_short,
    min(salary_year_avg),
    max(salary_year_avg),
    avg(salary_year_avg)
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_title_short

-- to know salary range 25k-650k avg = 94k

SELECT
    CASE
    WHEN salary_year_avg < '100000' THEN '0-100,000'
    WHEN salary_year_avg < '200000' THEN '100,001-200,000'
    Else '200,001 and higher'
    END as salary_range,
    count(job_id) as number_of_job
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    and salary_year_avg is not null
GROUP BY salary_range


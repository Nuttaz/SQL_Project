CREATE table jan_jobs as
SELECT * FROM job_postings_fact
WHERE EXTRACT(month from job_posted_date) = 1;

CREATE table feb_jobs as
SELECT * FROM job_postings_fact
WHERE EXTRACT(month from job_posted_date) = 2;

CREATE table mar_jobs as
SELECT * FROM job_postings_fact
WHERE EXTRACT(month from job_posted_date) = 3;
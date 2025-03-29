/* UNION Operator
Combine result sets of two or more SELECT statements into a single result set.
- UNION: Remove duplicate rows
- UNION ALL: Includes all duplicate rows
Note: Each SELECT statement within the UNION must have the same number of columns in the result sets with similar data types.*/

SELECT *
FROM jan_jobs

UNION ALL

SELECT *
FROM feb_jobs

UNION ALL

SELECT *
FROM mar_jobs

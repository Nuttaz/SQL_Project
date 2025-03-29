# Demand Skill in Job Market

## Overview

Welcome to my analysis of the remote Data Analyst job market, focusing on identifying top-paying roles and the skills required to secure these positions. This project was developed to understand the demand for high-salary remote Data Analyst roles, uncover the most valuable skills for career growth, and highlight the tools that drive success in the field. By examining the intersection of salary trends and skill sets, this analysis provides insights into how to align career goals with lucrative opportunities in the data analytics industry.
You can view the full code [here]()
You can also check out other SQL code in the [SQL_Advanced]() section

## The Question
Here are the key questions I aim to answer through this project:
1. **What are the top-paying jobs for Data Analyst (Remote)?**
To target high-salary remote positions and align my career goals with lucrative opportunities.
2. **What are the skills required for these top-paying Data Analyst (Remote)?**
To focus on acquiring the necessary skills that will help me land high-paying roles.
3. **What are the most in-demand skills for Data Analyst (Remote)?**
To ensure my skillset remains relevant and competitive in the job market.
4. **What are the top skills based on salay for Data Analyst (Remote)?**
To identify high-salary skills and prioritize learning them for better career growth.
5. **What are the most optimal skills to learn for Data Analyst (Remote)?**
To focus on the most valuable skills that will enhance my career and job performance.

## Tools I Used
To dive deep into the job market, I used several powerful tools for data analysis:
- **SQL**: The main tool for data analysis, enabling me to perform complex queries and extract valuable insights. I specifically used:
    - **CTEs (Common Table Expressions)**: Used for breaking down complex queries into modular components, improving readability and performance.
    - **Sub-Queries**: Allowed for executing nested queries within a larger query to refine results and filter data more effectively.
    - **JOIN**: Essential for combining data from multiple tables based on relationships, facilitating deeper analysis of interconnected datasets.
    - **Other SQL Functions**: I used COUNT to tally rows, AVERAGE to compute mean values, and ROUND to round numeric results to a specified number of decimal places.
- **PostgreSQL & pgAdmin 4**: My preferred database and database management tool, providing robust support for SQL queries and database operations.
- **Visual Studio Code**: My preferred environment for writing and executing SQL scripts, with extensions for SQL syntax highlighting and efficient execution.
- **Git & GitHub**: These tools were crucial for version control and sharing the SQL code and analysis.

## The Analysis
### What are the top-paying jobs for Data Analyst (Remote)?
```sql
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
```
| Job ID  | Company Name                       | Avg Salary    |
|---------|-------------------------------------|----------|
| 226942  | Mantys                              | 650,000  |
| 547382  | Meta                                | 336,500  |
| 552322  | AT&T                                | 255,830  |
| 99305   | Pinterest Job Advertisements        | 232,423  |
| 1021647 | Uclahealthcareers                   | 217,000  |
| 168310  | SmartAsset                          | 205,000  |
| 731368  | Inclusively                         | 189,309  |
| 310660  | Motional                            | 189,000  |
| 1749593 | SmartAsset                          | 186,000  |
| 387860  | Get It Recruit - Information Technology | 184,000 |

The highest-paying remote Data Analyst roles are dominated by major companies like Mantys and Meta, with salaries reaching up to $650,000 and $336,500, respectively. This indicates that top-tier companies are willing to pay a premium for skilled Data Analyst in remote roles.

### What are the skills required for these top-paying Data Analyst (Remote)?
```sql
SELECT  skills_dim.skill_id,
        skills_dim.skills,
        skills_dim.type,
        count(skills_dim.skills) as demand_count
FROM    skills_job_dim
        LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   skills_job_dim.job_id IN (SELECT job_id
                                FROM job_postings_fact
                                WHERE job_title_short = 'Data Analyst'
                                    AND job_work_from_home = true
                                    AND salary_year_avg is not NULL
                                ORDER BY salary_year_avg DESC
                                LIMIT 10
                                )
GROUP BY skills_dim.skill_id, skills_dim.skills, skills_dim.type
ORDER BY demand_count DESC
LIMIT 10
```
| Skill ID | Skills     | Type         | Demand Count |
|----------|------------|--------------|--------------|
| 0        | SQL        | Programming  | 8            |
| 1        | Python     | Programming  | 7            |
| 182      | Tableau    | Analyst Tools| 6            |
| 5        | R          | Programming  | 4            |
| 93       | Pandas     | Libraries    | 3            |
| 80       | Snowflake  | Cloud        | 3            |
| 181      | Excel      | Analyst Tools| 3            |
| 74       | Azure      | Cloud        | 2            |
| 79       | Oracle     | Cloud        | 2            |
| 76       | AWS        | Cloud        | 2            |

Top-paying remote Data Analyst roles require proficiency in SQL and Python, along with strong skills in Tableau and Excel for data analysis and visualization. Expertise in cloud technologies like Snowflake, Azure, and AWS is also highly valued, highlighting the demand for a blend of technical and cloud computing skills.

### What are the most in-demand skills for Data Analyst (Remote)?
```sql
SELECT  skills_job_dim.skill_id,
        skills,
        skills_dim.type,
        count(skills_job_dim.skill_id) as demand_count
FROM    job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE        AND
        salary_year_avg IS NOT NULL                                    
GROUP BY skills_job_dim.skill_id, skills, skills_dim.type
ORDER BY demand_count DESC
LIMIT 10
```
| Skill ID | Skills      | Type          | Demand Count |
|----------|-------------|---------------|--------------|
| 0        | SQL         | Programming   | 398          |
| 181      | Excel       | Analyst Tools | 256          |
| 1        | Python      | Programming   | 236          |
| 182      | Tableau     | Analyst Tools | 230          |
| 5        | R           | Programming   | 148          |
| 183      | Power BI    | Analyst Tools | 110          |
| 186      | SAS         | Analyst Tools | 63           |
| 7        | SAS         | Programming   | 63           |
| 196      | PowerPoint  | Analyst Tools | 58           |
| 185      | Looker      | Analyst Tools | 49           |

The most in-demand skills for remote Data Analysts are focused on data management and analysis, with SQL, Excel, and Python being the most sought-after. Tools like Tableau and Power BI also play a key role, emphasizing the importance of both technical and visualization skills in the field.

### What are the top skills based on salay for Data Analyst (Remote)?
```sql
SELECT  skills_job_dim.skill_id,
        skills,
        skills_dim.type,
        ROUND(avg(salary_year_avg),0) as avg_salary
FROM    job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   job_title_short = 'Data Analyst' AND
        job_work_from_home = true        AND
        salary_year_avg IS NOT NULL                
GROUP BY skills_job_dim.skill_id, skills, skills_dim.type
ORDER BY avg_salary DESC
LIMIT 10
```
| Skill ID | Skills      | Type          | Avg Salary |
|----------|-------------|---------------|------------|
| 95       | PySpark     | Libraries     | 208,172    |
| 218      | Bitbucket   | Other         | 189,155    |
| 65       | Couchbase   | Databases     | 160,515    |
| 85       | Watson      | Cloud         | 160,515    |
| 206      | DataRobot   | Analyst Tools | 155,486    |
| 220      | GitLab      | Other         | 154,500    |
| 35       | Swift       | Programming   | 153,750    |
| 102      | Jupyter     | Libraries     | 152,777    |
| 93       | Pandas      | Libraries     | 151,821    |
| 59       | Elasticsearch | Databases   | 145,000    |

The highest-paying remote Data Analyst skills are PySpark and Bitbucket, with salaries reaching up to $208,172 and $189,155, respectively. This indicates a strong demand for specialized tools and cloud technologies, with advanced skills in libraries and databases being highly rewarded in the industry.

### What are the most optimal skills to learn for Data Analyst (Remote)?
```sql
WITH top_demanded_skills AS (
        SELECT  skills_job_dim.skill_id,
                skills,
                count(skills_job_dim.skill_id) as demand_count
        FROM    job_postings_fact
                INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
                INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE   job_title_short = 'Data Analyst' AND
                job_work_from_home = TRUE        AND
                salary_year_avg IS NOT NULL                                    
        GROUP BY skills_job_dim.skill_id, skills
        ORDER BY demand_count DESC
        LIMIT 40),
    top_paying_skills AS (
        SELECT  skills_job_dim.skill_id,
                skills,
                skills_dim.type,
                ROUND(avg(salary_year_avg),0) as avg_salary
        FROM    job_postings_fact
                INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
                INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE   job_title_short = 'Data Analyst' AND
                job_work_from_home = true        AND
                salary_year_avg IS NOT NULL                
        GROUP BY skills_job_dim.skill_id, skills, skills_dim.type
        ORDER BY avg_salary DESC
        LIMIT 40)
SELECT top_paying_skills.*, top_demanded_skills.demand_count
FROM top_paying_skills
        INNER JOIN top_demanded_skills ON top_paying_skills.skill_id = top_demanded_skills.skill_id
```
| Skill ID | Skills      | Type          | Avg Salary | Demand Count |
|----------|-------------|---------------|------------|--------------|
| 80       | Snowflake   | Cloud         | 112,948    | 37           |
| 74       | Azure       | Cloud         | 111,225    | 34           |
| 76       | AWS         | Cloud         | 108,317    | 32           |
| 8        | Go          | Programming   | 115,320    | 27           |
| 97       | Hadoop      | Libraries     | 113,193    | 22           |
| 4        | Java        | Programming   | 106,906    | 17           |
| 77       | BigQuery    | Cloud         | 109,654    | 13           |
| 194      | SSIS        | Analyst Tools | 106,683    | 12           |
| 234      | Confluence  | Async         | 114,210    | 11           |

The most optimal skills for remote Data Analysts are cloud technologies like Snowflake, Azure, and AWS, offering solid salaries and high demand. Additionally, programming skills such as Go and Java are also valuable, further enhancing career prospects in the field.

## Conclusion of the analysis

Top-paying remote Data Analyst roles demand a combination of technical, programming, and cloud computing skills, with companies offering premium salaries for expertise in SQL, Python, and tools like Tableau and Excel. To succeed in the field, it is crucial to master both in-demand skills and specialized tools like PySpark, Bitbucket, and cloud technologies, which offer strong earning potential and career growth opportunities.

## What I Learned

Throughout this project, I gained a deeper understanding of SQL and how it can be applied to manage and analyze large datasets. SQL provided me with the ability to efficiently extract and manipulate data from relational databases, which significantly enhanced my analytical capabilities. Here are a few specific things I learned:

- **Strategic Database Design**:
I also realized the importance of understanding the structure of databases and designing efficient schemas before jumping into analysis. By focusing on proper table design, relationships, and ensuring data integrity, I was able to work with clean and organized datasets. This approach saved time during the analysis phase and improved the clarity of the results.

- **Advanced SQL Usage**:
I gained hands-on experience in writing complex SQL queries, including JOINs, subqueries, and CTEs (Common Table Expressions), which allowed me to merge data from multiple tables and perform in-depth analysis. I also learned to optimize my queries for better performance, using indexes and grouping functions to improve efficiency. These techniques allowed me to handle large datasets and extract meaningful insights more effectively.

## Conclusion

By analyzing the key skills and tools in demand for remote Data Analyst roles, this project has underscored the need for a strategic skillset that includes advanced SQL techniques and familiarity with cloud technologies. Focusing on these skills will not only help secure high-paying roles but also provide opportunities for continued career growth. Moving forward, acquiring proficiency in these areas will be crucial for standing out in a competitive job market.
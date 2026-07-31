/*
Question: What are the most valuable skills for data engineers?
- Rank skills by balancing demand and median salary.
- Focus on remote Data Engineer roles with reported salaries.
*/

SELECT
    sd.skills,
    ROUND (MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(jpf.*) AS corrected_demand_count,
    ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
    (MEDIAN(jpf.salary_year_avg) * COUNT(jpf.salary_year_avg))/1_000_000 AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL 
GROUP BY
    sd.skills  
HAVING
    COUNT(jpf.*) >100
ORDER BY
    optimal_score DESC
LIMIT 25;

/*
────────────┬───────────────┬────────────────────────┬─────────────────┬─────────────────┐
│   skills   │ median_salary │ corrected_demand_count │ ln_demand_count │  optimal_score  │
│  varchar   │    double     │         int64          │     double      │     double      │
├────────────┼───────────────┼────────────────────────┼─────────────────┼─────────────────┤
│ python     │      135000.0 │                   1133 │             7.0 │         152.955 │
│ sql        │      130000.0 │                   1128 │             7.0 │          146.64 │
│ aws        │      137320.0 │                    783 │             6.7 │  107.5218046875 │
│ spark      │      140000.0 │                    503 │             6.2 │           70.42 │
│ azure      │      128000.0 │                    475 │             6.2 │            60.8 │
│ snowflake  │      135500.0 │                    438 │             6.1 │          59.349 │
│ airflow    │      150000.0 │                    386 │             6.0 │            57.9 │
│ kafka      │      145000.0 │                    292 │             5.7 │           42.34 │
│ java       │      135000.0 │                    303 │             5.7 │          40.905 │
│ redshift   │      130000.0 │                    274 │             5.6 │           35.62 │
│ terraform  │      184000.0 │                    193 │             5.3 │          35.512 │
│ databricks │      132750.0 │                    266 │             5.6 │         35.3115 │
│ scala      │      137290.0 │                    247 │             5.5 │ 33.910749640625 │
│ git        │      140000.0 │                    208 │             5.3 │           29.12 │
│ hadoop     │      135000.0 │                    198 │             5.3 │           26.73 │
│ gcp        │      136000.0 │                    196 │             5.3 │          26.656 │
│ nosql      │      134415.0 │                    193 │             5.3 │       25.942095 │
│ kubernetes │      150500.0 │                    147 │             5.0 │         22.1235 │
│ pyspark    │      140000.0 │                    152 │             5.0 │           21.28 │
│ docker     │      135000.0 │                    144 │             5.0 │           19.44 │
│ tableau    │      115000.0 │                    164 │             5.1 │           18.86 │
│ mongodb    │      135750.0 │                    136 │             4.9 │          18.462 │
│ r          │      134775.0 │                    133 │             4.9 │       17.925075 │
│ github     │      135000.0 │                    127 │             4.8 │          17.145 │
│ sql server │      120000.0 │                    139 │             4.9 │           16.68 │
└────────────┴───────────────┴────────────────────────┴─────────────────┴─────────────────┘
  25 rows                                                                       5 columns

*/

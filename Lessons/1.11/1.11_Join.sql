SELECT
jpf.*,
cd.*

FROM
job_postings_fact AS jpf

LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id

LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
LIMIT 10;
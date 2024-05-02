CREATE DATABASE Company;

use Company;

CREATE TABLE jobs
(
  id INTEGER,
  work_year INTEGER,
  experience_level VARCHAR(25),
  employment_type VARCHAR(25),
  job_title VARCHAR(25),
  salary INTEGER,
  salary_currency VARCHAR(25),
  salary_in_usd INTEGER,
  employee_residence VARCHAR(25),
  remote_ratio INTEGER,
  company_location VARCHAR(25),
  company_size VARCHAR(25)
);

CREATE TABLE companies
(
   id INT,
   company_name VARCHAR(30)
);

SELECT * FROM jobs;

SELECT * FROM companies;

## 1. Average salary for all the jobs in the dataset.
SELECT AVG(salary) AS average_salary FROM jobs;

## 2. Highest salary in the dataset and which job role does it correspond to?
SELECT MAX(salary) AS highest_salary, job_title FROM jobs;

## 3. Average salary for data scientists in US.
SELECT AVG(salary) AS average_salary FROM jobs WHERE job_title = 'Data Scientist' AND company_location = 'US';

## 4. Number of jobs available for each job title.
SELECT job_title, COUNT(*) AS num_jobs FROM jobs GROUP BY job_title;

## 5. Total salary paid for all data analyst jobs in DE.
SELECT SUM(salary) AS total_salary_paid FROM jobs WHERE job_title = 'Data Analyst' AND company_location = 'DE';

## 6. Top 5 highest paying job titles and their corresponding average salaries?
SELECT job_title, AVG(salary) AS average_salary FROM jobs GROUP BY job_title ORDER BY average_salary DESC LIMIT 5;

## 7. Number of jobs available in each location.
SELECT company_location, COUNT(*) AS num_jobs FROM jobs GROUP BY company_location;

## 8. Top 3 job titles that have the most jobs available in the dataset.
SELECT job_title, COUNT(*) AS num_jobs FROM jobs GROUP BY job_title ORDER BY num_jobs DESC LIMIT 3;

## 9. Average salary for data engineers in Boston.
SELECT AVG(salary) AS average_salary FROM jobs WHERE job_title = 'Data Engineer' AND company_location = 'Boston'; 

## Put company_location as US
SELECT AVG(salary) AS average_salary FROM jobs WHERE job_title = 'Data Engineer' AND company_location = 'US'; 

## 10. Top 5 cities with the highest average salaries.
SELECT company_location, AVG(salary) AS average_salary FROM jobs GROUP BY company_location ORDER BY average_salary DESC LIMIT 5;

## 11. Average salary for each job title, and what is the total number of jobs available for each job title?
SELECT job_title, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title;

## 12. Top 5 job titles with the highest total salaries, and what is the total number of jobs available for each job title?
SELECT job_title, SUM(salary) AS total_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title 
ORDER BY total_salary DESC 
LIMIT 5;

## 13. Top 5 locations with the highest total salaries, and what is the total number of jobs available for each location?
SELECT company_location, SUM(salary) AS total_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY company_location 
ORDER BY total_salary DESC 
LIMIT 5;

## 14. Average salary for each job title in each location, and what is the total number of jobs available for each job title in each location?
SELECT job_title, company_location, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title, company_location;

## 15. Average salary for each job title in each location, and what is the percentage of jobs for each job title in each location?
SELECT job_title, company_location, AVG(salary) AS average_salary, 
(COUNT(*) * 100 / (SELECT COUNT(*) FROM jobs WHERE company_location = j.company_location)) AS job_percentage 
FROM jobs j 
GROUP BY job_title, company_location;

## 16. Top 5 job titles with the highest average salaries, and what is the total number of jobs available for each job title?
SELECT job_title, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title 
ORDER BY average_salary DESC 
LIMIT 5;

## 17. Average salary for each job title, and what is the percentage of jobs for each job title in the dataset?
SELECT job_title, AVG(salary) AS average_salary, 
(COUNT(*) * 100 / (SELECT COUNT(*) FROM jobs)) AS job_percentage 
FROM jobs 
GROUP BY job_title;

## 18. Total number of jobs available for each year of experience, and what is the average salary for each year of experience?
SELECT experience_level, COUNT(*) AS num_jobs, AVG(salary) AS average_salary 
FROM jobs 
GROUP BY experience_level;
/*
EN, which refers to Entry-level / Junior.
MI, which refers to Mid-level / Intermediate.
SE, which refers to Senior-level / Expert.
EX, which refers to Executive-level / Director.
*/

## 19. Top 5 job titles with the highest average salaries in each location.
SELECT job_title, company_location, AVG(salary) AS average_salary 
FROM jobs 
WHERE job_title IN (SELECT job_title FROM jobs GROUP BY job_title ORDER BY AVG(salary) DESC) 
GROUP BY job_title, company_location;

## 20. Average salary for each degree level, and what is the total number of jobs available for each degree level?
SELECT degree_level, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY degree_level;

# 21. Top 5 job titles with the highest salaries, and name of the company that offers the highest salary for each job title?
SELECT job_title, MAX(salary) AS highest_salary, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY job_title 
ORDER BY highest_salary 
DESC LIMIT 5;

## 22. Total number of jobs available for each job title, and name of the company that offers the highest salary for each job title?
SELECT job_title, COUNT(*) AS num_jobs, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE salary = (SELECT MIN(salary) FROM jobs WHERE job_title = jobs.job_title) 
GROUP BY job_title, company_name;

## 23. Top 5 cities with the highest average salaries, and name of the company that offers the highest salary for each city?
SELECT company_location, AVG(salary) AS average_salary, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY company_location 
ORDER BY average_salary DESC 
LIMIT 5;

## 24. Average salary for each job title in each company, and rank of each job title within each company based on the average salary?
SELECT job_title, company_name, AVG(salary) AS average_salary, 
RANK() OVER (PARTITION BY company_name ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY job_title, company_name;

## 25. Total number of jobs available for each job title in each location, and rank of each job title within each location based on the total number of jobs?
SELECT job_title, company_location, COUNT(*) AS num_jobs, 
RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS job_rank 
FROM jobs 
GROUP BY job_title, company_location;

## 26. Average salary for each job title in each location, and name of the company that offers the highest salary for each job title in each location?
SELECT job_title, company_location, AVG(salary) AS average_salary, company_name 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE salary = (SELECT MAX(salary) FROM jobs WHERE job_title = j.job_title AND company_location = j.location) 
GROUP BY job_title, location, company_name;

## 27. Top 5 companies with the highest average salaries for data scientist positions, and rank of each company based on the average salary?
SELECT company_name, AVG(salary) AS average_salary, 
RANK() OVER (ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE job_title = 'Data Scientist' 
GROUP BY company_name 
ORDER BY average_salary DESC 
LIMIT 5;

## 28. Total number of jobs available for each year of experience in each location, and rank of each year of experience within each location based on the total number of jobs?
SELECT work_year, company_location, COUNT(*) AS num_jobs, 
RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS experience_rank 
FROM jobs 
GROUP BY work_year, company_location;

SELECT COUNT(*) FROM jobs 

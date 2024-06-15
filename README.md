# Data Science Salaries SQL Project

An analysis of data science salaries using SQL.

## Table of Contents

- [Introduction](#introduction)
- [Data Overview](#data-overview)
- [Some Queries](#some-queries)
- [Key Insights](#key-insights)
- [Conclusion](#conclusion)
- [Tableau Dashboard](#tableau-dashboard)

## Introduction

This project analyzes data science salaries using SQL. By exploring a dataset of salaries in the field of data science, we aim to understand various aspects such as salary distribution, factors influencing salaries, and trends over time.

## Data Overview

The dataset contains information about data science salaries, including details such as job title, years of experience, education level, location, and salary.

## Some Queries

The following SQL queries were used to analyze the dataset:

```sql
CREATE DATABASE Company;

USE Company;

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

## 4. Top 5 job titles with the highest average salaries, and what is the total number of jobs available for each job title?
SELECT job_title, AVG(salary) AS average_salary, COUNT(*) AS num_jobs 
FROM jobs 
GROUP BY job_title 
ORDER BY average_salary DESC 
LIMIT 5;

## 5. Average salary for each job title, and what is the percentage of jobs for each job title in the dataset?
SELECT job_title, AVG(salary) AS average_salary, 
(COUNT(*) * 100 / (SELECT COUNT(*) FROM jobs)) AS job_percentage 
FROM jobs 
GROUP BY job_title;

## 6. Total number of jobs available for each year of experience in each location, and rank of each year of experience within each location based on the total number of jobs?
SELECT work_year, company_location, COUNT(*) AS num_jobs, 
RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS experience_rank 
FROM jobs 
GROUP BY work_year, company_location;

SELECT COUNT(*) FROM jobs 

-> All queries are provide in the project file.

## Key Insights

- **Salary Distribution**: The average salary for data science roles varies based on job title, years of experience, education level, and location.
- **Experience Impact**: Salaries tend to increase with years of experience, but the rate of increase may vary by job title and location.
- **Education Influence**: Higher levels of education generally lead to higher salaries, but the effect may vary by job title and location.
- **Location Factor**: Salaries can significantly differ based on the geographical location of the job.

## Conclusion

This SQL project provided valuable insights into data science salaries, highlighting various factors influencing salary trends in the field. By analyzing the dataset, we gained a better understanding of the salary distribution, factors impacting salaries, and regional variations.

## Tableau Dashboard

- Project Link: [Tableau Dashboard](https://github.com/bhkritika/Tableau-DS-Salaries)

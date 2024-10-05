-- 1. How many rows are in the data_analyst_jobs table?
SELECT count (*)
FROM data_analyst_jobs;
-- Answer 1: 1793

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
-- Answer 2: "ExxonMobil"

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT count(location),location
FROM data_analyst_jobs
WHERE location='TN' or location='KY'
GROUP BY location;
-- Answer 3: TN=21 ; KY=6

-- 4. How many postings in Tennessee have a star rating above 4?
SELECT count(location) as number_of_postings
,star_rating
,location
FROM data_analyst_jobs
WHERE location='TN'
AND star_rating>4.0
GROUP BY star_rating,location;
-- Answer 4: 3 postings.

-- 5. How many postings in the dataset have a review count between 500 and 1000?
SELECT count(review_count) as number_of_reviews_between_500_1000
FROM data_analyst_jobs
WHERE review_count 
BETWEEN 500 and 1000;
-- Answer 5: 151 postings.

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT AVG(star_rating) as avg_rating
, location as state
FROM data_analyst_jobs
WHERE star_rating is not null
GROUP BY state
ORDER BY avg_rating DESC;
-- Answer 6: The State that shows the highest average rating is NE.

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT count(DISTINCT(title))
FROM data_analyst_jobs
-- Answer 7: 881 Uniqe Job Titles.

-- 8. How many unique job titles are there for California companies?
SELECT count(DISTINCT(title))
FROM data_analyst_jobs
WHERE location='CA'
-- Answer 8: 230 Unique Job Titles.

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
--SUM ALL THE REVIEWS OF THE COMPANY IN EACH STATE
SELECT company
, AVG(star_rating)
, sum(distinct review_count)
FROM data_analyst_jobs
GROUP BY company
HAVING sum(distinct review_count)>5000
AND company IS NOT null
ORDER by company
--TAKING ALL THE COMPANIES WITH MORE THAN 5000 reviews in one singular state
SELECT company
, AVG(star_rating) as avg_a
FROM data_analyst_jobs
WHERE review_count>5000
AND company IS NOT null
GROUP BY company
-- CODING CHECK:
SELECT company, star_rating, review_count, location 
FROM data_analyst_jobs
ORDER BY company
-- Answer 9: there are 70 Companies with more than 5000 reviews across all locations.

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company
, AVG(star_rating)
FROM data_analyst_jobs
GROUP BY company 
HAVING min(review_count)>5000 
AND company IS NOT null
ORDER BY avg(star_rating) DESC
-- Answer 10:There are 6 companies with with the highest star rating as 4.1 and those are Nike, Unilever, General Motors, Kaiser Permanente, Microsoft and American Express.

-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT count(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%' 
-- Answer 11: 774 different job titles

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT title 
FROM data_analyst_jobs 
WHERE title NOT ILIKE '%analyst%'
AND title NOT ILIKE'%analytics%'
-- Answer 12: 4 titles and they have Tableau as common word

--BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

--Disregard any postings where the domain is NULL.
--Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
--Which three industries are in the top 3 on this list? How many jobs have been listed for more than 3 weeks for each of the top 3?

SELECT COUNT(d.title), d.domain
FROM data_analyst_jobs AS d
WHERE d.days_since_posting >21 
	AND d.title IS NOT NULL 
	AND d.domain IS NOT NULL
	AND skill ILIKE '%SQL%'
GROUP BY d.domain
ORDER BY COUNT(d.title) DESC;
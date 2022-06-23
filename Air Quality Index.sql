--Let's look at the table
SELECT *
 FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']

 --I am going to do exploratory analysis of the year 2021 so I am going to drop 4 columns i.e. 2020, 2019, 2018 and 2017.

 ALTER TABLE [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']
 DROP COLUMN [2020], [2019], [2018], [2017];

 --Breaking out City column into individual column (City, Country)

 SELECT
 PARSENAME (REPLACE(City, ',', '.'), 2),
 PARSENAME (REPLACE(City, ',', '.'), 1)
 FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$'];

 ALTER TABLE [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']
 ADD Country Nvarchar(255);

 UPDATE [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']
 SET Country = PARSENAME (REPLACE(City, ',', '.'), 1)

UPDATE [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']
SET City = PARSENAME (REPLACE(City, ',', '.'), 2)
 

 --Let's see if everything is updated or not

 SELECT *
 FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$'];

 -- Adding column 'LevelofConcern' based on the air quality index in the year 2021

 SELECT [2021],
 CASE WHEN FLOOR([2021]) <= 50 THEN 'Good'
      WHEN FLOOR([2021]) >= 51 AND FLOOR([2021]) <= 100 THEN 'Moderate'
	  WHEN FLOOR([2021]) >= 101 AND FLOOR([2021]) <= 150 THEN 'Unhealthy for Sensitive Groups'
	  WHEN FLOOR([2021]) >= 151 AND FLOOR([2021]) <= 200 THEN 'Unhealthy'
	  WHEN FLOOR([2021]) >= 201 AND FLOOR([2021]) <= 300 THEN 'Very Unhealthy'
	  ELSE 'Hazardous' END
	  AS LevelofConcern
 FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$'];

 ALTER TABLE [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']
 ADD LevelofConcern Nvarchar(255);

 UPDATE [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']
 SET LevelofConcern = CASE WHEN FLOOR([2021]) <= 50 THEN 'Good'
      WHEN FLOOR([2021]) >= 51 AND FLOOR([2021]) <= 100 THEN 'Moderate'
	  WHEN FLOOR([2021]) >= 101 AND FLOOR([2021]) <= 150 THEN 'Unhealthy for Sensitive Groups'
	  WHEN FLOOR([2021]) >= 151 AND FLOOR([2021]) <= 200 THEN 'Unhealthy'
	  WHEN FLOOR([2021]) >= 201 AND FLOOR([2021]) <= 300 THEN 'Very Unhealthy'
	  ELSE 'Hazardous' END

SELECT *
FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$'];

--Let's look at distict countries and cities

SELECT DISTINCT(Country)
FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']; --There are in total 118 countries

SELECT COUNT(DISTINCT(City)) AS Total_number_of_distinct_cities
FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']; -- There are in total 6113 cities

-- Number of rows in the table 

SELECT COUNT(*) AS Number_of_rows_in_the_table
FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$'];


-- Removing the Duplicates
WITH RowNumCTE AS(
  SELECT 
    *, 
    ROW_NUMBER() OVER(
      PARTITION BY City, Country
      ORDER BY 
        Rank
    ) AS row_num 
  FROM [PROJECT 1].[dbo].['AIR QUALITY INDEX (by cities) -$']
)


DELETE
From RowNumCTE
Where row_num > 1








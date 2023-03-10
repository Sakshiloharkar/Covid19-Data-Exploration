/*CovidDeaths Table*/

SELECT * FROM CovidDeaths
WHERE CONTINENT IS NOT NULL;

/*CovidVaccinations Table*/
SELECT * FROM CovidVaccinations
WHERE CONTINENT IS NOT NULL;

/*Selecting Required Columns*/
SELECT LOCATION,DATE,TOTAL_CASES,NEW_CASES,TOTAL_DEATHS,POPULATION
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
ORDER BY LOCATION,DATE;

/*To find out the death percentage locally*/
SELECT LOCATION,DATE,TOTAL_CASES,TOTAL_DEATHS,(TOTAL_DEATHS/TOTAL_CASES)*100 AS DEATH_PERCENT
FROM CovidDeaths
WHERE LOCATION = 'INDIA' AND CONTINENT IS NOT NULL
ORDER BY DATE;

/*To find the death percentage globally*/
SELECT LOCATION,DATE,TOTAL_CASES,TOTAL_DEATHS,(TOTAL_DEATHS/TOTAL_CASES)*100 AS DEATH_PERCENT
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
ORDER BY LOCATION,DATE;

/*Global death percent according to new_cases and new_deaths*/
SELECT DATE, SUM(NEW_CASES) AS TOTAL_NEWCASES,SUM(CAST(NEW_DEATHS AS int)) AS TOTAL_NEWDEATHS,
(SUM(CAST(NEW_DEATHS AS int))/SUM(NEW_CASES))*100 AS GOBAL_DEATH_PERCENT FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY DATE
ORDER BY DATE,SUM(NEW_CASES);

/*The Overall Global Death Percent*/
SELECT SUM(NEW_CASES) AS TOTAL_NEWCASES,SUM(CAST(NEW_DEATHS AS int)) AS TOTAL_NEWDEATHS,
(SUM(CAST(NEW_DEATHS AS int))/SUM(NEW_CASES))*100 AS GOBAL_DEATH_PERCENT FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
ORDER BY SUM(NEW_CASES),SUM(CAST(NEW_DEATHS AS int));

/*To find the Infected Population Percentage Locally (India)*/
SELECT LOCATION,DATE,TOTAL_CASES,POPULATION,(TOTAL_CASES/POPULATION)*100 AS INFECTED_POPULATION_PERCENT
FROM CovidDeaths
WHERE LOCATION = 'INDIA' AND CONTINENT IS NOT NULL
ORDER BY LOCATION,DATE;

/*To find the Infected Population Percentage Globally*/
SELECT LOCATION,DATE,TOTAL_CASES,POPULATION,(TOTAL_CASES/POPULATION)*100 AS INFECTED_POPULATION_PERCENT
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
ORDER BY LOCATION,DATE;

/*To find out the countries with the highest infection rates*/
SELECT LOCATION,MAX(TOTAL_CASES) AS MAX_INFECTION, POPULATION, 
MAX((TOTAL_CASES/POPULATION))*100 AS HIGHEST_INFECTED_POPULATION_PERCENT FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY LOCATION, POPULATION
ORDER BY HIGHEST_INFECTED_POPULATION_PERCENT DESC;

/*Countries with the highest death counts*/
SELECT LOCATION AS COUNTRIES, MAX(CAST(TOTAL_CASES AS int)) AS MAX_DEATH_COUNT FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY LOCATION
ORDER BY MAX_DEATH_COUNT DESC;

/*Continents with the highest death counts*/
SELECT CONTINENT, MAX(CAST(TOTAL_CASES AS int)) AS MAX_DEATH_COUNT FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY CONTINENT
ORDER BY MAX_DEATH_COUNT DESC;

/*Using JOINS to combine the covid_deaths and covid_vaccine tables*/
SELECT * FROM CovidDeaths D
JOIN CovidVaccinations V
ON D.LOCATION=V.LOCATION AND D.DATE=V.DATE
WHERE D.CONTINENT IS NOT NULL;

/*To find out the population vs the number of people vaccinated*/
SELECT D.CONTINENT,D.LOCATION,D.DATE,D.POPULATION,V.NEW_VACCINATIONS FROM CovidDeaths D
JOIN CovidVaccinations V
ON D.LOCATION=V.LOCATION AND D.DATE=V.DATE
WHERE D.CONTINENT IS NOT NULL
ORDER BY D.LOCATION,D.DATE;

/*Using Window function to find Rolling Count to find out New Vaccines Received*/
SELECT D.CONTINENT,D.LOCATION,D.DATE,D.POPULATION,V.NEW_VACCINATIONS,
SUM(CAST(V.NEW_VACCINATIONS AS INT)) OVER(PARTITION BY D.LOCATION ORDER BY D.LOCATION,D.DATE) AS ROLLING_COUNT_VAC
FROM CovidDeaths D JOIN CovidVaccinations V
ON D.LOCATION=V.LOCATION AND D.DATE=V.DATE
WHERE D.CONTINENT IS NOT NULL
ORDER BY D.LOCATION,D.DATE;

/*To find the percentage of the population that received new vaccinations*/
METHOD 1:

SELECT D.CONTINENT,D.LOCATION,D.DATE,D.POPULATION,V.NEW_VACCINATIONS,
SUM(CAST(V.NEW_VACCINATIONS AS INT)) OVER(PARTITION BY D.LOCATION ORDER BY D.LOCATION,D.DATE) AS ROLLING_COUNT_VAC,
(SUM(CAST(V.NEW_VACCINATIONS AS INT)) OVER(PARTITION BY D.LOCATION ORDER BY D.LOCATION,D.DATE)/POPULATION)*100 AS TOTAL_VAC_PERCENT
FROM CovidDeaths D JOIN CovidVaccinations V
ON D.LOCATION=V.LOCATION AND D.DATE=V.DATE
WHERE D.CONTINENT IS NOT NULL
ORDER BY D.LOCATION,D.DATE;

METHOD 2: USING CTE

WITH TOTALVACPERCENT AS(
SELECT D.CONTINENT,D.LOCATION,D.DATE,D.POPULATION,V.NEW_VACCINATIONS,
SUM(CAST(V.NEW_VACCINATIONS AS INT)) OVER(PARTITION BY D.LOCATION ORDER BY D.LOCATION,D.DATE) AS ROLLING_COUNT_VAC
FROM CovidDeaths D JOIN CovidVaccinations V
ON D.LOCATION=V.LOCATION AND D.DATE=V.DATE
WHERE D.CONTINENT IS NOT NULL
)
SELECT *,((ROLLING_COUNT_VAC/POPULATION)*100)AS TOTAL_VAC_PERCENT FROM 
TOTALVACPERCENT;



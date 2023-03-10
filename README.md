# Covid19-Data-Exploration

The data that I used in this project is on COVID-19. As I did this project a while back, the data might not be up to date. To get the updated data, go to www.ourworldindata.org which is a great free resource to obtain public datasets. After downloading the data, I eliminated some irrelevant columns from the dataset using MS Excel and segregated the dataset into two portions, namely CovidDeaths and CovidVaccinations. I did this because it will help in making the SQL queries simpler and help later in using JOINS. After saving the dataset into two different files, now it was ready to be uploaded to SSMS using SQL Server.

# Concepts Applied

1. Complex Queries

2. Common Table Expressions

3. Joins

4. Window Functions

# Objective

1. To spend time with the data and get familiar with it.

2. To find out the death percentage locally and globally.

3. To find out the infected population percentage locally and globally.

4. To find out countries with the highest infection rates.

5. To find out the countries and continents with the highest death counts.

6. Using JOINS to combine the covid_deaths and covid_vaccine tables.

7. To find out the population vs the number of people vaccinated.

8. To find out the Vaccinated Population and new Vaccinated Population.


In order to see the data, I wrote the following query:


# CovidDeaths Table:

select * from CovidDeaths;


<img width="5000" alt="image" src="https://user-images.githubusercontent.com/70011358/223366213-7a5fb865-3c45-4c1f-9de1-ebf6e29c436f.png">


# CovidVaccinations Table:

select * from CovidVaccinations;


<img width="5000" alt="image" src="https://user-images.githubusercontent.com/70011358/223366720-36cbc3ab-4881-4159-bf13-291d73a07d7c.png">


If you want to see all the SQL queries that I have used to clean and explore this dataser, please click on this <a href = "https://github.com/Sakshiloharkar/Covid19-Data-Exploration/blob/main/Covid19%20Data%20Exploration.sql">Link</a>

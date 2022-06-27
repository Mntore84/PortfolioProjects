
/* 

Queries used for Tableau Project

*/

-- 1.

Select SUM(new_cases) as total_cases, SUM(Cast(new_deaths as int)) as total_deaths, SUM(Cast(new_deaths as int))/SUM(New_cases)*100 as Death_Percentage
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
Where continent is not null
--Group by date
Order by 1,2

-- Just a double check bases off the data provided
--numbers are extremely close so we will keep them - The Second includes "International" Location


--Select SUM(new_cases) as total_cases, SUM(Cast(new_deaths as int)) as total_deaths, SUM(Cast(new_deaths as int))/SUM(New_cases)*100 as Death_Percentage
--From PortfolioProject1..CovidDeaths
--Where location like '%states%'
--Where location = 'World'
--Group by date
--Order by 1,2


-- 2.

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(Cast(new_deaths as int)) as Total_Death_Count
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
Where continent is null
and location not in ('World', 'European Union', 'International', 'Low income', 'Upper middle income', 'Lower middle income', 'High income')
Group by location
Order by Total_Death_Count DESC


-- 3. 

Select location, population, MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/population))*100 as Percent_Population_Infected
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
Group by location, population
Order by Percent_Population_Infected DESC


-- 4. 

Select location, population, date, MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/population))*100 as Percent_Population_Infected
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
Group by location, population, date
Order by Percent_Population_Infected DESC
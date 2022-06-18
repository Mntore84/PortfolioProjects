
Select *
From PortfolioProject1..CovidDeaths
where continent is not null
order by 3,4


--Select *
--From PortfolioProject1..CovidVaccinations
--order by 3,4

--Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject1..CovidDeaths
where continent is not null
order by 1,2



-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract Covid in your country
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject1..CovidDeaths
Where location like '%states%'
order by 1,2


--Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

Select Location, date, population, total_cases,  (total_cases/population)*100 as Infection_Rate
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
order by 1,2


--Looking at countries with highest infection rate compared to population

Select Location, population, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/population))*100 as Infection_Rate
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
group by location, population
order by Infection_Rate DESC


-- Showing countries with highest death count per population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount DESC



--LET's BREAK THINGS DOWN BY CONTINENT


-- Showing the continents with highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
where continent is not null
group by continent
order by TotalDeathCount DESC




-- GLOBAL NUMBERS

-- Showing Death Percentage for each date
Select date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, (Sum(Cast(new_deaths as int))/Sum(new_cases))*100 as Death_Percentage
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
where continent is not null
group by date
order by 1,2


--Showing Death Percentage overall since Covid began
Select SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, (Sum(Cast(new_deaths as int))/Sum(new_cases))*100 as Death_Percentage
From PortfolioProject1..CovidDeaths
--Where location like '%states%'
where continent is not null
--group by date
order by 1,2



-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as Rolling_Count_Vaccinated,
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3



-- USE CTE

With PopvsVac (Contintent, Location, Date, Population, New_Vaccinations, Rolling_Count_Vaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as Rolling_Count_Vaccinated
--, (Rolling_Count_Vaccinated/population)*100
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)

Select * , (Rolling_Count_Vaccinated/Population)*100 as Vaccination_Percentage
FROM PopvsVac




-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Rolling_Count_Vaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as Rolling_Count_Vaccinated
--, (Rolling_Count_Vaccinated/population)*100
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

Select * , (Rolling_Count_Vaccinated/Population)*100 as Vaccination_Percentage
FROM #PercentPopulationVaccinated



--Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as Rolling_Count_Vaccinated
--, (Rolling_Count_Vaccinated/population)*100
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3



Select * 
FROM PercentPopulationVaccinated



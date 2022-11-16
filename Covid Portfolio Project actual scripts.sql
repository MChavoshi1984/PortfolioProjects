SELECT *
FROM PortfolioProject. .CovidDeaths
where continent is not null
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject. .CovidVaccinations
--ORDER BY 3,4

--Select Data that we are going to be using

Select Location,date,total_cases,new_cases,total_deaths,population
FROM PortfolioProject. .CovidDeaths
where continent is not null
order by 1,2


--Looking at Total Cases vs Total Deaths
--Shows likelihoo of dying if you contract covid in your country
Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject. .CovidDeaths
where location like '%Australia%'
and continent is not null
order by 1,2

--Looking at Total Cases vs Population
Select Location,date,population,total_cases,(total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProject. .CovidDeaths
--where location like '%Australia%'
where continent is not null
order by 1,2

--Looking at Countries With Highest Infection Rate Compared to Population
Select Location,population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject. .CovidDeaths
--where location like '%Australia%'
where continent is not null
Group by Location,population
order by PercentPopulationInfected desc

--Showing Countries with Highest Death Count per Population
Select Location,MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject. .CovidDeaths
--where location like '%Australia%'
where continent is not null
Group by Location
order by TotalDeathCount desc



--LET'S BREAK THINGS DOWN BY CONTINENT

--Showing continents with the highest death count per population

Select continent,MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject. .CovidDeaths
--where location like '%Australia%'
where continent is not null
Group by continent
order by TotalDeathCount desc

--GLOBAL NUMBERS
Select SUM(new_cases)as total_cases,SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DEathPercentage
FROM PortfolioProject. .CovidDeaths
--where location like '%Australia%'
where continent is not null
order by 1,2



--Looking at Total Population vs Vaccinations

select dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations
,SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
From PortfolioProject. .CovidDeaths as dea
join PortfolioProject. .CovidVaccinations as vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3




-- List each country name where the population is larger than that of 'Russia'. 
select name from world
where population > (select population from world where name = 'russia');

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
select name from world
where continent = 'europe' and gdp/population > (select gdp/population from world where name = 'united kingdom');

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
select name, continent from world
where continent = (select continent from world where name = 'argentina') or continent = (select continent from world where name = 'australia')
order by name;

-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.
select name, population from world
where population > (select population from world where name = 'canada') and population < (select population from world where name = 'poland');

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
select name, concat(round(((population / (select population from world where name = 'germany')) * 100), 0), '%') from world
where continent = 'europe'

-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) 
select name from world
where gdp > (select max(gdp) from world where continent = 'europe');

-- Find the largest country (by area) in each continent, show the continent, the name and the area: 
select continent, name, area from world a
where area = (select max(area) from world b where a.continent = b.continent);

-- List each continent and the name of the country that comes a alphabetically.
select continent, name from world a
where name = (select min(name) from world b where a.continent = b.continent order by name);

-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. 
select name, continent, population from world a
where not exists (select * from world b where a.continent = b.continent and population > 25000000);

-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
select name, continent from world a
where population > all (select 3 * population from world b where a.continent = b.continent and a.name != b.name);

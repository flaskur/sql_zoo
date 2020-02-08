-- Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries.
select name, continent, population from world;

-- How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros. 
select name from world
where population > 200000000;

-- Give the name and the per capita GDP for those countries with a population of at least 200 million. 
select name, gdp/population from world
where population >= 200000000;

-- Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions. 
select name, population/1000000 from world
where continent = 'south america';

-- Show the name and population for France, Germany, Italy 
select name, population from world
where name in ('france', 'germany', 'italy');

-- Show the countries which have a name that includes the word 'United' 
select name from world
where name like '%united%';

-- Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million. Show the countries that are big by area or big by population. Show name, population and area.
select name, population, area from world
where area > 3000000 or population > 250000000;

-- Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
select name, population, area from world
where area > 3000000 xor population > 250000000;

-- Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places. 
select name, round(population/1000000, 2), round(gdp/1000000000, 2) from world
where continent = 'south america';

-- Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000. 
select name, round(gdp/population, -3) from world
where gdp >= 1000000000000;

-- Show the name and capital where the name and the capital have the same number of characters.
select name, capital from world
where length(name) = length(capital);

-- Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
select name, capital from world
where left(name, 1) = left(capital, 1) and name != capital;

-- Find the country that has all the vowels and no spaces in its name.
select name from world
where name not like '% %' and 
name like '%a%' and
name like '%e%' and
name like '%i%' and
name like '%o%' and
name like '%u%';
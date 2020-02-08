-- Change the query shown so that it displays Nobel prizes for 1950. 
select yr, subject, winner from nobel
where yr = 1950;

-- Show who won the 1962 prize for Literature. 
select winner from nobel
where yr = 1962 and subject = 'literature';

-- Show the year and subject that won 'Albert Einstein' his prize. 
select yr, subject from nobel
where winner = 'albert einstein';

-- Give the name of the 'Peace' winners since the year 2000, including 2000. 
select winner from nobel
where subject = 'peace' and yr >= 2000;

-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. 
select yr, subject, winner from nobel
where subject = 'literature' and yr between 1980 and 1989;

-- Show all details of the presidential winners: Theodore Roosevelt, Woodrow Wilson, Jimmy Carter, Barack Obama
select * from nobel
where winner in ('theodore roosevelt', 'woodrow wilson', 'jimmy carter', 'barack obama');

-- Show the winners with first name John 
select winner from nobel
where winner like 'john %';

-- Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
select * from nobel
where (subject = 'physics' and yr = 1980) or (subject = 'chemistry' and yr = 1984);

-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
select * from nobel
where yr = 1980 and subject not in ('chemistry', 'medicine');

-- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004) 
select * from nobel
where (subject = 'medicine' and yr < 1910) or (subject = 'literature' and yr >= 2004);

-- Find all details of the prize won by PETER GRÜNBERG 
select * from nobel
where winner like 'peter gr_nberg';

-- Find all details of the prize won by EUGENE O'NEILL
select * from nobel
where winner = "eugene o\'neill";

-- List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
select winner, yr, subject from nobel
where winner like 'sir %'
order by yr desc, winner asc;

-- Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
select winner, subject from nobel
where yr = 1984
order by subject in ('chemistry', 'physics'), subject, winner;
select winner, subject from nobel
where yr = 1984
order by case when subject in ('chemistry', 'physics') then 1 else 0 end, subject, winner;


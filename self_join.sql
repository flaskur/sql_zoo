-- How many stops are in the database. 
select count(stops.id) from stops;

-- Find the id value for the stop 'Craiglockhart' 
select stops.id from stops
where name = 'craiglockhart';

-- Give the id and the name for the stops on the '4' 'LRT' service. 
select stops.id, stops.name from stops join route on (stops.id = route.stop)
where route.num = '4' and route.company = 'LRT';

-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes. 
select route.company, route.num, count(*) from route
where stop = '149' or stop = '53'
group by route.company, route.num having count(*) = 2;

-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road. 
select x.company, x.num, x.stop, y.stop from route x join route y on (x.company = y.company and x.num = y.num)
where x.stop = '53' and y.stop = '149';

-- The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross' 
select routex.company, routex.num, stopx.name, stopy.name from route routex join route routey on (routex.company = routey.company and routex.num = routey.num)
join stops stopx on (routex.stop = stopx.id)
join stops stopy on (routey.stop = stopy.id)
where stopx.name = 'Craiglockhart' and stopy.name = 'London Road';

-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') 
select distinct x.company, x.num from route x join route y on (x.company = y.company and x.num = y.num)
where x.stop = '115' and y.stop = '137';

-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' 
select distinct routex.company, routex.num from route routex join route routey on (routex.company = routey.company and routex.num = routey.num)
join stops stopx on (routex.stop = stopx.id)
join stops stopy on (routey.stop = stopy.id)
where stopx.name = 'Craiglockhart' and stopy.name = 'Tollcross';

-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services. 
select distinct stopx.name, routex.company, routex.num from route routex join route routey on (routex.company = routey.company and routex.num = routey.num)
join stops stopx on (routex.stop = stopx.id)
join stops stopy on (routey.stop = stopy.id)
where stopx.name = 'Craiglockhart' or stopy.name = 'Craiglockhart';

-- Find the routes involving two buses that can go from Craiglockhart to Lochend. Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus. 
select distinct routex.num, routex.company, stopx.name, routez.num, routez.company from route routex join route routey on (routex.company = routey.company and routex.num = routey.num)
join (route routez join route routew on (routez.company = routew.company and routez.num = routew.num))
join stops stopx on (routex.stop = stopx.id)
join stops stopy on (routey.stop = stopy.id)
join stops stopz on (routez.stop = stopz.id)
join stops stopw on (routew.stop = stopw.id)
where stopx.name = 'Craiglockhart'
and stopw.name = 'Lockend'
and stopy.name = stopz.name
order by length(routex.num), routey.num, stopy.id, length(routez.num), routew.num;
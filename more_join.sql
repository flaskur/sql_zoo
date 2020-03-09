-- List the films where the yr is 1962 [Show id, title] 
select id, title from movie
where yr = 1962;

-- Give year of 'Citizen Kane'. 
select yr from movie
where title = 'citizen kane';

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 
select id, title, yr from movie
where title like '%star trek%'
order by yr asc;

-- What id number does the actor 'Glenn Close' have? 
select id from actor
where name = 'glenn close';

-- What is the id of the film 'Casablanca' 
select id from movie
where title = 'casablanca';

-- Obtain the cast list for 'Casablanca'. what is a cast list? Use movieid=11768, (or whatever value you got from the previous question) 
select name from casting join actor on casting.actorid = actor.id
where movieid = 11768;

-- Obtain the cast list for the film 'Alien' 
select name from casting join actor on casting.actorid = actor.id
where movieid = (select id from movie where title = 'alien');

-- List the films in which 'Harrison Ford' has appeared 
select title from movie join casting on movie.id = casting.movieid
where actorid = (select id from actor where name = 'harrison ford');

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 
select title from movie join casting on movie.id = casting.movieid
where actorid = (select id from actor where name = 'harrison ford') and ord != 1;

-- List the films together with the leading star for all 1962 films. 
select title, name from movie join casting join actor on (movie.id = casting.movieid and casting.actorid = actor.id)
where yr = 1962 and ord = 1;

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
select yr, count(title) from movie join casting on movie.id = casting.movieid join actor on casting.actorid = actor.id
where name = 'rock hudson'
group by yr
having count(title) > 2;

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
select title, name from movie join casting join actor on movie.id = casting.movieid and casting.actorid = actor.id
where ord = 1 and movie.id in (select movie.id from movie join casting join actor on movie.id = casting.movieid and casting.actorid = actor.id where actor.name = 'julie andrews');

-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 
select distinct name from movie join casting join actor on (movie.id = casting.movieid and casting.actorid = actor.id)
where actorid in (
  select actorid from casting
  where ord = 1
  group by actorid
  having count(actorid) >= 15
)
order by name;

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
select title, count(actorid) from movie join casting
on (movie.id = casting.movieid)
where yr = 1978
group by movieid, title
order by count(actorid) desc, title asc;

-- List all the people who have worked with 'Art Garfunkel'. 
select distinct name from casting join actor
on (casting.actorid = actor.id)
where name != 'art garfunkel'
and movieid in (
  select movieid from movie join casting join actor
  on (movie.id = casting.movieid and casting.actorid = actor.id)
  where actor.name = 'art garfunkel'
);
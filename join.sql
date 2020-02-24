-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
select matchid, player from goal
where teamid = 'ger';

-- Show id, stadium, team1, team2 for just game 1012
select id, stadium, team1, team2 from game
where id = 1012;

-- Modify it to show the player, teamid, stadium and mdate for every German goal.
select goal.player, goal.teamid, game.stadium, game.mdate from game join goal on(game.id = goal.matchid)
where goal.teamid = 'ger';

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
select game.team1, game.team2, goal.player from game join goal on (game.id = goal.matchid)
where goal.player like 'Mario%';

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
select goal.player, goal.teamid, eteam.coach, goal.gtime from goal join eteam on (goal.teamid = eteam.id)
where goal.gtime <= 10;

-- List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
select game.mdate, eteam.teamname from game join eteam on (game.team1 = eteam.id)
where eteam.coach = 'Fernando Santos';

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
select goal.player from game join goal on (game.id = goal.matchid)
where game.stadium = 'national stadium, warsaw';

-- Instead show the name of all players who scored a goal against Germany.
select distinct goal.player from game join goal on (game.id = goal.matchid)
where (goal.teamid = game.team1 and game.team2 = 'ger') or (game.team1 = 'ger' and goal.teamid = game.team2);

-- Show teamname and the total number of goals scored.
select eteam.teamname, count(goal.teamid) from eteam join goal on (eteam.id = goal.teamid)
group by eteam.teamname;

-- Show the stadium and the number of goals scored in each stadium. 
select game.stadium, count(goal.matchid) from game join goal on (game.id = goal.matchid)
group by game.stadium;

-- For every match involving 'POL', show the matchid, date and the number of goals scored.
select goal.matchid, game.mdate, count(goal.matchid) from game join goal on (game.id = goal.matchid)
where game.team1 = 'pol' or game.team2 = 'pol'
group by matchid;

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
select goal.matchid, game.mdate, count(goal.matchid) from game join goal on (game.id = goal.matchid)
where goal.teamid = 'ger'
group by goal.matchid;

-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
select game.mdate, game.team1, sum(case when goal.teamid = game.team1 then 1 else 0 end) score1, game.team2, sum(case when goal.teamid = game.team2 then 1 else 0 end) score2 from game left outer join goal on (game.id = goal.matchid)
group by id order by mdate, matchid, team1, team2;
